# input files:
#
# subject_test/train = list of subjects performing in the test/training set.
# X_test/train = summarised features of the measurements (each line has 561 summary values).  --not loaded
# y_test/train = activity performed in test/training set.
# body_acc_x_test/train = body acceleration in x-axis (128 samples per line)
# body_acc_y_test/train = body acceleration in y-axis (128 samples per line)
# body_acc_z_test/train = body acceleration in z-axis (128 samples per line)
# body_gyro_x_test/train = body angular velocity in x-axis (128 samples per line)
# body_gyro_y_test/train = body angular velocity in y-axis (128 samples per line)
# body_gyro_z_test/train = body angular velocity in z-axis (128 samples per line)
#
# activity_labels = Activity codes.

#load tidyverse library
library(tidyverse)

#load each file into R and give column headings

#subjects
subjects_test <- read.csv("./UCI HAR Dataset/test/subject_test.txt", header=FALSE, col.names = "subjectID")
subjects_train <- read.csv("./UCI HAR Dataset/train/subject_train.txt", header=FALSE, col.names = "subjectID")

#activities
actv_test <- read.csv("./UCI HAR Dataset/test/y_test.txt", header=FALSE, col.names = "actID")
actv_train <- read.csv("./UCI HAR Dataset/train/y_train.txt", header=FALSE, col.names = "actID")
activity_lbl <- read.csv("./UCI HAR Dataset/activity_labels.txt", header=FALSE, sep=" ", col.names = c("actID","activity"))

#body acceleration - test
# use function to read the result files
body_acc_x_test <- read_data("./UCI HAR Dataset/test/Inertial Signals/body_acc_x_test.txt")
body_acc_y_test <- read_data("./UCI HAR Dataset/test/Inertial Signals/body_acc_y_test.txt")
body_acc_z_test <- read_data("./UCI HAR Dataset/test/Inertial Signals/body_acc_z_test.txt")

#body acceleration - training
body_acc_x_train <- read_data("./UCI HAR Dataset/train/Inertial Signals/body_acc_x_train.txt")
body_acc_y_train <- read_data("./UCI HAR Dataset/train/Inertial Signals/body_acc_y_train.txt")
body_acc_z_train <- read_data("./UCI HAR Dataset/train/Inertial Signals/body_acc_z_train.txt")

#body gyro - test
body_gyro_x_test <- read_data("./UCI HAR Dataset/test/Inertial Signals/body_gyro_x_test.txt")
body_gyro_y_test <- read_data("./UCI HAR Dataset/test/Inertial Signals/body_gyro_y_test.txt")
body_gyro_z_test <- read_data("./UCI HAR Dataset/test/Inertial Signals/body_gyro_z_test.txt")

#body gyro - training
body_gyro_x_train <- read_data("./UCI HAR Dataset/train/Inertial Signals/body_gyro_x_train.txt")
body_gyro_y_train <- read_data("./UCI HAR Dataset/train/Inertial Signals/body_gyro_y_train.txt")
body_gyro_z_train <- read_data("./UCI HAR Dataset/train/Inertial Signals/body_gyro_z_train.txt")

#join test and training data sets
subjects <- rbind(subjects_test, subjects_train)
activity <- rbind(actv_test, actv_train)  
body_acc_x <- rbind(body_acc_x_test, body_acc_x_train)
body_acc_y <- rbind(body_acc_y_test, body_acc_y_train)
body_acc_z <- rbind(body_acc_z_test, body_acc_z_train)
body_gyro_x <- rbind(body_gyro_x_test, body_gyro_x_train)
body_gyro_y <- rbind(body_gyro_y_test, body_gyro_y_train)
body_gyro_z <- rbind(body_gyro_z_test, body_gyro_z_train)


# remove the individual data sets to save memory
remove(subjects_test, subjects_train) 
remove(actv_test, actv_train) 
remove(body_acc_x_test, body_acc_x_train)
remove(body_acc_y_test, body_acc_y_train)
remove(body_acc_z_test, body_acc_z_train)


#Define read_data function to read the measurement text files.
#It takes the file name as parameter and returns the dataframe.

read_data <- function(filename){
  file_lines <- readLines(filename)
  result_df <- as.data.frame(matrix(nrow=0,ncol=128)) #empty results data frame

    
  for(line in file_lines) {
    #trim then replace double space with single space
    line_clean <- gsub("  ", " ", str_trim(line))
    
    #split into individual values and cast as numeric matrix
    line_df <- line_clean %>% 
      str_split(" ") %>% 
      sapply(as.numeric) %>% 
      t() #transpose to wide 1x128 matrix
    
    #add to existing results
    result_df <- rbind(result_df, line_df)
  }
  
  #return results
  result_df
}


#filename <- "./UCI HAR Dataset/test/Inertial Signals/body_acc_x_test.txt"
#line <- x[1]

#the line becomes a 1x128 matrix
#option1: transpose 128x1 and join to the rest of the data, then use pivot or gather

#final dataframe columns
#set, subjectID, activity, measurement, result 

