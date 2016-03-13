Requirements
============

The following were used to process the raw data and generate the tidy data described in this cookbook:

* R v3.02
* data.table
* dplyr
* LaF  

Obtaining the raw data
======================

The raw data was downloaded as a zip file from the following URL:

* [UCI HAR Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

Nothing was done to this raw data other than to unzip this zip file into the `/data` folder of this repository. The internal folder structure of the original zip file was preserved during this operation.

Understanding the data
====================== 

As described in the `/data/Readme.txt` file, the original raw data are spread across various separate files. Of the various files provided in the zip file, only the following concern us for this project:

1. /data/train/X_train.txt
2. /data/train/y_train.txt
3. /data/train/subject_train.txt
4. /data/test/X_test.txt
5. /data/test/y_test.txt
6. /data/test/subject_test.txt
7. /data/features.txt
8. /data/activity_labels.txt

The bulk of the data are in the `X_train.txt` and `X_test.txt` files. Each of these files contains 561 fixed width (16 character) variables or *features* as described in the `features_info.txt` file. Appropriate names for each of these (unlabelled) columns can be read in from the `features.txt` file. 

The `y_train.txt` and `y_test.txt` files contain the activities that were being performed when each of the observations in `X_train.txt` and `X_text.txt` were recorded (respectively). So `y_train.txt` has the same number of rows as `X_train.txt` and `y_test.txt` has the same number of rows as `X_test.txt`. 

Similarly, the `subject_train.txt` and `subject_test.txt` files simply contain the ids of the subjects that each of the observations in `X_train.txt` and `X_test.txt` relate to. 

Finally, each of the activities that each of the subjects is performing (in the `y_train.txt` and `y_test.txt` files) is encoded as a numeric constant from 1 to 6. The actual meaning of each of these constants is listed in the `activity_labels.txt` file.

Reading the data
================
 
The data was read and tidied using the code in the `run_analysis.R` script that you'll find in this repository. The basic steps that this script executes are as follows:

1. Read in X_train.txt and X_test.txt using the [LaF package](http://cran.r-project.org/web/packages/LaF/index.html), which is an excellent package for working with big data (or if you have a really puny computer). 
2. Merge the training and test data into a single data frame: `x_data`
3. Read in feature names from the features.txt file and use to select only columns relating to the mean and standard deviation from x_data. Store the result in a data frame called `mean_data`. 
4. Read the training and test "activity codes" from the y_train.txt and y_test.txt files
5. Merge y training and test data into a data frame called `activities`
5. Look up the appropriate activity label for each activity code and add this as a second *factor* column in the activities data frame
6. Merge the activities *factor* column to our `mean_data` data frame
7. Read in the training and test subject ids from subject_train.txt and subject_test.txt and merge these into a single `subjects` data frame
8. Append the subject as an additional column to `mean_data`
9. Group the `mean_data` by activity then subject and then summarize this, calculating the mean of each variable (for each activity and subject). Store the results in a `tidy_data` data frame
10. Write the tidy data out to `./output/tidy.txt` as a TSV (tab separated value) file. 

Output
======

The resulting output of this process is the tidy.txt file in `./output/tidy.txt`. This is a tab separated value file containing the mean values for each of the original mean and standard deviation measurements for each activity and each subject in the experiment. 

The column names in this file are contained in the first header row of the file. 

* **activity** - This is a factor variable indicating the activity that was being performed when the observations were made
* **subject** - This is an integer between 1 and 30 identifying the *subject* that the observations relate to
* **other columns** - the remaining column names are simply named using the naming convention from the original study, only tidied for use in R using the `make.names` function. So, for example, **tBodyAcc-mean()-X** becomes **tBodyAcc.mean...X** (`make.names` replaces the parenthesis and the minus sign with dots so that these are syntactically correct variable names in R). As these are simply means of the original data, the units remain the same. You can find further information on those variables in the readme.txt and features_info.txt documents in the `/data` folder of this repository.  