#+----------------------------------+
#| Install & Load required packages |
#+----------------------------------+

# dplyr
if(!is.element("dplyr", installed.packages()[,1])){
    install.packages("dplyr")
}

library(dplyr)

#+------------------------+
#| Download & unpack Data |
#+------------------------+

datafile <- "data.zip"

if(!file.exists(datafile)){
    dataURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    message("Downloading Data from: ", dataURL)
    download.file(url = dataURL, destfile = datafile, mode = "wb")
}

if(!file.exists("UCI HAR Dataset")){
    message("Unzipping File: ", datafile, " to UCI HAR Dataset/ directory")
    unzip(zipfile = datafile)
}


#+--------------------------------+
#| Get Feature Names & Activities |
#+--------------------------------+

base_data_url = "UCI HAR Dataset"

feature_name_file <- paste0(base_data_url, "\\features.txt")
feature_names <- read.table(file = feature_name_file, 
                            sep = " ",
                            colClasses = c("integer", "character"), 
                            col.names = c("level", "label"))

activity_file <- paste0(base_data_url, "\\activity_labels.txt")
activity_names <- read.table(file = activity_file, 
                              sep = " ",
                              colClasses = c("integer", "character"), 
                              col.names = c("level", "label"))

message("Featurelist & Activity labels loaded")

required_features_index <- grep(".*(mean|std).*", feature_names[,2])
required_features <- feature_names[required_features_index, ]

#+------------------------------------+
#| Load & Merge: training & test data |
#+------------------------------------+

# Training Data
train_path <- paste0(base_data_url, "\\train")

X_train_file = paste0(train_path, "\\X_train.txt")
Y_train_file = paste0(train_path, "\\Y_train.txt")
subject_train_file = paste0(train_path, "\\subject_train.txt")

message("Reading X_train from: ", X_train_file)
X_train <- tbl_df(read.table(X_train_file, col.names = feature_names[,2]))

# Select features with only mean or std
X_train <- select(X_train, required_features_index)

message("Reading Y_train from: ", Y_train_file)
Y_train <- tbl_df(read.table(Y_train_file, col.names = "activity"))

message("Reading subject_train from: ", subject_train_file)
subject_train <- tbl_df(read.table(subject_train_file, col.names = "subject"))

data_train <- tbl_df(cbind(subject_train, Y_train, X_train))

# Test Data
test_path <- paste0(base_data_url, "\\test")

X_test_file = paste0(test_path, "\\X_test.txt")
Y_test_file = paste0(test_path, "\\Y_test.txt")
subject_test_file = paste0(test_path, "\\subject_test.txt")

message("Reading X_test from: ", X_test_file)
X_test <- tbl_df(read.table(X_test_file, col.names = feature_names[,2]))

# Select features with only mean or std
X_test <- select(X_test, required_features_index)

message("Reading Y_test from: ", Y_test_file)
Y_test <- tbl_df(read.table(Y_test_file, col.names = "activity"))

message("Reading subject_test from: ", subject_test_file)
subject_test <- tbl_df(read.table(subject_test_file, col.names = "subject"))

data_test <- tbl_df(cbind(subject_test, Y_test, X_test))

# Merge

merged_data <- tbl_df(rbind(data_train, data_test))

#+-------------------------+
#| Label by Activity Names |
#+-------------------------+

merged_data <- arrange(merged_data, subject, activity)
merged_data$activity <- factor(merged_data$activity, levels = activity_names$level, 
                               labels = activity_names$label)

colnames(merged_data) <- gsub('*(\\.\\.)*', "", colnames(merged_data))


#+------------------------------------+
#| Find mean per subject per activity |
#+------------------------------------+


final_tidy_data <- merged_data %>% 
                   group_by("subject", "activity") %>% 
                   summarise_each(funs(mean))

write.table(final_tidy_data, 
            file = "final_data/final_tidy_data.txt", 
            row.name = FALSE, sep = ",")