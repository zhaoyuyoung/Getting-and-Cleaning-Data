# Read the data from the subdirectory ./UCI HAR Dataset
# training and test sets.
training = read.table("UCI HAR Dataset/train/X_train.txt", header=F)
ncols = ncol(training)
training[,ncols+1] = read.table("UCI HAR Dataset/train/Y_train.txt", header=F)
training[,ncols+2] = read.table("UCI HAR Dataset/train/subject_train.txt", header=F)
testset = read.table("UCI HAR Dataset/test/X_test.txt", header=F)
testset[,ncols+1] = read.table("UCI HAR Dataset/test/Y_test.txt", header=F)
testset[,ncols+2] = read.table("UCI HAR Dataset/test/subject_test.txt", header=F)

# feature and activiery labels.
features = read.table("UCI HAR Dataset/features.txt", header=F)
features[,2] = gsub('-mean', 'Mean', features[,2])
features[,2] = gsub('-std', 'Std', features[,2])
features[,2] = gsub('[-()]', '', features[,2])
labels = read.table("UCI HAR Dataset/activity_labels.txt", header=F, col.names=c("ActivityID", "Activity"))

# Merge the training and test sets
mergedData = rbind(training, testset)

# Extract the mean and standard deviation.
subset <- grep(".*Mean.*|.*Std.*", features[,2])
features <- features[subset,]
subset <- c(subset, ncols+1, ncols+2)
mergedData <- mergedData[,subset]
colnames(mergedData) <- c(features$V2, "ActivityID", "Subject")

# Apply the lables to the activities
labels$Activity <- as.factor(labels$Activity)
labeledData <- merge(mergedData, labels)

# Create a tidy data set with the average of each variable for each activity and each subject
labeledData$Activity <- as.factor(labeledData$Activity)
labeledData$Subject <- as.factor(labeledData$Subject)
tidydata = aggregate(. ~ Activity + Subject, data=labeledData, FUN=mean, na.rm=TRUE)
output<-subset( tidydata, select = -ActivityID )
write.table(output, "tidy.txt")