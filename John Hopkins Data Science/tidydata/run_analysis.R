###########################################################
#
# This  file contains all of the code to automate reading, 
# merging and tidying the raw samsung mobile phone data. 
# See CodeBook.md for details.
#
###########################################################

library(data.table)
library(LaF)
library(dplyr)

# The experiment data observations are all the same format - 561 x 16 character fixed width numeric columns.
# Since we'll be using LaF to read in the data, we need vectors containing the column widths and column types
col_widths <- rep(16,561)
col_types <- rep("numeric",561)

# Read in the two X data files using LaF (nice and fast)
train <- laf_open_fwf("./data/train/x_train.txt", column_widths = col_widths, column_types= col_types)
test <- laf_open_fwf("./data/test/x_test.txt", column_widths = col_widths, column_types= col_types)

# Merge the X data files into a data frame using dplyr
x_data <- bind_rows(train[,], test[,])

# Read in feature names (i.e. column names) so that we can subset the data to just the columns we're interested in
features <- read.table("./data/features.txt", stringsAsFactors=F)
col_names <- make.names(features$V2)

# subset the X data to select only measurements for mean and standard deviation... it's easier to do this before we 
# merge in data for the subject and activity
mean_cols <- grep("mean|std", col_names)
mean_data <- x_data %>% select(mean_cols)

# While we're at it, we may as well set the column names - there's no reason to wait until later on to do this
setnames(mean_data, 1:length(mean_cols), col_names[mean_cols])

# Read and merge the two y data files (these are basically just the activity code column for our X_data). 
train <- read.table("./data/train/y_train.txt")
test <- read.table("./data/test/y_test.txt")
activities <- bind_rows(train, test)

# Add the y_data as an "activity" column to our mean data. Note that we look up factor variables to use instead of 
# numeric constants for each of the activities from our activity_lables.txt file for this
activity_labels <- read.table("./data/activity_labels.txt")
activities <- merge(activities, activity_labels, by="V1")
mean_data$activity <- activities[,2]

# Now read in the data for subects... like activities (the y_data), the id of the "subject" that each observation 
# relates to is stored in a separate files.
train <- read.table("./data/train/subject_train.txt")
test <- read.table("./data/test/subject_test.txt")
subjects <- bind_rows(train, test)
mean_data$subject <- subjects$V1

# Finally, create our tidy summary of the data
tidy_data <- mean_data %>% 
    group_by(activity, subject) %>%
    summarise_each(funs(mean))

# And write the results out to ./output/tidy.txt
dir.create(file.path(".", "output"), showWarnings = FALSE)
write.table(tidy_data, "./output/tidy.txt", row.names = FALSE, quote=FALSE, sep="\t")
