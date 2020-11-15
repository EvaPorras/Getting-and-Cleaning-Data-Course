#Getting and Cleaning Data - Course Project

##Install an load packages
install.packages("dplyr")
library(dplyr)


##Download data file and unzip
file_url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dest_file="Data.zip"
if(!file.exists(dest_file)){
  download.file(file_url,destfile = dest_file)
  unzip(dest_file)
}

##Read files
setwd("./UCI HAR Dataset")

##Activity files
Activity_test<-read.table("./test/y_test.txt",header=F)
Activity_train<-read.table("./train/y_train.txt",header=F)

##Features files
Features_test<-read.table("./test/X_test.txt",header=F)
Features_train<-read.table("./train/X_train.txt",header=F)

##Subject files
Subject_test<-read.table("./test/subject_test.txt",header=F)
Subject_train<-read.table("./train/subject_train.txt",header=F)

##Activity Labels
Activity_labels<-read.table("./activity_labels.txt",header=F)

##Feature Names
Feature_names<-read.table("./features.txt",header=F)

# 1. Merges the training and the test sets to create one data set.

##Merge the training and the test sets
Features_data<-rbind(Features_test,Features_train)
Subject_data<-rbind(Subject_test,Subject_train)
Activity_data<-rbind(Activity_test,Activity_train)

##Rename columns of Activity, Subject and Features
names(Activity_data)<-"Activity"
names(Subject_data)<-"Subject"
names(Features_data)<-Feature_names$V2

##Merge the three Data Sets (Subject, Activity, Features) in the complete Data set
Data<-cbind(Subject_data,Activity_data)
Data<-cbind(Data,Features_data)


#2. Extracts only the measurements on the mean and standard deviation for each measurement. 

##Get the names of Features representing only mean or std
SelectedFeatures_names<-Feature_names$V2[grep("mean\\(\\)|std\\(\\)",Feature_names$V2)]
SelectedData_names<-c("Subject","Activity", as.character(SelectedFeatures_names))
Data<-subset(Data,select=SelectedData_names)


#3. Uses descriptive activity names to name the activities in the data set

names(Activity_labels)<-c("Activity","Activity_name")
Data<-left_join(Data,Activity_labels,"Activity")
Data<-mutate(Data,Activity=Activity_name)
Data<-select(Data,-Activity_name)


#4. Appropriately labels the data set with descriptive variable names. 

names(Data)<-gsub("[(]+[)]","",names(Data))
names(Data)<-gsub("BodyBody","Body",names(Data))
names(Data)<-gsub("^t","[time]-",names(Data))
names(Data)<-gsub("Acc","Accelerator",names(Data))
names(Data)<-gsub("Gyro","Gyroscope",names(Data))
names(Data)<-gsub("^f","[frequency]-",names(Data))
names(Data)<-gsub("Mag","Magnitude",names(Data))


#5. Create a second, independent tidy data set with the average of each variable for each activity and each subject.

Data_tidy<-aggregate(. ~ Subject + Activity, Data, mean)



#6. Create a txt file  with write.table() using row.name=FALSE

write.table(Data_tidy, file="Data_tidy.txt", row.name=FALSE)
