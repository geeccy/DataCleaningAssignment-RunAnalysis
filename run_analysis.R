# Getting and Cleaning Data > Week 4 > Getting and Cleaning Data Course Project 
# Using the UCI HAR Dataset (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
#
# INPUT FILES:
# subject_test/train = list of subjects performing in the test/training set.
# X_test/train = summarised features of the measurements. Each line has 561 summary values.
# y_test/train = activity performed in test/training set.
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

#features
x_test <- read_data("./UCI HAR Dataset/test/X_test.txt")
x_train <- read_data("./UCI HAR Dataset/train/X_train.txt")

feature_heading <- read.csv("./UCI HAR Dataset/features.txt", header = FALSE, sep = " ")

#drop the first column which is just the index
feature_heading <- feature_heading[,2]

#join test and training data sets
subjects <- rbind(subjects_test, subjects_train)
activity <- rbind(actv_test, actv_train)  
features <- rbind(x_test, x_train)

#assign headings to the features df
names(features) <- feature_heading


# remove the individual data sets to save memory
remove(subjects_test, subjects_train) 
remove(actv_test, actv_train) 
remove(x_test, x_train)


#find columns with std or mean
useful_headings <- c(grep("-std()",feature_heading), grep("-mean()", feature_heading))

#select the features with std/mean values
useful_features <- features[,useful_headings]

#merge the activity with its labels
activity <- merge(activity, activity_lbl, by.x = "actID", by.y = "actID")
activity <- activity[,2]

#join the datasets together
df <- cbind(subjects, activity, useful_features)

#create summary dataframe with the mean of each measurement for each subject and activity.
df_summary <- df %>% 
  group_by(subjectID, activity) %>% 
  summarise_all(mean)

#output summary dtaframe
write.table(df_summary, "df_summary.txt", row.names = FALSE)


#--------------------------------------------------------------#
#Define read_data function to read the measurement text files.
#It takes the file name as parameter and returns the dataframe.
read_data <- function(filename){
  file_lines <- readLines(filename)
  result_df <- as.data.frame(matrix(nrow=0,ncol=561)) #empty results data frame
  
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

