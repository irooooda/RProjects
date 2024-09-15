setwd("/Users/irooooda/Desktop/R/RProjects/Coursera/Cleaning Data/Module 4") # set the working directory

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" # assign the dataset URL to a variable
download.file(url, destfile = "UCI_HAR_Dataset.zip") # download the dataset and save it as "UCI_HAR_Dataset.zip"
unzip("UCI_HAR_Dataset.zip") # unzip the downloaded dataset

library(dplyr) # load the dplyr library for data manipulation

setwd("UCI HAR Dataset") # change the working directory to the unzipped dataset folder

features <- read.table("features.txt") # read the features.txt file and store it in a variable
activity_labels <- read.table("activity_labels.txt", col.names = c("id", "activity")) # read activity_labels.txt and name the columns "id" and "activity"

x_train <- read.table("train/X_train.txt") # read the X_train.txt file and store it in a variable
y_train <- read.table("train/y_train.txt", col.names = "activity_id") # read the y_train.txt file and name the column "activity_id"
subject_train <- read.table("train/subject_train.txt", col.names = "subject") # read the subject_train.txt file and name the column "subject"

x_test <- read.table("test/X_test.txt") # read the X_test.txt file and store it in a variable
y_test <- read.table("test/y_test.txt", col.names = "activity_id") # read the y_test.txt file and name the column "activity_id"
subject_test <- read.table("test/subject_test.txt", col.names = "subject") # read the subject_test.txt file and name the column "subject"

x_combined <- rbind(x_train, x_test) # combine X_train and X_test by appending the test data to the training data
y_combined <- rbind(y_train, y_test) # combine y_train and y_test by appending the test data to the training data
subject_combined <- rbind(subject_train, subject_test) # combine subject_train and subject_test by appending the test data to the training data

colnames(x_combined) <- features[, 2] # assign the 2nd column of features table to column names of x_combined 

merged <- cbind(subject_combined, y_combined, x_combined) # combine the subject, activity, and sensor data by columns

mean_std_columns <- grep("-(mean|std)\\(\\)", features[, 2]) + 2 # select only the 2nd column names where they contain "mean()" or "std()" in the features table

selected <- merge(merged[, c(1, 2, mean_std_columns)], activity_labels, by.x = "activity_id", by.y = "id") # merge the selected data with activity labels to include descriptive activity names
selected$activity_id <- NULL # remove the activity_id column after merging

# rename the columns with more descriptive names
names(selected) <- gsub("^t", "Time", names(selected)) # replace "t" with "Time" for time-domain signals
names(selected) <- gsub("^f", "Frequency", names(selected)) # replace "f" with "Frequency" for frequency-domain signals
names(selected) <- gsub("Acc", "Accelerometer", names(selected)) # replace "Acc" with "Accelerometer"
names(selected) <- gsub("Gyro", "Gyroscope", names(selected)) # replace "Gyro" with "Gyroscope"
names(selected) <- gsub("Mag", "Magnitude", names(selected)) # replace "Mag" with "Magnitude"
names(selected) <- gsub("BodyBody", "Body", names(selected)) # correct duplicated "Body" to just "Body"
names(selected) <- gsub("-mean\\(\\)", "Mean", names(selected), ignore.case = TRUE) # replace "-mean()" with "Mean"
names(selected) <- gsub("-std\\(\\)", "Standard Deviation", names(selected), ignore.case = TRUE) # replace "-std()" with "Standard Deviation"

tidy_dataset <- selected %>%
  group_by(subject, activity) %>%
  summarise_all(list(mean)) # group by subject and activity, and calculate the mean of each variable (both mean and standard deviation columns)

write.table(tidy_dataset, "tidy_dataset.txt", row.name = FALSE) # Write the tidy dataset to a text file without row names



