
run_analysis<-function(){

  library(dplyr)
  #creating dircetory
  if(!file.exists("Project")){         
  dir.create("Project")}

  #Downloading files
  url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(url,destfile = "./Project/final.zip")
  unzip(zipfile="./Project/final.zip",exdir="./Project")

  #Reading Data  
    #reading train data
    x_train<-read.table("./Project/UCI HAR Dataset/train/x_train.txt",header=FALSE)
    y_train<-read.table("./Project/UCI HAR Dataset/train/y_train.txt",header=FALSE)
    subject_train<-read.table("./Project/UCI HAR Dataset/train/subject_train.txt",header=FALSE)
  
    #reading test data
    x_test<-read.table("./Project/UCI HAR Dataset/test/x_test.txt",header=FALSE)
    y_test<-read.table("./Project/UCI HAR Dataset/test/y_test.txt",header=FALSE)
    subject_test<-read.table("./Project/UCI HAR Dataset/test/subject_test.txt",header=FALSE)
  
  #1 Merging  Training and Test dataset together
    #Bind rows if column dimensions match
    X_data<-if(dim(x_test)[[2]]==dim(x_train)[[2]]){rbind(x_test,x_train)}
    Y_data<-if(dim(y_test)[[2]]==dim(y_train)[[2]]){rbind(y_test,y_train)}
    SubjectID<-if(dim(subject_test)[[2]]==dim(subject_train)[[2]]){
    rbind(subject_test,subject_train)}
    names(SubjectID)<-c("Subject_ID")
  
  #2 Extracts only the measurements on the mean and standard deviation for each measurement
    #Reading features to select mean and std data
    features<-read.table("./Project/UCI HAR Dataset/features.txt",header=FALSE, col.names=c('ID', 'Name'))
    features_filtered<-grep('mean\\(\\)|std\\(\\)',features$Name)
    Filtered_observations<-X_data[,features_filtered] 
    names(Filtered_observations) <- features[features$ID %in% features_filtered, 2] 
    
    #renaming those long names
    newNames=names(Filtered_observations)
    newNames <- gsub(pattern="-?mean[(][)]-?",replacement=".Mean.",x=newNames)
    newNames <- gsub(pattern="-?std[()][)]-?",replacement=".Std.",x=newNames)
    newNames <- gsub(pattern="-?meanFreq[()][)]-?",replacement="MeanFreq",x=newNames)
    newNames <- gsub(pattern="^t",replacement="T-",x=newNames)
    newNames <- gsub(pattern="^f",replacement="F-",x=newNames)
    newNames <- gsub(pattern="BodyBody",replacement="Body",x=newNames)
    names(Filtered_observations)=newNames
  
  #3 Uses descriptive activity names to name the activities in the data set
    #Reading activity labels
    activity<-read.table("./Project/UCI HAR Dataset/activity_labels.txt",header=FALSE,col.names=c('ID', 'Name'))  
  
  #4 Appropriately labels the data set with descriptive variable names.    
    #substituting activities from #3 to label Y_data
    Y_data[, 1] = activity[Y_data[, 1], 2]
    names(Y_data) <- "Activity"  
    
    ## Creating First Tidy Data Set
    Dataset_1<-cbind(SubjectID,Y_data,Filtered_observations)
    
  #5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable 
  #for each activity and each subject.  

    Final_dataset <- aggregate(Filtered_observations, list(Dataset_1$Subject_ID, Dataset_1$Activity), mean)
    names(Final_dataset)[1:2] <- c('Subject', 'Activity')
    
    write.csv(Dataset_1, "./Project/Complete_Dataset.csv") #this is the intermediate dataser
    write.csv(Final_dataset, "./Project/Tidy_dataset.csv") #this is the final dataset in CSV
    write.table(Final_dataset, "./Project/Tidy_dataset.txt",row.name=FALSE) #final dataset for submission
    
      }
