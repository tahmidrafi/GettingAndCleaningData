get_feature_names <- function(file, sep = " ", colClasses = c("integer", "character")) {
    features <- read.table(file = file, sep = sep, colClasses = colClasses)
    feature_names <- features[,2]
    
    feature_names
}

get_merged_data <- function(file){
    
    X_train_file = paste(file, "train/X_train.txt", sep="")
    X_test_file = paste(file, "test/X_test.txt", sep="")
    
    Y_train_file = paste(file, "train/Y_train.txt", sep="")
    Y_test_file = paste(file, "test/Y_test.txt", sep="")
    
    # read X
    message("Reading X_train from: ", X_train_file)
    X_train <- read.table(X_train_file)
    message("Reading X_test from: ", X_test_file)
    X_test <- read.table(X_test_file)
    
    message("merging X_train and X_test")
    X <- rbind(X_train, X_test)
    
    # read Y
    message("Reading Y_train from: ", Y_train_file)
    Y_train <- read.table(Y_train_file)
    message("Reading Y_test from: ", Y_test_file)
    Y_test <- read.table(Y_test_file)
    
    message("merging Y_train and Y_test")
    Y <- rbind(Y_train, Y_test)
    
    # merge X and Y
    message("merging Y and X")
    data <- cbind(Y, X)
    
    data
    
}

label_data <- function(file, data) {
    
    activity_labels_file = paste(file, "activity_labels.txt", sep="")
    features_file <- paste(file, "features.txt", sep="")
    
    message("Reading feature names")
    feature_names <- get_feature_names(features_file)
    feature_names <- c("Activity", feature_names)
    
    message("Labeling variables")
    colnames(data) <-feature_names
    
    message("Reading activity names")
    activity <- read.table(activity_labels_file, col.names = c("no", "name"))
    
    data$Activity <- factor(data$Activity, levels=activity$no, labels=activity$name)
    
    data
}

ff <- function() {
    file = "getdata-projectfiles-UCI HAR Dataset/"
    
    message("Started Reading Data...\n")
    data <- get_merged_data(file)
    message("Data Merging Completed.\n")
    message("Labeling Data...\n")
    data <- label_data(file, data)
    message("Data Labeling Completed.\n")
    data
    
}

