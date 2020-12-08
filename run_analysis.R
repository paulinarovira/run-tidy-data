# The purpose of this script is to tidy up the data set that can be found in:
        
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# The project requires the script to do the following:

# 1. Merge the training and the test sets to create one data set.
# 2. Extract only the measurements on the mean and standard deviation for each 
#    measurement.
# 3. Use descriptive activity names to name the activities in the data set
# 4. Appropriately label the data set with descriptive variable names.
# 5. From the data set in step 4, create a second, independent tidy data set 
#    with the average of each variable for each activity and each subject.

# To tidy up the data set, start by reading the data
# Get measurements from downloaded files
trainingDataX <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
testDataX <- read.table("./data/UCI HAR Dataset/test/X_test.txt") 

# Get features list to rename columns in the data sets
features <- read.table("./data/UCI HAR Dataset/features.txt")

# Get only second column of features (because first column is numbers)
features <- as.character(features[,2])

# Set features as column names for trainingData data sets
colnames(trainingDataX) <- features
colnames(testDataX) <- features

# Get activities from downloaded files and convert to vectors
trainingDataActivities <- read.table("./data/UCI HAR Dataset/train/Y_train.txt")
trainingDataActivities <- as.numeric(trainingDataActivities[,1])

testDataActivities <- read.table("./data/UCI HAR Dataset/test/Y_test.txt")
testDataActivities <- as.numeric(testDataActivities[,1])

# Append activity columns to measurements Data sets 
trainingDataX$Activity <- trainingDataActivities
testDataX$Activity <- testDataActivities

# Read subject data and convert to vectors
trainingDataSubjects <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
testDataSubjects <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
trainingDataSubjects <- as.character(trainingDataSubjects[,1])
testDataSubjects <- as.character(testDataSubjects[,1])

# Append subject columns to measurements Data sets 
trainingDataX$Subject <- trainingDataSubjects
testDataX$Subject <- testDataSubjects

# Merge train and test data sets (This completes step 1 for the project)
mergedRunData <- rbind(trainingDataX, testDataX)

# For step 2, extract only the measurements on the mean and standard deviation for each 
# measurement. Use grepl looking for the columns that contain mean, std, and
# keep Activity and subject columns. Then remove columns that contain meanFreq
# in their names because we don't need them
mergedRunDataMeanStd <- mergedRunData[,grepl("mean|std|Activity|Subject", colnames(mergedRunData))]
mergedRunDataMeanStd <- mergedRunDataMeanStd[,!grepl("meanFreq", colnames(mergedRunDataMeanStd))]

# For step 3, replace activity numbers for their labels. First, get activity 
# labels, and then get vector of only labels (remove first column 
# of activity numbers)
activity_labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
activity_labels <- as.character(activity_labels[,2])

# Change activity numbers for their labels
mergedRunDataMeanStd$Activity <- activity_labels[mergedRunDataMeanStd$Activity]

# For step 4, change labels of the original data set to have descriptive 
# variable names.
# Remove punctuation and parenthesis from variable names because they can 
# generate conflicts in some R functions
colnames(mergedRunDataMeanStd) <- gsub("[()]", "", names(mergedRunDataMeanStd))

# Remove - from variable names
colnames(mergedRunDataMeanStd) <- gsub("[-]", "", names(mergedRunDataMeanStd))

# Change t for TimeDomain in variable names
colnames(mergedRunDataMeanStd) <- gsub("^t", "TimeDomain",  names(mergedRunDataMeanStd))

# Change f for FrequencyDomain in variable names
colnames(mergedRunDataMeanStd) <- gsub("^f", "FrequencyDomain",  names(mergedRunDataMeanStd))

# Change Acc for Acceleration in variable names
colnames(mergedRunDataMeanStd) <- gsub("Acc", "Acceleration",  names(mergedRunDataMeanStd))

# Change Gyro for Gyroscope in variable names
colnames(mergedRunDataMeanStd) <- gsub("Gyro", "AngularVelocity",  names(mergedRunDataMeanStd))

# Change Mag for Magnitude in variable names
colnames(mergedRunDataMeanStd) <- gsub("Mag", "Magnitude",  names(mergedRunDataMeanStd))

# Change mean for Mean in variable names
colnames(mergedRunDataMeanStd) <- gsub("mean", "Mean",  names(mergedRunDataMeanStd))

# Change std for StandardDeviation in variable names
colnames(mergedRunDataMeanStd) <- gsub("std", "StandardDeviation",  names(mergedRunDataMeanStd))

# Change Jerk for JerkSignal in variable names
colnames(mergedRunDataMeanStd) <- gsub("Jerk", "JerkSignal",  names(mergedRunDataMeanStd))

# For step 5, create a second, independent tidy data set 
#    with the average of each variable for each activity and each subject. To do 
# this, use aggregate function obtaining the mean for columns 1 to 66 which are the ones
# that contain the measurements, and include Activity and Subject columns
# in the new data set as their combinations are used to group the averages
mergedRunDataMeanStdAvg <- aggregate(mergedRunDataMeanStd[,1:66], by = 
                                             list(Activity = 
                                                          mergedRunDataMeanStd$Activity, 
                                                  Subject = 
                                                          mergedRunDataMeanStd$Subject), 
                                                        FUN = mean)

# Write data set in test file created with write.table() using row.name=FALSE
write.table(x = mergedRunDataMeanStdAvg, file = "tidyRunData.txt", row.names = 
                    FALSE)
