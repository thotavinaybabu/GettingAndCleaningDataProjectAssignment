# GettingAndCleaningDataProjectAssignment
Getting and Cleaning Data Course Project :
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The R script, run_analysis.R, does the following:

1.Download the dataset if it does not already exist in the working directory

2.Load the activity and feature info

3.Loads both the training and test datasets, keeping only those columns which has a mean or standard deviation

4.Loads the activity and subject data for each dataset, and merges those columns with the dataset

5.Merge data frames of different columns to form one data table -saved as "merged_tidy_data.txt""

6.Converts the activity and subject columns into factors

7.Creates a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair .The end result is shown in the file "calculated_mean_data.txt".
