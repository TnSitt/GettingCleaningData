# Code Book

This document describes the codes and operations in "run_analysis.R" file. There are 3 parts in this document:
1. Variables
2. Transformations

## Variables & Data
* x_test = storing data from "X_test.txt"
* y_test = storing data from "y_test.txt"
* subject_test = storing subject ID from "subject_test.txt"
* x_train = storing data from "X_train.txt"
* y_train = storing data from "y_train.txt"
* subject_train = storing subject ID from "subject_train.txt"
* activity_labels = storing activity code and label of each activity code. It is from fiel "activity_labels.txt"
* allColName = storing name of all variable that is measured in this data set. It is from file "features.txt"

## Transformation 

There are 4 main steps of this code.

1. Reading and Naming Data
2. Merging Data
3. Extracting Required Data (Mean & Standard Deviation)
4. Calculating Mean of Each Combination

### 1. Reading and Naming Data
* Reading all data into the following variables x_test, y_test, subject_test, x_train, y_train, subject_train, activity_labels, allColName
* Assigning column name (allColName) into x_test and x_train

### 2. Merging Data
* Creating new column named "id" in "y_test" and "y_train"
* Merge "activity_labels" into "y_test" and "y_train" and make them a new variable called "y_test2" and "y_train2". This is to assign the right activity label accordnigo to activity code in "y_test" and "y_train".
* Sort both "y_test2" and "y_train2" by "id" to make sure they are in the right order after merging.
* Create new column named "activity" in "x_test" and "x_train" with activity label data from "y_test2" and "y_train2"
* Create new column named "dataType" to both "x_test" and "x_train" so that we can easily separate them later after merging
* Create new column named "subjectId" from "subject_test" and "subject_train" into "x_test" and "x_train"
* Combine (rbind) "x_test" and "x_train" together and make it into a new data frame called "df"

### 3. Extracting Required Data (Mean & Standard Deviation)
* Use grep() function to find the position of columns that contain word "mean" or "std". Record this data into list called "colPosition".
* From "df", filter only columns from "colPosition" and some data such as "subjectId", "activity", and "dataType". Then, store this result into new data frame called "df2".
* Sort data in "df2" by "subjectId" and "dataType""

### 4. Calculating Mean of Each Combination
* First, melt "df2" to keep only "subjectId", "activity", "value", and "variable", which is those measurements with word "mean" or "std". Store result into new data frame called "dfMelted".
* Then, cast "dfMelted" by "subjectId" and "activity" with function "mean" on "variable"
* Finally, write data into text file "run_analysis" at working directory.

