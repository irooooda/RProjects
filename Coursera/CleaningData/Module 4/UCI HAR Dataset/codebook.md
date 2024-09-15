# CodeBook

## Overview
Given dataset was derived from the **UCI HAR Dataset**, that represents data collected from the accelerometers and gyroscopes of Samsung Galaxy S smartphones. 
Goal: to generate a **tidy dataset** that includes the mean of sensor measurements (only mean and standard deviation) for each subject and activity.

## Data Description
The raw data contains sensor signals collected during various activities (such as walking, sitting, and standing) performed by subjects wearing smartphones. The smartphone's embedded accelerometer and gyroscope captured 3-axial signals (X, Y, Z) related to body acceleration, gravity acceleration, and angular velocity.

### Original Dataset Features:
- **Subjects**: 30 volunteers (subjects) participated in the experiment.
- **Activities**: The subjects performed six different activities.
- **Measurements**: The original dataset contains 561 features, which are derived from time and frequency domain variables measured by the accelerometer and gyroscope.

## Variables in Tidy Dataset
The final tidy dataset includes the following columns:

1. **`subject`**: 
   - Type: Integer
   - Description: ID of the subject (ranges from 1 to 30).
   - Example: `1`, `2`, ..., `30`.

2. **`activity`**: 
   - Type: Factor
   - Description: The activity performed by the subject.
   - Values:
     - WALKING
     - WALKING_UPSTAIRS
     - WALKING_DOWNSTAIRS
     - SITTING
     - STANDING
     - LAYING

3. **Sensor Measurements**:
   - Description: These columns represent the **mean** of the original mean and standard deviation measurements for each subject-activity combination. They are derived from both the **time domain** (denoted by `Time`) and the **frequency domain** (denoted by `Frequency`).
   
   The following patterns are used in the variable names:
   - **Time**: Time domain signals (prefixed by `t` in the original dataset, now replaced with `Time`).
   - **Frequency**: Frequency domain signals (prefixed by `f` in the original dataset, now replaced with `Frequency`).
   - **Acc**: Accelerometer signals.
   - **Gyro**: Gyroscope signals.
   - **Body**: Body movement signals.
   - **Gravity**: Gravity acceleration signals.
   - **mean()**: Mean value for the measurement.
   - **std()**: Standard deviation for the measurement (labeled as `Standard Deviation` in the tidy dataset).
   
   Example sensor measurement names:
   - `TimeBodyAccelerometerMean-X`: Mean value of body acceleration in the X direction from time domain signals.
   - `TimeBodyAccelerometerStandard Deviation-Y`: Standard deviation of body acceleration in the Y direction from time domain signals.
   - `FrequencyBodyGyroscopeMean-Z`: Mean value of body gyroscope in the Z direction from frequency domain signals.

## Transformations and Cleaning Steps

1. **Merge Training and Test Datasets**:
   - The training and test datasets were combined using `rbind()` for the **X**, **y**, and **subject** data.
   - Resulting variables:
     - `x_combined`: Combined sensor measurements.
     - `y_combined`: Combined activity labels.
     - `subject_combined`: Combined subject identifiers.

2. **Feature Selection**:
   - Only the measurements related to **mean** and **standard deviation** were extracted from the combined dataset. This was done by selecting features that contain `mean()` or `std()` in their names.
   - Feature extraction:
     ```r
     mean_std_columns <- grep("-(mean|std)\\(\\)", features[, 2]) + 2
     ```

3. **Descriptive Activity Names**:
   - The numeric activity labels were replaced with descriptive activity names using the `activity_labels.txt` file.
   - Example:
     - `1` → `WALKING`
     - `2` → `WALKING_UPSTAIRS`
     - `3` → `WALKING_DOWNSTAIRS`

4. **Labeling the Dataset with Descriptive Variable Names**:
   - Variable names were transformed to be more human-readable by replacing abbreviations with descriptive labels:
     - `t` → `Time` (for time-domain signals).
     - `f` → `Frequency` (for frequency-domain signals).
     - `Acc` → `Accelerometer`.
     - `Gyro` → `Gyroscope`.
     - `Mag` → `Magnitude`.
     - `-mean()` → `Mean`.
     - `-std()` → `Standard Deviation`.

   Example of renaming:
   ```r
   names(selected) <- gsub("^t", "Time", names(selected))
   names(selected) <- gsub("-std\\(\\)", "Standard Deviation", names(selected))
   ```

5. **Creating the Final Tidy Dataset**:
   - The final tidy dataset was created by grouping the data by **subject** and **activity** and calculating the **mean** of each measurement.
   - Code:
     ```r
     tidy_dataset <- selected %>%
       group_by(subject, activity) %>%
       summarise_all(list(mean))
     ```

6. **Output**:
   - The tidy dataset was written to a file `tidy_dataset.txt` using `write.table()`, with no row names.

## Summary
The final tidy dataset provides the average (mean) of each variable related to mean and standard deviation for each subject and activity combination. This dataset is ready for further analysis or modeling tasks.
