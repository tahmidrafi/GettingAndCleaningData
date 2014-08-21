get_feature_names <- function(file, sep = " ", colClasses = c("integer", "character")) {
    features <- read.table(file = file, sep = sep, colClasses = colClasses)
    feature_names <- features[,2]
    
    feature_names
}