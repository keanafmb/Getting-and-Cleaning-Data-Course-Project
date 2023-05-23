library(data.table)
library(dplyr)


features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")

x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")


#Merge training and the test sets to create one data set.
x<- rbind(x_train,x_test)
y<-rbind(y_train,y_test)
subject<-rbind(subject_train,subject_test)
mergedData <- cbind(subject,y,x)

#Extract only the measurements on the mean and standard deviation for each measurement. 
extractedData<-mergedData %>%
    select(subject,code,contains("mean"), contains("std"))


#Uses descriptive activity names to name the activities in the data set
extractedData$code<-activity_labels[extractedData$code, 2]


#Appropriately labels the data set with descriptive variable names. 
names(extractedData)[2] = "activity"
names(extractedData)<-gsub("Acc", "Accelerometer", names(extractedData))
names(extractedData)<-gsub("Gyro", "Gyroscope", names(extractedData))
names(extractedData)<-gsub("BodyBody", "Body", names(extractedData))
names(extractedData)<-gsub("Mag", "Magnitude", names(extractedData))
names(extractedData)<-gsub("^t", "Time", names(extractedData))
names(extractedData)<-gsub("^f", "Frequency", names(extractedData))
names(extractedData)<-gsub("tBody", "TimeBody", names(extractedData))
names(extractedData)<-gsub("-mean()", "Mean", names(extractedData), ignore.case = TRUE)
names(extractedData)<-gsub("-std()", "STD", names(extractedData), ignore.case = TRUE)
names(extractedData)<-gsub("-freq()", "Frequency", names(extractedData), ignore.case = TRUE)
names(extractedData)<-gsub("angle", "Angle", names(extractedData))
names(extractedData)<-gsub("gravity", "Gravity", names(extractedData))

#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
tidy_second<- extractedData %>%
    group_by(subject, activity) %>%
    summarize_all(funs(mean))
write.table(tidy_second, "tidy_second.txt", row.name=FALSE)