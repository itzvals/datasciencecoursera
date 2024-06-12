#coursera week4

#clean data
rm(list = ls())
#load packages
library(dplyr)
#load data sets 
#train
file_path_train1 <- "./UCI_HAR_Dataset/train/subject_train.txt"
file_path_train2 <- "./UCI_HAR_Dataset/train/X_train.txt"
file_path_train3 <- "./UCI_HAR_Dataset/train/y_train.txt"
file_path_labels <- "./UCI_HAR_Dataset/activity_labels.txt"
file_path_features <- "./UCI_HAR_Dataset/features.txt"
file_path_test1 <- "./UCI_HAR_Dataset/test/subject_test.txt"
file_path_test2 <- "./UCI_HAR_Dataset/test/X_test.txt"
file_path_test3 <- "./UCI_HAR_Dataset/test/y_test.txt"


#train
# Load the text file
train_data1 <- read.table(file_path_train1, header = TRUE) 
train_data2 <- read.table(file_path_train2, header = TRUE) 
train_data3 <- read.table(file_path_train3, header = TRUE) 
#test
test_data1 <- read.table(file_path_test1, header = TRUE) 
test_data2 <- read.table(file_path_test2, header = TRUE) 
test_data3 <- read.table(file_path_test3, header = TRUE) 
#other
features <- read.table(file_path_features, header = FALSE, stringsAsFactors = FALSE)[, 2]
activity_labels <- read.table(file_path_labels, header = FALSE)

########################################################################
#Merges the training and the test sets to create one data set.

#rename columns for clarity of each volunteer
#training rename
names(train_data1)[which(names(train_data1) == "X1")] <- "VolunteerID"
#rename testing
names(test_data1)[which(names(test_data1) == "X2")] <- "VolunteerID"

#merge IDs fron train and test
ID<- rbind(train_data1,test_data1)
rbind(train_data2,)

#rename column names of test and train based on 'file_path_features'
colnames(train_data2) <- features
colnames(test_data2) <-features

#merge features train and testing data sets
X<-rbind(train_data2,test_data2)

#rename as Labels in train/test
names(train_data3)[which(names(train_data3) == "X5")] <- "Labels"
names(test_data3)[which(names(test_data3) == "X5")] <- "Labels"

#bind Labels
Y <-rbind(train_data3, test_data3)

#merge all datasets into one -use columns
Merged_DF <- cbind(ID, Y, X)

########################################################################
#Extracts only the measurements on the mean and standard deviation for each measurement. 

Extracted_Data <- Merged_DF %>% select(VolunteerID,Labels,contains("mean"), contains("std"))

########################################################################
#Uses descriptive activity names to name the activities in the data set
Extracted_Data$Labels <- activity_labels[Extracted_Data$Labels, 2]

########################################################################
#Appropriately labels the data set with descriptive variable names. 
#Remove shorthand labels with full names

# Function to remove shorthand labels with full names
clean_names <- function(names_vector) {
  names_vector <- gsub("^t", "Time", names_vector)
  names_vector <- gsub("^f", "Frequency", names_vector)
  names_vector <- gsub("Acc", "Accelerometer", names_vector)
  names_vector <- gsub("Gyro", "Gyroscope", names_vector)
  names_vector <- gsub("Mag", "Magnitude", names_vector)
  names_vector <- gsub("BodyBody", "Body", names_vector)
  names_vector <- gsub("Body", "Body", names_vector)
  names_vector <- gsub("Gravity", "Gravity", names_vector)
  names_vector <- gsub("-mean\\(\\)", "-Mean", names_vector, ignore.case = TRUE)
  names_vector <- gsub("-std\\(\\)", "-STD", names_vector, ignore.case = TRUE)
  names_vector <- gsub("-freq\\(\\)", "-Frequency", names_vector, ignore.case = TRUE)
  names_vector <- gsub("angle", "Angle", names_vector)
  names_vector <- gsub("gravity", "Gravity", names_vector)
  return(names_vector)
}

colnames(Extracted_Data) <- clean_names(colnames(Extracted_Data))

########################################################################
#From the data set in step 4, creates a second, independent tidy data set with 
#the average of each variable for each activity and each subject.

TidyData <- Extracted_Data %>%
  group_by(VolunteerID, Labels) %>%
  summarise_all(list(mean = ~ mean(.)))
