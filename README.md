# Getting And Cleaning Data Final Project

##Description
This is the final project of Getting and Cleaning Data
The run_analysis.R file creates two tidy data sets.
The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here is the raw data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The run_analysis.R that does the following.

0. Reads the data from the above link and downloads it into a Project Directory 
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.\
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##Running the script
Type the following in R enviroment:
run_analyisis()

##Results
Two datasets are created
- **Complete_Dataset.csv** is First Dataset containing all the data
- **Average_datset.csv** is The dataset from setp 5 and the final tidy dataset

The rows in **"Average_Dataset.csv"** contain Subject, Activity, and the Mean/Standard deviation of all features

##Code Book
The Code Book describes the the variables in "Average_datset.csv", the data, andtransformations or work that you performed to clean up the data 

