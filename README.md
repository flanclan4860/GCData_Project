
## Introduction

This is the Course Project for Coursera Getting and Cleaning Data.

It contains one R script called run_analysis.R that does the following. 

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The new tidy data set was written to a file as follows:  
write.table(df2, "./meanData.txt", row.name=FALSE)  

To examine the data set, read the file as follows:  
meanData <- tbl_df(read.table("./meanData.txt", header=TRUE))  

