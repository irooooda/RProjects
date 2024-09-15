# Data Cleaning Project

## Overview

This repository contains an R script, `run_analysis.R`, which processes the **Human Activity Recognition Using Smartphones Dataset**. The data was collected using the accelerometers and gyroscopes on Samsung Galaxy S smartphones. The goal is to clean and tidy the dataset, focusing on the mean and standard deviation for each measurement.

The script will generate a tidy dataset that includes the average of each variable for each activity and each subject.

## Files in this Repository

- **`run_analysis.R`**: The R script that processes and tidies the dataset.
- **`CodeBook.md`**: Describes the variables, data, and transformations done during the cleaning process.
- **`README.md`**: This file, explaining how to run the script and what the output is.
- **`tidy_dataset.txt`**: The output of the script, containing the tidy dataset.

## How to Run the Script

1. **Download the Dataset**:
   - Download the raw dataset from the following link:
     [UCI Human Activity Recognition Dataset](https://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).
   - Extract the downloaded zip file and make sure the folder named **`UCI HAR Dataset`** is placed in your working directory.

2. **Download or Clone this Repository**:
   - You can clone this repository to your local machine by running:
     ```bash
     git clone https://github.com/irooooda/RProjects.git
     ```
   - Alternatively, you can download the repository files manually.

3. **Ensure Your Working Directory**:
   - Before running the script, make sure that the **`UCI HAR Dataset`** folder is in your working directory and that the `run_analysis.R` script is also in the same directory.

4. **Run the Script**:
   - In R or RStudio, run the `run_analysis.R` script by executing the following command:
     ```r
     source("run_analysis.R")
     ```
   - This script will process the dataset, extract the relevant features, and create a tidy dataset.

5. **Output**:
   - After running the script, a file called `tidy_dataset.txt` will be saved in your working directory. This file contains the tidy data, where each row is the average of each variable for each activity and subject.

## Script Details

The `run_analysis.R` script performs the following steps:

1. **Merges the training and test datasets** to create one combined dataset.
2. **Extracts only the measurements on the mean and standard deviation** for each measurement.
3. **Uses descriptive activity names** to name the activities in the dataset.
4. **Labels the dataset with descriptive variable names**.
5. **Creates a second, independent tidy dataset** with the average of each variable for each activity and each subject.

## Requirements

The `run_analysis.R` script requires the following package:

- **`dplyr`**: You can install this package by running:
  ```r
  install.packages("dplyr")
