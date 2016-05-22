    run_analysis<-function()
    {
        
        filename <- "UCI_HAR_Dataset.zip"
        
        ## Download and unzip the dataset:
        if (!file.exists(filename)){
            fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
            download.file(fileURL, filename, method="curl")
        }  
        if (!file.exists("UCI HAR Dataset")) { 
            unzip(filename) 
        }
        # load test data  
        subject_test = read.table("UCI HAR Dataset/test/subject_test.txt")
        X_test = read.table("UCI HAR Dataset/test/X_test.txt")
        Y_test = read.table("UCI HAR Dataset/test/Y_test.txt")
        
        # load training data
        subject_train = read.table("UCI HAR Dataset/train/subject_train.txt")
        X_train = read.table("UCI HAR Dataset/train/X_train.txt")
        Y_train = read.table("UCI HAR Dataset/train/Y_train.txt")
        # load lookup information
        features <- read.table("UCI HAR Dataset/features.txt", col.names=c("featureId", "featureLabel"))
        activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names=c("activityId", "activityLabel"))
        activities$activityLabel <- gsub("_", "", as.character(activities$activityLabel))
        #Extract only the measurements on the mean and standard deviation for each measurement.
        includedFeatures <- grep("-mean\\(\\)|-std\\(\\)", features$featureLabel)
       
         #Merging the training and the test sets to create one data set.
        subject <- rbind(subject_test, subject_train)
        names(subject) <- "subjectId"
        #combine by Rows of X_test &  X_train
        X <- rbind(X_test, X_train)
        X <- X[, includedFeatures]
        names(X) <- gsub("\\(|\\)", "", features$featureLabel[includedFeatures])
        Y <- rbind(Y_test, Y_train)
        names(Y) = "activityId"
        activity <- merge(Y, activities, by="activityId")$activityLabel
        
        # merge data frames of different columns to form one data table
        data <- cbind(subject, X, activity)
        write.table(data, "merged_tidy_data.txt")
        
        # create a dataset grouped by subject and activity after applying standard deviation and average calculations
        library(data.table)
        dataDT <- data.table(data)
        calculatedData<- dataDT[, lapply(.SD, mean), by=c("subjectId", "activity")]
        write.table(calculatedData, "calculated_mean_data.txt")
    }