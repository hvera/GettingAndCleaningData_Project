# Coursera - Getting and Cleaning Data - course project

# You should create one R script called run_analysis.R that does the following. 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. Creates a second, independent tidy data set with the average of each variable for each
#    activity and each subject. 

library(reshape2)
library(data.table)

dataURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dataDir <- "./data"
dataFileName <- "UCI_HAR_Dataset.zip"
dataFile <- paste("./data", dataFileName, sep = "/")
extractDir <- paste("./data", "UCI HAR Dataset", sep = "/")
testDataDir <- paste(extractDir, "test", sep = "/")
trainDataDir <- paste(extractDir, "train", sep = "/")

# Download file if necessary
if (!file.exists(dataDir)) {
    message("Creating data directory.")
    dir.create(dataDir)
}
if (!file.exists(dataFile)){
    fileURL <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileURL, dataFile, method="curl")
}  
# Unzip file if necessary
if (!file.exists(extractDir)) { 
    unzip(dataFile, exdir = dataDir) 
}

# load the datasets
subject_test <- read.table(paste(testDataDir, "subject_test.txt", sep = "/"))
subject_train <- read.table(paste(trainDataDir, "subject_train.txt", sep="/"))

train_y <- read.table(paste(trainDataDir, "y_train.txt", sep="/"))
train_x <- read.table(paste(trainDataDir, "X_train.txt", sep="/"))

test_y <- read.table(paste(testDataDir, "y_test.txt", sep="/"))
test_x <- read.table(paste(testDataDir, "X_test.txt", sep="/"))

# get the features and activities
features <- read.table(paste(extractDir, "features.txt", sep = "/"))
activity_labels <- read.table(paste(extractDir, "activity_labels.txt", sep = "/"))

feature_names <- features[, 2]
activity_names <- activity_labels[, 2]

# 1. Merge the training and the test sets to create one data set.
# merge the subject data
subject <- rbind(subject_test, subject_train)
colnames(subject) <- "Subject"

names(test_x) <- feature_names
names(train_x) <- feature_names

# 2. Extract obnly the measurements on the mean and standard deviation for each measurement
test_x <- test_x[, grepl("mean|std", feature_names)]
train_x <- train_x[, grepl("mean|std", feature_names)]

combined_x <- rbind(test_x, train_x)

# 3. Use descriptive activy names on the mean and standard deviation for each mesurement.
# add a column for the activity labels
test_y[, 2] <- activity_names[test_y[, 1]]
train_y[,2] <- activity_names[train_y[, 1]]
activities <- rbind(test_y, train_y)

# 4. Appropriately label the data set with descriptive variable names.
# add the labels
names(activities) <- c("ActivityID", "ActivityLabel")

# combine all three tables
alldata <- cbind(as.data.table(subject), activities, combined_x)

# 5. Create a second, independent tidy data set with the average of each 
#    variable for each activity and each subject.

# calculate average of each variable for each activity and each subject
id_labels <- c("Subject", "ActivityID", "ActivityLabel")
data_labels <- setdiff(colnames(alldata), id_labels)
temp <- melt(alldata, id = id_labels, measure.vars = data_labels)

result <- dcast(temp, Subject + ActivityLabel ~ variable, mean)
head(result)

# write the tidy dataset to a file
write.table(result, "clean_dataset.txt",sep="|")

