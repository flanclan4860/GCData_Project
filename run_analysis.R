# Getting and Cleaning Data, Coursera, Course Project
# January 25, 2015

library(dplyr)

# Read data from files
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")

subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")

features <- read.table("./UCI HAR Dataset/features.txt")
activities <- read.table("./UCI HAR Dataset/activity_labels.txt")

# Read in colNames file, 
# created this file by editing features.txt, and cleaning up 
# the variable names
colNames <- read.table("./UCI HAR Dataset/colNames.txt")

# Combine test and training data
df <- rbind(x_train, x_test)
df <- tbl_df(df)

# Add raw column names to the data set, from features.txt 
names(df) <- features[, 2]

# Extract measurements on mean and std dev, 
# by finding which variables contain the string "mean()" or "std()"
meanCols <- grep("mean()", features[,2], fixed=TRUE)
stdCols <- grep("std()", features[,2], fixed=TRUE)
extractCols <- sort(c(meanCols,stdCols))

df <- df[,extractCols]


# Name the activities
#  Combine train and test activity data
activity_num <- rbind(y_train, y_test)
#  Create a new column, converting activity number to activity name
activity_named <- transmute(activity_num, Activity=activities[activity_num[,1],2])
df <- cbind(activity_named, df)

# Add a column for the subject
#  Combine train and test subject data
subject <- rbind(subject_train, subject_test)
#  Add a column header
names(subject) <- c("Subject")
df <- cbind(subject, df)

# Label the variables, with "cleaned up" variable names
names(df)[3:ncol(df)] <- as.character(colNames[,1])

# Create dataset with average of each variable for 
# each activity and each subject
df2 <- df %>% group_by(Subject, Activity) %>% summarise_each(funs(mean))

# Write the new data set to a file
write.table(df2, "./meanData.txt", row.name=FALSE)
# Read the data set back in to verify correctness
meanData <- tbl_df(read.table("./meanData.txt", header=TRUE))

