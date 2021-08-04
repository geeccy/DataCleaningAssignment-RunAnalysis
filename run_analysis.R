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



#body acceleration - training

#body gyro - test

#body gyro - training




