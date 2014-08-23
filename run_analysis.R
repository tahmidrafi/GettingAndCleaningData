get_feature_names <- function(file, sep = " ", colClasses = c("integer", "character")) {
    features <- read.table(file = file, sep = sep, colClasses = colClasses)
    feature_names <- features[,2]
    
    feature_names
}

get_merged_data <- function(file){
    
    X_train_file = paste(file, "train/X_train.txt", sep="")
    X_test_file = paste(file, "test/X_test.txt", sep="")
    
    # read X
    message("Reading X_train from: ", X_train_file)
    X_train <- read.table(X_train_file)
    message("Reading X_test from: ", X_test_file)
    X_test <- read.table(X_test_file)
    
    message("merging X_train and X_test")
    X <- rbind(X_train, X_test)
    
    X

}

extract_columns <- function(file, data) {
    
    required_features_file <- paste(file, "required_features.txt", sep="")
    
    required_features <- read.table(required_features_file)
    
    data <- data[,required_features[,1]]
    
    data
    
}

merge_subject_activity <- function(file, data ) {
    
    Y_train_file = paste(file, "train/Y_train.txt", sep="")
    Y_test_file = paste(file, "test/Y_test.txt", sep="")
    
    subject_train_file = paste(file, "train/subject_train.txt", sep="")
    subject_test_file = paste(file, "test/subject_test.txt", sep="")
    
    # read Y
    message("Reading Y_train from: ", Y_train_file)
    Y_train <- read.table(Y_train_file)
    message("Reading Y_test from: ", Y_test_file)
    Y_test <- read.table(Y_test_file)
    
    message("merging Y_train and Y_test")
    Y <- rbind(Y_train, Y_test)
    
    # read subject
    message("Reading subject_train from: ", subject_train_file)
    subject_train <- read.table(subject_train_file)
    message("Reading subject_test from: ", subject_test_file)
    subject_test <- read.table(subject_test_file)
    
    message("merging subject_train and subject_test")
    subject <- rbind(subject_train, subject_test)
    
    # merge X and Y and subject
    message("merging subject, Y and X")
    data <- cbind(subject, Y, data)
    
    data
    
}

label_data <- function(file, data) {
    
    activity_labels_file = paste(file, "activity_labels.txt", sep="")
    required_features_file <- paste(file, "required_features.txt", sep="")
    
    message("Reading required feature names")
    required_features <- get_feature_names(required_features_file)
    
    message("Labeling variables")
    colnames(data) <- c("subject", "activity", required_features)
    
    message("Reading activity names")
    activity <- read.table(activity_labels_file, col.names = c("no", "name"))
    
    message("Factorizing activities and subjects")
    data$activity <- factor(data$activity, levels=activity$no, labels=activity$name)
    data$subject <- factor(data$subject)
    
    data
}

find_mean <- function(file, data) {
    
    required_features_file <- paste(file, "required_features.txt", sep="")
    required_features <- get_feature_names(required_features_file)
    
    message("Splitting data")
    split_data <- split(data, list(data$activity, data$subject))
    message("Data splitting completed")
    
    message("Calculating Mean")
    mean_data <- sapply(split_data, function(x) colMeans(x[,required_features]))
    
    mean_data
    
}


ff <- function() {
    file = "getdata-projectfiles-UCI HAR Dataset/"
    
    message("Started Reading Data...\n")
    data <- get_merged_data(file)
    message("Data Reading Completed.\n")
    
    message("Started Extracting Necessary Columns...\n")
    data <- extract_columns(file, data)
    message("Necessary Columns Extracted.\n")
    
    message("Loading Activity and Subject...\n")
    data <- merge_subject_activity(file, data)
    message("Activity and Subject Loaded.\n")
    
    message("Labeling Data...\n")
    data <- label_data(file, data)
    message("Data Labeling Completed.\n")
    
    message("Generating Mean...\n")
    data <- find_mean(file, data)
    message("Mean Generation Completed.\n")
    
    data
    
}

