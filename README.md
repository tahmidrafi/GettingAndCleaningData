Getting and Cleaning Data
=========================

This repository is created as a assignment to the Data Science specialization courses. It is from the course Getting and Cleaning Data. the package contains a **R Script** to perform necessary operations on the data, a README file to describe the operations & a CODEBOOK file to define the variables in the data.

The task of the assignment is to read a data from file, extract some specific data, label the data and finally generate some computed data. This README file describes:
- The Initial Data format
- The Tasks
- The operations performed for each task
- The final Output Form

Initial Data Format
-------------------
The Script takes input a single parameter containing path to the data directory. It assumes that the data is stored in this directory hierarchy.
```
data/
  +-- test/
  |  +-- Inertial Signals/
  |  |  |  body_acc_x_test.txt
  |  |  |  body_acc_y_test.txt
  |  |  |  body_acc_z_test.txt
  |  |  |  body_gyro_x_test.txt
  |  |  |  body_gyro_y_test.txt
  |  |  |  body_gyro_z_test.txt
  |  |  |  total_acc_x_test.txt
  |  |  |  total_acc_y_test.txt
  |  |  |  total_acc_z_test.txt
  |  |  subject_test.txt
  |  |  X_test.txt
  |  |  y_test.txt
  +-- train/
  |  +-- Inertial Signals/
  |  |  |  body_acc_x_train.txt
  |  |  |  body_acc_y_train.txt
  |  |  |  body_acc_z_train.txt
  |  |  |  body_gyro_x_train.txt
  |  |  |  body_gyro_y_train.txt
  |  |  |  body_gyro_z_train.txt
  |  |  |  total_acc_x_train.txt
  |  |  |  total_acc_y_train.txt
  |  |  |  total_acc_z_train.txt
  |  |  subject_train.txt
  |  |  X_train.txt
  |  |  y_train.txt
  |  activity_labels.txt
  |  features.txt
  |  features_info.txt
  |  README.txt
  |  required_features.txt
```
### Data Dimensions
| File Name           | Description                               |nrows|ncols|
|:--------------------|:-----------------------------------------:|----:|----:|
|X_train.txt          |Contains training data set for all features| 7352|  561|
|X_test.txt           |Contains training data set for all features| 2947|  561|
|y_train.txt          |Contains activity id for all training set  | 7352|    1|
|y_test.txt           |Contains activity id for all test set      | 2947|    1|
|subject_train.txt    |Contains subject id for all training set   | 7352|    1|
|subject_test.txt     |Contains subject id for all test set       | 2947|    1|
|activity_labels.txt  |contains activity id along with name text  |    6|    2|
|features.txt         |Contains list of all features              |  561|    2|
|required_features.txt|Contains short list of features with only mean() & std() values|79|2|


Tasks
-----
+ Step 1: Load training data & test data and merge them
+ Step 2: Extract only those columns which contains measurement on the mean() od std() for each measurement
+ Step 3: Use **Activity** name text instead of id
+ Step 4: Label the data set with appropriate name for each variable
+ Step 5: Create a Second data set with mean() for each variable for each activity for each subject

Operations
----------

### Step 1
Loading and merging data.

*function get_merged_data(file)*
***
* Parameters:
  * file = location to the path of data source directory
* Tasks:
  * loads data from X_train.txt
  * loads data from X_text.txt
  * merges data by rbind
* Output:
  * merged data-frame with dimension 10299x561 ( 10299 rows and 561 columns )

### Step 2

Extract Specific columns.

we only need those columns which contains mean() or std() of all other measurements. These columns are **hand-picked** and stored in a new file called *required_features.txt*. I have selected 79 columns to be extracted. the required_features.txt file is also uploaded for convenience.

*function extract_columns(file, data)*
***
* Parameters:
  * file = location to the path of data source directory
  * data = reference to merged data-frame object
* Tasks:
  * loads required features list from required_features.txt file
  * extracts only those columns specified in the file
* Output:
  * data-frame with only required columns in it, dimension = 10299x79 ( 10299 rows, 79 columns)

### Step 3

Load activity and subject

from y_train.txt and y_test.txt activities were loaded. They were merged and attached to the main data set. similarly from subject_test.txt and subject_train.txt subject data were loaded. They were also merged and attached to the main data set.

*function merge_subject_activity(file, data)*
***
* Parameters:
  * file = location to the path of data source directory
  * data = reference to extracted data-frame object
* Tasks:
  * loads activities from y_train.txt and y_test.txt
  * loads subject from subject_train.txt and subject_test.txt
  * y_train and y_test are merged by **rbind**
  * subject_train and subject_test are merged by **rbind**
  * y and subject are attached with the extracted data by **cbind**
* Output:
  * data-frame with activity and subject columns in it, dimension = 10299x81 ( 10299 rows, 81 columns)



