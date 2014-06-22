### The algorithms
1. Unzip the data, all the data will be in the subdirectory: UCI HAR Dataset
2. Use read.table to read the training and test sets
3. Append two columns to training and test sets: the ActivityID and Subject fromY_train.txt and subject_train.txt respectively.
4. Get the variable names and lables from features.txt and activity_labels.txt
5. Merge the training and test sets by rbind
6. Extract the mean and standard deviations from the merged data.
7. Apply the appropriable lables to the measurements and the newly added columns
8. Create a tidy data set with the average of each variable for each activity and each subject. This is implemented with the function aggregate.
9. Drop off the unuseful column ActivityID as there is already the Activity column.
10.Write out the tidy data with write.table


### How to run the analysis:

source("run_analysis.R")

The output tidy data is in the file: tidy.txt



