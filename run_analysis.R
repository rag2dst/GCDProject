# File run_analysis.R for Getting & Cleaning Data module of the Coursera JHU Data Science course set.

# This script should be run at the top level of the 'UCI HAR Dataset' directory.

# Start by invoking required libraries (these may need ot be installed first, depending on local configuration)

library(dplyr)
library(data.table)

# This script is designed to be easy to understand, given an understanding of the dplyr syntax and %>% opreator

# First, read 3 test data tables, to keep subject & test consistency in numbering

inFile1 <- "./test/X_test.txt"
inFile2 <- "./test/y_test.txt"
inFile3 <- "./test/subject_test.txt"
inFile4 <- "features.txt"
inFile5 <- "activity_labels.txt"

# Read all 3 data tables, column labels first of all
X_labels <- read.table(inFile4)    # read 561 column labels
X_data <- read.table(inFile1, col.names=X_labels[ ,2])          # original 561 column data table
y_data <- read.table(inFile2, col.names="testXId")               # ordered test types
subject_data <- read.table(inFile3, col.names="subjectId")      # ordered subject labels

# Add testXId column to X_Data
X_data <- cbind(X_data, y_data)
# Add subjectId column to X_Data
X_data <- cbind(X_data, subject_data)

# Secondly read in 3 trial data tables, similarly to the above
inFile1 <- "./train/X_train.txt"
inFile2 <- "./train/y_train.txt"
inFile3 <- "./train/subject_train.txt"

# Read all 3 data tables, column labels first of all
# Data goes in to X_Data2, reuse y_data & subject_data identifiers
X_data2 <- read.table(inFile1, col.names=X_labels[ ,2])         # original 561 column data table
y_data <- read.table(inFile2, col.names="testXId")               # ordered test types
subject_data <- read.table(inFile3, col.names="subjectId")      # ordered subject labels

# Add testXId column to X_Data2
X_data2 <- cbind(X_data2, y_data)
# Add subjectId column to X_Data2
X_data2 <- cbind(X_data2, subject_data)

# At this point X_data & X_data2 are self consistent data tables, and may safely
# be merged with one another

X_data <- rbind(X_data, X_data2)

# Now replace numbers in testXId column with names in new testID column
activities <- read.table(inFile5)
# quick n dirty code!
for (i in 1:nrow(X_data)) {X_data[i, "testId"] <- activities[X_data[i, "testXId"], 2]}

# Now select the columns that are to be kept
keepNames <- grep("mean", colnames(X_data))
keepNames <- c(keepNames, grep("std", colnames(X_data)))
keepNames <- c(keepNames, grep("testId", colnames(X_data)))
keepNames <- c(keepNames, grep("subjectId", colnames(X_data)))

X_data <- X_data[keepNames]     # This is the reduced column, aggregated data
                                # set that was to be produced

# Write the data table to file Total.txt in the working directory
outFile <- "./Total.txt"
# Create outFile if it does not already exist
if (!file.exists(outFile)) {file.create(outFile)}
OP <- file(outFile, "w+")
write.table(X_data, file=OP, row.names=FALSE)
# And close the file after use
close(OP)

# And now, to calculate the means for each subject and test
# Use a new table X_mean

