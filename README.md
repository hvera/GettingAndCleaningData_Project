# Getting and Cleaning Data - Coursera
## Course Project

The purpose of this assigment is to collect, transform, and generat a clean data set.

Source of the data for the project:

[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

Full description of the data set

[http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)    

The requirements for the project are:

* Create a tidy data set that can be used for later analysis

You should create one R script called run_analysis.R that does the following. 

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

The code for the project is in `run_analysis.R`

The program creates a `./data` directory if needed and downloads and unzips the data in that directory.

The data is read and processed according to the description documented in the codebook file: `CodeBook`

The output of the program is a file called `clean_dataset.txt` written to the current working directory.

