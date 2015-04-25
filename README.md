# README file for Getting and Cleaning Data course project
--------------------------------------------------------------------------------

## Overview
This repository contains code for cleaning a dataset as required for the course
project for "Getting and Cleaning Data".

The user should download the raw data and use the run_analysis.R script in this
repository to clean the data and produce the tidy dataset.  The script can be run as

```
run_analysis()
```

This code will clean the raw dataset and write a single text file containing
the tidy data called "tidy_data.txt", which is also included in this repository.
This file contains 66 different variables from the raw dataset which have been
averaged over subject and activity.

There is a code book in this repository called "CodeBook.md" which contains a description
of the raw and tidy data, the cleaning procedure, and descriptions of the variables.

## DESCRIPTION OF DATA CLEANING CODE (run_analysis.R)
1. Load activity labels and description from "activity_labels.txt" in the raw
   dataset.  This matches an ID number to an activity description.
2. Load variable names from "features.txt" in the raw dataset.
3. Load data files for the training and test datasets ("train/X_train.txt" and
	"test/X_test.txt") and assign to data tables.
4. Load the activity IDs for each observation in the training and test
	datasets ("train/y_train.txt" and "test/y_test.txt").
5. Load the subject IDs for each observation in the training and test datasets
	("train/subject_train.txt" and "test/subject_test.txt").
6. Assign column names to each data table using the variable names from step 2.
7. Pick out only variables that are mean or standard deviation measurements.
8. Add the activity IDs from step 4 to a new variable in each data table.
9. Add the subject IDs from step 5 to a new variable in each data table.
10. Bind the training and test data tables into one data table.
11. Use a left_join to add activity descriptions to the data table
    based on the activity IDs.
12. Remove activity IDs since they are not useful.
13. Group observations by subject ID and activity.
14. Calculate the mean of each measurement in each group.
15. Clean up variable names using the following format:
	- Replace "t" and "f" prefixes with "time" and "freq", respectively.
	- Replace erroneous occurrences of "BodyBody" with "Body".
	- Replace "-" by "_".
	- Replace "Acc" by "Accel".
	- Remove occurrences of "()".
	
	These steps were taken to improve variable readability and remove
	problematic variable name formatting.
16. Save the new tidy data in a space-separated text file.

