#######################################################
# You should create one R script called run_analysis.R that does the following:
# (1) Merges the training and the test sets to create one data set.
# (2) Extracts only the measurements on the mean and standard deviation for each measurement.
# (3) Uses descriptive activity names to name the activities in the data set
# (4) Appropriately labels the data set with descriptive variable names.
# (5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

rm(list = ls())

# Load libraries
library(reshape2)

#######################################################
# Step by step

### (1) Merges the training and the test sets to create one data set.

# Load test data
subject_test <- read.table("./test/subject_test.txt", col.names=c("subject"))
features_test <- read.table("./test/X_test.txt")
activities_test <- read.table("./test/y_test.txt", col.names=c("activity"))

# Load train data
subject_train <- read.table("./train/subject_train.txt", col.names=c("subject"))
features_train <- read.table("./train/X_train.txt")
activities_train <- read.table("./train/y_train.txt", col.names=c("activity"))

# Merge data sets (combine data sets by rows)
subject_test_train <- rbind(subject_test, subject_train)
features_test_train <- rbind(features_test, features_train)
activities_test_train <- rbind(activities_test, activities_train)

# Load feature labels. Create vector with feature labels. Assign feature labels to features data.
feature_labels <- read.table("features.txt", sep=" ", col.names=c("feature", "feature_label"))
feature_labels <- feature_labels$feature_label
colnames(features_test_train) <- feature_labels


### (2) Extracts only the measurements on the mean and standard deviation for each measurement.

# Create a logical vector to indicate which columns contain either mean() or std()
features_mean_std <- grepl("mean\\(\\)|std\\(\\)",feature_labels)

# Extract subset of mean() and std() columns from features
features <- features_test_train[,features_mean_std]


### (3) Uses descriptive activity names to name the activities in the data set

# Load activity labels. 
activity_labels <- read.table("activity_labels.txt", sep=" ", col.names=c("activity","activity_label"))

# Merge activities with activity labels. 
activities_test_train_label <- merge(activities_test_train, activity_labels, by="activity")

# Remove redundant activity information.
activities_test_train_label$activity <- NULL


### (4) Appropriately labels the data set with descriptive variable names.

# Bind together all data sets to a tidy data set
df_tidy_data <- cbind(subject_test_train, activities_test_train_label, features)


### (5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Melt data
df_tidy_data_2 <- melt(df_tidy_data, id.vars=c("activity_label","subject"), measure.vars=3:68)
        
# Reshape for each activity and subject using mean. Sort data frame.
df_tidy_data_2 <- dcast(df_tidy_data_2, activity_label + subject ~ variable, mean)
df_tidy_data_2 <- df_tidy_data_2[order(df_tidy_data_2$subject, df_tidy_data_2$activity_label),]

# Reorder columns
df_tidy_data_2 <- df_tidy_data_2[,c(2,1,3:68)]

# Reindex rows
rownames(df_tidy_data_2) <- 1:nrow(df_tidy_data_2)

# Create output file from tidy data
write.table(df_tidy_data_2, file="tidy_dataset.txt", row.names=FALSE)


