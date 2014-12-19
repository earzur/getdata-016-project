data_path <- 'UCI HAR Dataset'

activities <- read.table(file.path(data_path,'activity_labels.txt'))
features <- read.table(file.path(data_path,'features.txt'))

# map a data frame from the 'y' set (activities numbers)
# with the activity labels in activities.txt
map_activities <- function(x) {
  lapply(x, function(y) activities[y,2])
}

# build a data frame with named columns from the samsung data
# x - content of the X_<set>.txt (accelerometer measures)
# y - activity (content of y_<set>.txt)
# s - subject (content of subject_<set>.txt)
#
# returns a data frame with the following data
# 1. subject
# 2. activity label
# 3. measures in the data set
#
# measure columns are named according to the content of features.txt
load_data <- function(dataset) {
  # data
  px <- file.path(data_path,dataset,sub('xxxx',dataset,'X_xxxx.txt')) 
  message(paste("Reading accelerometer data from",px))
  x <- read.table(px)
  # name columns based on the content of the features file
  names(x) <- features[,2]
  # activity
  py <- file.path(data_path,dataset,sub('xxxx',dataset,'y_xxxx.txt'))
  message(paste("Reading activity data from",py))
  y <- read.table(py,col.names='activity')
  # subject 
  ps <- file.path(data_path,dataset,sub('xxxx',dataset,'subject_xxxx.txt'))
  message(paste("Reading subject data from",ps))
  s <- read.table(ps,col.names='subject')
  
  cbind(s,map_activities(y),x)
}

load_and_prepare <- function() {
  # load an merge the 2 datasets
  d <- rbind(load_data('test'),load_data('train'))
  # columns we are interested in contain mean() or std()
  interesting_cols <- grep('mean\\(\\)|std\\(\\)',names(d))
  # keep the interesting columns as well as subject and activity
  d <- d[, c(1,2,interesting_cols)]
  # compute mean values for every (subject,activity) groups
  result <- aggregate(. ~ subject + activity, d, mean)    
}

result <- load_and_prepare()
message("Writing results to output.txt")
write.table(result,file='output.txt',row.names=FALSE)
