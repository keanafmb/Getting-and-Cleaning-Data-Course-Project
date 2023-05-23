The run_analysis.R script is written to do the following:
    1) Merges the training and the test sets to create one data set.
    2) Extracts only the measurements on the mean and standard deviation for each         measurement. 
    3) Uses descriptive activity names to name the activities in the data set
    4) Appropriately labels the data set with descriptive variable names. 
    5) From the data set in step 4, creates a second, independent tidy data set with     the average of each variable for each activity and each subject.

The description below highlights the steps done in the script file:
1) read the datasets and assign each data to variables
    * features <- features.txt 
        The features selected for this database come from the accelerometer and               gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.
    * activity_labels <- activity_labels.txt
        contains the labels of each activity with their corresponding code
    * subject_test <- test/subject_test.txt 
        contains test data of 9/30 volunteer test subjects being observed
    * x_test <- test/X_test.txt 
        contains recorded features test data
    * y_test <- test/y_test.txt 
        contains test data of activities’code labels
    * subject_train <- test/subject_train.txt 
        contains train data of 21/30 volunteer subjects being observed
    * x_train <- test/X_train.txt 
        contains recorded features train data
    * y_train <- test/y_train.txt 
        contains train data of activities’code labels

2) Merges the training and the test sets to create one data set
    * x  - consists of merged x_train and x_test using rbind() function
    * y  - consists of merged y_train and y_test using rbind() function
    * subject  - consists of merged subject_train and subject_test using rbind()            function
    * mergedData  - consists of merged subject, y and y using cbind() function

3) Extracts only the measurements on the mean and standard deviation for each             measurement
    * extractedData - is created by subsetting mergedData, selecting the columns            subject, code and the measurements on the mean and standard                           deviation (std) for each measurement

4) Uses descriptive activity names to name the activities in the data set
    The second column of activity_labels variable was extracted to replace the            corresponding code column in extractedData
    

5) Appropriately labels the data set with descriptive variable names
    code column in extractedData renamed into activities
    * All Acc in column’s name replaced by Accelerometer
    * All Gyro in column’s name replaced by Gyroscope
    * All BodyBody in column’s name replaced by Body
    * All Mag in column’s name replaced by Magnitude
    * All start with character f in column’s name replaced by Frequency
    * All start with character t in column’s name replaced by Time

6) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
    * tidy_second  is created by sumarizing extractedData taking the means of  each       * variable for each activity and each subject, after grouped by subject and           activity.
    *  Export tidy_second into tidy_second.txt file.