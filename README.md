# Getting-and-Cleaning-Data-Course

Accordding to the assignment intructions, one R script called run_analysis.R have been created. The R script does the following actions:

1. Install an load package dplyr required to manipulate data

2. Download the data file and unzip the files in the working directory 
Once the files are unzip, they are read and stored into data frames which include the Activity Data (Activity files), the Subject Data (Subject files) and all the measures taken for those subject while doing those activities. 

3. As there are two sets (train and test) for each set of data, the first thing to do is merging the train and test sets into only one complete data set.

4. Once we have a complete Data set, only the columns including the the mean and standard deviation for each measurement are taken.

5. As the Activities in the Data sets are named as numbers (from 1 to 6), they are renamed to descriptive activity names using the names included into the Activity Labels file.

6. The names of the variables are renamed to appropriately labels with descriptive variable names. For that, the names are cleaned of symbols as(), duplicities, and abbreviations as t, f, Acc, Gyro and Mag are converted to time, frequency, Accelerator, Gyroscope and Magnitude.

7. As final objective of the assigment an independent tidy data set with the average of each variable for each activity and each subject is created.

8. At last, a txt file is created with write.table() using row.name=FALSE according to the instructions. This file is upload as required submission.
