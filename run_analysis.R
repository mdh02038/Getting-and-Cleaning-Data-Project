library(plyr)


# filenames
baseDir <- "UCI\ HAR\ Dataset"
trainDir <- paste( baseDir, "train", sep="/")
testDir <- paste( baseDir, "test", sep="/")
features_txt <- paste(".", baseDir, "features.txt", sep="/")
activity_labels_txt <- paste(".", baseDir, "activity_labels.txt", sep="/")
subject_train_txt <- paste(trainDir, "subject_train.txt", sep="/")
X_train_txt <- paste(trainDir, "X_train.txt", sep="/")
y_train_txt <- paste(trainDir, "y_train.txt", sep="/")
subject_test_txt <- paste(testDir, "subject_test.txt", sep="/")
X_test_txt <- paste(testDir, "X_test.txt", sep="/")
y_test_txt <- paste(testDir, "y_test.txt", sep="/")

# load feature names
featureNames <- read.table(features_txt, sep=" ", stringsAsFactors=FALSE)

# load activity labels
activityNames <- read.table(activity_labels_txt, sep=" ", stringsAsFactors=FALSE)

# load training data

train <- read.table(X_train_txt, stringsAsFactor=FALSE, header=FALSE, strip.white=TRUE, col.names=featureNames[,2], row.names=NULL)
train$subject <- as.matrix(read.table(subject_train_txt, stringsAsFactor=FALSE, header=FALSE, strip.white=TRUE))
train$label <- as.matrix(read.table(y_train_txt, stringsAsFactor=FALSE, header=FALSE, strip.white=TRUE))
train$source <- rep("train", times=dim(train$label)[1])

# load test data

test <- read.table(X_test_txt, stringsAsFactor=FALSE, header=FALSE, strip.white=TRUE, col.names=featureNames[,2], row.names=NULL)
test$subject <- as.matrix(read.table(subject_test_txt, stringsAsFactor=FALSE, header=FALSE, strip.white=TRUE))
test$label <- as.matrix(read.table(y_test_txt, stringsAsFactor=FALSE, header=FALSE, strip.white=TRUE))
test$source <- rep("test", times=dim(test$label)[1])

# combine training and test data
data <- rbind( train, test )

# change activity number to text
data$label <- sapply( data$label, function(l) { activityNames[l,2]})

# select column names containing std or mean
select <- grepl("std|mean", names(data))
data <- data[, (which(grepl("std|mean|subject|label", names(data))))]

# use previous data to create a new data frame taking the mean of all columns for all subjects x activities
data2 <- ddply( data, .(label, subject), numcolwise(mean) )

# write out table
write.table( data2, "data2.txt", row.names=FALSE)