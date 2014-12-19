getdata-016 Course Project repository
=====================================

This repository contains the R script and results of analysis for the 'Getting and Cleaning data' course project. It is organized as follows:

* README.md : this file
* run_analysis.R : R script that load and transform data from the [Human Activity Recognition Using Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) into tidy data set.

## run_analysis.R instructions

### clone the repository 

Clone the github repository at (https://github.com/earzur/getdata-016-project.git)

````#!shell
|ruby-1.9.3-p547| moody2-2 in ~/dev/perso
○ → git clone https://github.com/earzur/getdata-016-project.git getdata-016
Cloning into 'getdata-016'...
remote: Counting objects: 7, done.
remote: Compressing objects: 100% (5/5), done.
remote: Total 7 (delta 0), reused 4 (delta 0)
Unpacking objects: 100% (7/7), done.
Checking connectivity... done.
```
### change working directory

```#!shell
|ruby-1.9.3-p547| moody2-2 in ~/dev/perso
○ → cd getdata-016/

|ruby-1.9.3-p547| moody2-2 in ~/dev/perso/getdata-016
± |master ✓| →
````

### download and extract test/training data

download and extract the dataset provided for the course project

```#!shell
|ruby-1.9.3-p547| moody2-2 in ~/dev/perso/getdata-016
± |master ✓| → curl -O https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 59.6M  100 59.6M    0     0  1994k      0  0:00:30  0:00:30 --:--:-- 2123k

|ruby-1.9.3-p547| moody2-2 in ~/dev/perso/getdata-016
± |master ✗| → ls
README.md                                        run_analysis.R
getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

|ruby-1.9.3-p547| moody2-2 in ~/dev/perso/getdata-016
± |master ✗| → unzip getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
Archive:  getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
  inflating: UCI HAR Dataset/activity_labels.txt
  inflating: UCI HAR Dataset/features.txt
  inflating: UCI HAR Dataset/features_info.txt
  inflating: UCI HAR Dataset/README.txt
   creating: UCI HAR Dataset/test/
   creating: UCI HAR Dataset/test/Inertial Signals/
  inflating: UCI HAR Dataset/test/Inertial Signals/body_acc_x_test.txt
  inflating: UCI HAR Dataset/test/Inertial Signals/body_acc_y_test.txt
  inflating: UCI HAR Dataset/test/Inertial Signals/body_acc_z_test.txt
  inflating: UCI HAR Dataset/test/Inertial Signals/body_gyro_x_test.txt
  inflating: UCI HAR Dataset/test/Inertial Signals/body_gyro_y_test.txt
  inflating: UCI HAR Dataset/test/Inertial Signals/body_gyro_z_test.txt
  inflating: UCI HAR Dataset/test/Inertial Signals/total_acc_x_test.txt
  inflating: UCI HAR Dataset/test/Inertial Signals/total_acc_y_test.txt
  inflating: UCI HAR Dataset/test/Inertial Signals/total_acc_z_test.txt
  inflating: UCI HAR Dataset/test/subject_test.txt
  inflating: UCI HAR Dataset/test/X_test.txt
  inflating: UCI HAR Dataset/test/y_test.txt
   creating: UCI HAR Dataset/train/
   creating: UCI HAR Dataset/train/Inertial Signals/
  inflating: UCI HAR Dataset/train/Inertial Signals/body_acc_x_train.txt
  inflating: UCI HAR Dataset/train/Inertial Signals/body_acc_y_train.txt
  inflating: UCI HAR Dataset/train/Inertial Signals/body_acc_z_train.txt
  inflating: UCI HAR Dataset/train/Inertial Signals/body_gyro_x_train.txt
  inflating: UCI HAR Dataset/train/Inertial Signals/body_gyro_y_train.txt
  inflating: UCI HAR Dataset/train/Inertial Signals/body_gyro_z_train.txt
  inflating: UCI HAR Dataset/train/Inertial Signals/total_acc_x_train.txt
  inflating: UCI HAR Dataset/train/Inertial Signals/total_acc_y_train.txt
  inflating: UCI HAR Dataset/train/Inertial Signals/total_acc_z_train.txt
  inflating: UCI HAR Dataset/train/subject_train.txt
  inflating: UCI HAR Dataset/train/X_train.txt
  inflating: UCI HAR Dataset/train/y_train.txt

|ruby-1.9.3-p547| moody2-2 in ~/dev/perso/getdata-016
± |master ✗| →
```

### running `run_analysis.R`

The script loads data from the `UCI HAR Dataset's` `test/` and `train/` sub-directories.
It expects to find the following data files inside `UCI HAR Dataset` (`<dataset>` is one of `test` or `train`, depending on the respective dataset directories):

* `features.txt`: list of the variable names in the accelerometer data set (used to label columns in the resulting file)
* `activity_labels.txt`: labels(factors) for the activity information
* `<dataset>/X_<dataset>.txt`: accelerometer data set
* `<dataset>/y_<dataset>.txt`: activity information
* `<dataset>/subject_<dataset>.txt`: test subject information

Once the data has been loaded, the scripts aggregates the 2 datasets, picking only relevant data for the measures whose names contain 'mean()' and 'std()'.

It then replaces activity numbers in column 2 to factors as described in `activity_labels.txt`.

And finally computes mean values by (`subject`,`activity`) groups for each of the data column.

The result is then saved into `output.txt` in the current working directory, using the `write.table` function.

#### sample script output

```
|ruby-1.9.3-p547| moody2-2 in ~/dev/perso/getdata-016
± |master ✗| → Rscript run_analysis.R

Reading accelerometer data from UCI HAR Dataset/test/X_test.txt
Reading activity data from UCI HAR Dataset/test/y_test.txt
Reading subject data from UCI HAR Dataset/test/subject_test.txt
Reading accelerometer data from UCI HAR Dataset/train/X_train.txt
Reading activity data from UCI HAR Dataset/train/y_train.txt
Reading subject data from UCI HAR Dataset/train/subject_train.txt
Writing results to output.txt


```

### Note about changing default data location 

The script expects the test/training data to be in the current working directory. If you extracted the data in another location, you need to change the value of the `data_path` variable at the top of the script and make it point to the actual location (full path) of the test data



