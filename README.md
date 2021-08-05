# Data Cleaning Assignment - RunAnalysis

This project is for the Coursera course: Getting and Cleaning Data > Week 4 > Getting and Cleaning Data Course Project 
The base data set is made available by the UCI HAR Dataset (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
The base dataset is divided into two parts - test & training 

## The script run_analysis.R 
1. extracts the input files,
2. joins the test and train files into a single dataset,
3. produces a summarised data file, which contains the mean of each summarised measurement features.

The features are summarised (min/max/mean/std/jerk/entropy etc) values derived from the raw measurements from
- acceleration in the x,y,z axis
- gyro (angular velocity) in the x,y,z axis

## Input files
- subject_test/train = list of subjects performing in the test/training set.
- X_test/train = summarised features of the measurements. Each line has 561 feature values.
- y_test/train = activity performed in test/training set.
- activity_labels = Activity codes.

## How the analysis works
The script uses the tidyverse library. It utilises read.csv() and a custom read_data() functions to read the text data files into data frames. It then joins the test dataset and the training dataset together, and attaches the subject (people who perfomed the activities) and the activities (walking/sitting etc) to the dataset.  Only feature values that contain a mean or standard deviation are kept for further analysis. Finally, the std & mean features values are averaged for each subject and activity.

## Output file
The df_summary text file contain the mean value of the selected feature values for each subject and activity.
