================================================
Run Analyisis script (run-tidy-data)
===================================================
Paulina Rovira  paulina.rovira@gmail.com
====================================================

This script has been created for the Getting and Cleaning Data course Project 
to create a tidy data set from the Human Activity Recognition Using Smartphones 
Dataset provided for the project. 

The original data can be found at:
        
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The R script does the following.

1. Merges the training and the test sets provided to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each 
        measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set 
         with the average of each variable for each activity and each subject.

The original data sets of test and training data have been merged to create only
one data set of 180 observations and 68 variables. Only the mean and standard 
deviation measurements from the original data set have been included, so only 
68 of 563 original variables are considered. The average of the measurements for each
activity and each subject has been obtained, generating only 180 observations 
from the original 10299 recordings of the original data sets.

The tidy data set has been created following the principles:
Each variable must have its own column.
Each observation must have its own row.
Each value must have its own cell.


The project includes the following files:
=========================================

- 'README.md'

- 'run_analysis.R': The script that creates the tidy data set and saves it in
                        tidyRunData.txt

- 'tidyRunData.txt': Tidy data set with the average of each measurement for 
                        each activity and each subject.

- 'codeBook.md': Code Book that indicates all the variables and summaries 
                        calculated, along with units

Notes: 
======
- Each combination of activity and subject is a row on the text file.
- The units used for the accelerations (total and body) are 'g's 
        (gravity of earth -> 9.80665 m/seg2).
- The gyroscope units are rad/seg.


Code for reading the data set to R:
========
You can use the following code to read the tidy data set to R:

data <- read.table(file_path, header = TRUE) 

View(data)

===============================================
Paulina Rovira. December 2020.
