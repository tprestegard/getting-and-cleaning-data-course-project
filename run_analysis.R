run_analysis <- function() {
    
    ## Load dplyr and tidyr packages.
    library(dplyr,tidyr)
    
    ## Load activity labels - can use these along with *_y files to 
    ## determine which activity was being performed.
    act_labels <- read.table("data/UCI HAR Dataset/activity_labels.txt",
                             header=FALSE, sep="",
                             col.names=c("act_id","activity"),
                             stringsAsFactors=FALSE)
    
    ## Load features - these tell us the variable names.
    ## These will be used to assign column names when loading
    ## the data.
    features <- read.table("data/UCI HAR Dataset/features.txt",
                            header=FALSE, sep="",
                            col.names=c("var_id","var_label"),
                            stringsAsFactors=FALSE,
                            check.names=FALSE) 
    
    ## Load data files. ####################################
    ## *_X contains the observations of all 561 variables for
    ## the training and test data sets, respectively.
    train_X <- read.table("data/UCI HAR Dataset/train/X_train.txt",
                            header=FALSE, sep="", comment.char="",
                            colClasses="numeric")
    test_X <- read.table("data/UCI HAR Dataset/test/X_test.txt",
                            header=FALSE, sep="", comment.char="",
                            colClasses="numeric")
    
    ## *_y gives the activity ID number, which corresponds
    ## to an entry in activity_labels.txt
    train_y <- read.table("data/UCI HAR Dataset/train/y_train.txt",
                          header=FALSE, sep="", comment.char="",
                          colClasses="numeric", col.names="act_id")
    test_y <- read.table("data/UCI HAR Dataset/test/y_test.txt",
                         header=FALSE, sep="", comment.char="",
                         colClasses="numeric", col.names="act_id")
                         
    ## *_subj contains the subject ID for each observation.
    train_subj <- read.table("data/UCI HAR Dataset/train/subject_train.txt",
                             header=FALSE, sep="", comment.char="",
                             colClasses="numeric", col.names="subject_id")

    test_subj <- read.table("data/UCI HAR Dataset/test/subject_test.txt",
                            header=FALSE, sep="", comment.char="",
                            colClasses="numeric", col.names="subject_id")
    ########################################################
    
    ## Assign column names to the *_X data frames.
    names(train_X) <- features$var_label
    names(test_X) <- features$var_label

    ## Pick out only mean() and std() variables.
    match_str = "mean\\(\\)|std\\(\\)"    
    train_X <- train_X[,grep(match_str,names(train_X))]
    test_X <- test_X[,grep(match_str,names(test_X))] 
   
    ## Join the activity IDs to each of the *_X data tables.
    train_X$act_id <- train_y$act_id
    test_X$act_id <- test_y$act_id
    
    ## Join the subject IDs to each of the *_X data tables.
    train_X$subject_id <- train_subj$subject_id
    test_X$subject_id <- test_subj$subject_id
        
    ## Bind the training and test data tables by rows.
    full_df <- bind_rows(tbl_df(train_X),tbl_df(test_X))
    
    ## Add activity labels.
    full_df <- left_join(full_df,act_labels,by="act_id")
    
    ## Rearrange data frame columns to put dataset, subject_id,
    ## and activity on the left.  Remove act_id since it doesn't
    ## seem to be useful.
    full_df <- select(full_df,subject_id,activity,1:67,-act_id)

    ## Arrange by subject_id, activity.
    full_df <- arrange(full_df,subject_id,activity)
        
    ## Group by activity and subject_id.
    group_df <- group_by(full_df,subject_id,activity)

    ## Summarize.
    summary_df <- summarise_each(group_df,funs(mean))
    
    ## Clean up names. #####################################
    ## Replace t with time and f with freq at the start of names.
    names(summary_df) <- gsub("^t","time",names(summary_df))
    names(summary_df) <- gsub("^f","freq",names(summary_df))
    
    ## Replace instances of BodyBody with Body.
    names(summary_df) <- gsub("BodyBody","Body",names(summary_df))
    
    ## Replace - with _.
    names(summary_df) <- gsub("-","_",names(summary_df))
    
    ## Replace Acc with Accel.
    names(summary_df) <- gsub("Acc","Accel",names(summary_df))
    
    ## Remove ().
    names(summary_df) <- gsub("\\(\\)","",names(summary_df))
    
    ## Save data.
    write.table(summary_df,"tidy_data.txt",row.names=FALSE, quote=FALSE)

}