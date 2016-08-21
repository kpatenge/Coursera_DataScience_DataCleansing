Getting and Cleaning Data - Course Assignment

As part of the course assignment a R script called run_analysis.R should be created that does the following:
(1) Merges the training and the test sets to create one data set.
(2) Extracts only the measurements on the mean and standard deviation for each measurement.
(3) Uses descriptive activity names to name the activities in the data set
(4) Appropriately labels the data set with descriptive variable names.
(5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The data set is downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
and extracted preserving its original folder structure.


The R Script uses the following packages:
- reshape2

Step by step:
(1) Merges the training and the test sets to create one data set.
- Load test data
- Load train data
- Merge data sets (combine data sets by rows)
- Load feature labels. Create vector with feature labels. Assign feature labels to features data.

(2) Extracts only the measurements on the mean and standard deviation for each measurement.

- Create a logical vector to indicate which columns contain either mean() or std()
- Extract subset of mean() and std() columns from features

(3) Uses descriptive activity names to name the activities in the data set
- Load activity labels. 
- Merge activities with activity labels. 
- Remove redundant activity information.

(4) Appropriately labels the data set with descriptive variable names.
- Bind together all data sets to a tidy data set

(5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
- Melt data
- Reshape for each activity and subject using mean. Sort data frame.
- Reorder columns
- Reindex rows
- Create output file from tidy data

