# CodeBook

## Overview
The dataset used in this project comes from the **UCI HAR Dataset**, which contains data gathered from the accelerometers and gyroscopes of Samsung Galaxy S smartphones. The purpose of this project is to create a **tidy dataset** that focuses on the mean and standard deviation of sensor measurements for each subject and activity.

## Data Description
The raw data captures sensor signals from activities like walking, sitting, standing, and others, recorded as volunteers wore smartphones. The accelerometer and gyroscope on the phone measured 3-axis signals related to body motion and acceleration, as well as angular velocity.

### Original Dataset Features:
- **Subjects**: 30 individuals participated in the experiment.
- **Activities**: Each subject performed six different activities.
- **Measurements**: There are 561 different features in the original dataset, derived from time and frequency domain measurements from the smartphone's sensors.

## Variables in the Tidy Dataset
The final tidy dataset includes the following columns:

1. **`subject`**: 
   - Type: Integer
   - Description: Represents the ID of the subject (ranges from 1 to 30).
   - Example: `1`, `2`, ..., `30`.

2. **`activity`**: 
   - Type: Factor
   - Description: Describes the activity performed by the subject.
   - Values:
     - WALKING
     - WALKING_UPSTAIRS
     - WALKING_DOWNSTAIRS
     - SITTING
     - STANDING
     - LAYING

3. **Sensor Measurements**:
   - Description: These columns show the **average** values of the original mean and standard deviation measurements for each subject and activity. The measurements include both **time-domain** (denoted by `Time`) and **frequency-domain** (denoted by `Frequency`) features.
   
   The naming convention follows these patterns:
   - **Time**: Measurements in the time domain (originally prefixed by `t` in the dataset).
   - **Frequency**: Measurements in the frequency domain (originally prefixed by `f`).
   - **Acc**: Accelerometer data.
   - **Gyro**: Gyroscope data.
   - **Body**: Body movement signals.
   - **Gravity**: Gravity acceleration signals.
   - **mean()**: Mean value of the measurement.
   - **std()**: Standard deviation of the measurement (labeled as `Standard Deviation` in the tidy dataset).
   
   Example measurement names:
   - `TimeBodyAccelerometerMean-X`: Mean value of body acceleration in the X axis from time domain signals.
   - `TimeBodyAccelerometerStandard Deviation-Y`: Standard deviation of body acceleration in the Y axis from time domain signals.
   - `FrequencyBodyGyroscopeMean-Z`: Mean value of body gyroscope in the Z axis from frequency domain signals.

## Data Cleaning and Transformation Steps

1. **Merging the Training and Test Data**:
   - Data from the training and test sets were combined using `rbind()` for sensor data (`X`), activity labels (`y`), and subject IDs.
   - Resulting variables:
     - `x_combined`: Combined sensor measurements.
     - `y_combined`: Combined activity labels.
     - `subject_combined`: Combined subject IDs.

2. **Selecting Relevant Features**:
   - Only the measurements related to **mean** and **standard deviation** were extracted. This was done by identifying features that contain `mean()` or `std()` in their names.
   - Feature selection was done using:
     ```r
     mean_std_columns <- grep("-(mean|std)\\(\\)", features[, 2]) + 2
     ```

3. **Using Descriptive Activity Names**:
   - Activity labels were replaced with descriptive names using the `activity_labels.txt` file.
   - For example:
     - `1` → `WALKING`
     - `2` → `WALKING_UPSTAIRS`
     - `3` → `WALKING_DOWNSTAIRS`

4. **Labeling the Data with Descriptive Variable Names**:
   - The variable names were updated to be more descriptive:
     - `t` was replaced by `Time` (for time-domain signals).
     - `f` was replaced by `Frequency` (for frequency-domain signals).
     - `Acc` became `Accelerometer`.
     - `Gyro` became `Gyroscope`.
     - `Mag` became `Magnitude`.
     - `-mean()` became `Mean`.
     - `-std()` became `Standard Deviation`.

   Example renaming:
   ```r
   names(selected) <- gsub("^t", "Time", names(selected))
   names(selected) <- gsub("-std\\(\\)", "Standard Deviation", names(selected))
   ```

5. **Creating the Final Tidy Dataset**:
   - The data was grouped by **subject** and **activity**, and the mean of each measurement was calculated.
   - Code used:
     ```r
     tidy_dataset <- selected %>%
       group_by(subject, activity) %>%
       summarise_all(list(mean))
     ```

6. **Saving the Tidy Dataset**:
   - The final tidy dataset was saved to a file named `tidy_dataset.txt` using `write.table()`, with no row names.
