run_analysis(){
  ## Read and Naming Data sets
  x_test <- read.table("./X_test.txt", na.strings = "N/A", stringsAsFactors = FALSE)
  y_test <- read.table("./y_test.txt", na.strings = "N/A", stringsAsFactors = FALSE)
  subject_test <- read.table("./subject_test.txt", na.strings = "N/A", stringsAsFactors = FALSE)
  x_train <- read.table("./X_train.txt", na.strings = "N/A", stringsAsFactors = FALSE)
  y_train <- read.table("./y_train.txt", na.strings = "N/A", stringsAsFactors = FALSE)
  subject_train <- read.table("./subject_train.txt", na.strings = "N/A", stringsAsFactors = FALSE)
  activity_labels <- read.table("./activity_labels.txt", na.strings = "N/A", stringsAsFactors = FALSE)
  allColName <- read.table("./features.txt", na.strings = "N/A", stringsAsFactors = FALSE)
  names(x_test) <- allColName$V2
  names(x_train) <- allColName$V2
  
  ## Merging
  y_test$id <- 1:nrow(y_test)
  y_train$id <- 1:nrow(y_train)
  y_test2 <- merge(y_test, activity_labels, by.x = "V1", by.y = "V1", all = FALSE, sort = FALSE)
  y_test2 <- y_test2[order(y_test2$id),]
  y_train2 <- merge(y_train, activity_labels, by.x = "V1", by.y = "V1", all = FALSE, sort = FALSE)  
  y_train2 <- y_train2[order(y_train2$id),]
  x_test$activity <- y_test2$V2
  x_train$activity <- y_train2$V2
  x_test$dataType <- rep("Test", nrow(x_test))
  x_test$subjectId <- subject_test$V1
  x_train$dataType <- rep("Train", nrow(x_train))
  x_train$subjectId <- subject_train$V1
  df <- rbind(x_test,x_train)
  
  
  ## Extracting only mean & std
  colPosition <- grep("mean|std",names(df))
  df2 <- df[,c(564,562,563,colPosition)]
  df2 <- df2[order(df2$subjectId,df2$activity),]
  
  ## Calculating Mean of Each Combination
  library(reshape2)
  dfMelted <- melt(df2, id = names(df2)[1:2], measure.vars = names(df2)[4:82])
  dfCasted <- dcast(dfMelted, subjectId + activity ~ variable, mean)
  write.table(dfCasted, file = "./run_analysis.txt", row.name=FALSE)
  
}