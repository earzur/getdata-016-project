library(dplyr)

data_path <- 'UCI HAR Dataset'
test_path <- file.path(data_path,'test')
train_path <- file.path(data_path,'train')

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
# 3:8 measures (extract only columns 1:6 from the X dataset (mean() and stddev()))
#
# measure columns are named according to the content of features.txt
prepare_data_set <- function(x,y,s) {
  result <- cbind(s,map_activities(y),x[,1:6])
  names(result)[1:2] <- c('subject','activity')
  result
}

load_data <- function(dataset) {
  # data
  x <- read.table(file.path(data_path,dataset,sub('xxxx',dataset,'X_xxxx.txt')),col.names = features[,2])
  # activity
  y <- read.table(file.path(data_path,dataset,sub('xxxx',dataset,'y_xxxx.txt')))
  # subject 
  s <- read.table(file.path(data_path,dataset,sub('xxxx',dataset,'subject_xxxx.txt')))
  
  prepare_data_set(x,y,s)
}

load_and_prepare <- function() {
  d <- rbind(load_data('test'),load_data('train'))
  d %>% 
    group_by(subject,activity) %>%
    summarize(mean(tBodyAcc.mean...X),
              mean(tBodyAcc.mean...Y),
              mean(tBodyAcc.mean...Z),
              mean(tBodyAcc.std...X),
              mean(tBodyAcc.std...Y),
              mean(tBodyAcc.std...Z))
}

result <- load_and_prepare()

write.table(result,file='output.txt',row.names=FALSE)
