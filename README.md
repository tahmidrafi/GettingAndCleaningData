Getting and Cleaning Data
=========================

This repository is created as a assignment to the Data Science specialization courses. It is from the course Getting and Cleaning Data. the package contains a **R Script** to perform necessary operations on the data, a `README` file to describe the operations & a `CODEBOOK` file to define the variables in the data.

The task of the assignment is to read a data from file, extract some specific data, label the data and finally generate some computed data. This `README` file describes:
- The initial data format
- The tasks
- The operations performed for each task
- The final output form

Initial Data Format
-------------------
The script takes input a single parameter containing path to the data directory. It assumes that the data is stored in this directory hierarchy.
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
| File Name           | Description                                    |# of Rows |# of Columns|
|:--------------------|:----------------------------------------------:|---------:|-----------:|
|X_train.txt          |Contains training data set for all features     |      7352|         561|
|X_test.txt           |Contains training data set for all features     |      2947|         561|
|y_train.txt          |Contains activity id for all training set       |      7352|           1|
|y_test.txt           |Contains activity id for all test set           |      2947|           1|
|subject_train.txt    |Contains subject id for all training set        |      7352|           1|
|subject_test.txt     |Contains subject id for all test set            |      2947|           1|
|activity_labels.txt  |contains activity id along with name text       |         6|           2|
|features.txt         |Contains list of all features                   |       561|           2|
|required_features.txt|Contains short list of features with only `mean()` & `std()` values|79|2|


Tasks
-----
+ Step 1: Load training data & test data and merge them
+ Step 2: Extract only those columns which contains measurement on the `mean()` or `std()` for each measurement
+ Step 3: Use *activity* name text instead of id
+ Step 4: Label the data set with appropriate name for each variable
+ Step 5: Create a Second data set with `mean()` for each *variable* for each *activity* for each *subject*

Operations
----------

### Step 1
Loading and merging data.

`function get_merged_data(file)`
***
* Parameters:
  * file = Location to the path of data source directory
* Tasks:
  * Loads data from *X_train.txt*
  * Loads data from *X_text.txt*
  * Merges data by `rbind()`
* Output:
  * Merged data-frame with dimension `10299x561` ( 10299 rows and 561 columns )

### Step 2

Extract Specific columns.

We only need those columns which contains `mean()` or `std()` of all other measurements. These columns are *hand-picked* and stored in a new file called *required_features.txt*. I have selected 79 columns to be extracted. *The required_features.txt* file is also uploaded for convenience.

`function extract_columns(file, data)`
***
* Parameters:
  * file = Location to the path of data source directory
  * data = Reference to merged data-frame object
* Tasks:
  * Loads required features list from *required_features.txt* file
  * Extracts only those columns specified in the file
* Output:
  * Data-frame with only required columns in it, dimension = `10299x79` ( 10299 rows, 79 columns)

### Step 3

Load *activity* and *subject*

From *y_train.txt* and *y_test.txt* *activities* were loaded. They were merged and attached to the main data set. similarly from *subject_test.txt* and *subject_train.txt* *subject* data were loaded. They were also merged and attached to the main data set.

`function merge_subject_activity(file, data)`
***
* Parameters:
  * file = Location to the path of data source directory
  * data = Reference to extracted data-frame object
* Tasks:
  * Loads *activities* from *y_train.txt* and *y_test.txt*
  * Loads *subject* from *subject_train.txt* and *subject_test.txt*
  * *y_train* and *y_test* are merged by `rbind()`
  * *subject_train* and *subject_test* are merged by `rbind())`
  * *activity* and *subject* are attached with the extracted data by `cbind()`
* Output:
  * Data-frame with activity and subject columns in it, dimension = `10299x81` ( 10299 rows, 81 columns)

### Step 4

Labelling the data

From *activity_labels.txt* the *activities* names were loaded. From *required_features.txt* selecterd feature names were loaded. Each *variable* were assigned a name loaded from the *required_features.txt*. After that activities were converted to *factor* variables and labelled with activity name texts.

`function label_data(file, data)`
***
* Parameters:
  * file = Location to the path of data source directory
  * data = Reference to modified data-frame object
* Tasks:
  * Loads selected feature names from *required_features.txt* file
  * Set feature names to the *variables* using `colnames()` method
  * Loads activity name texts from *activity_labels.txt*
  * Converts *activity* to factor variable and assigned appropriate labels with `factor()`
  * *subject* column were also converted to *factor* variable
* Output:
  * data-frame with proper labelling, dimension = `10299x81` ( 10299 rows, 81 columns)

### Step 5

Finding the means

Current data set has dimension 10299x81. The first two columns are factor variables of *activity* and *subject*. There are 30 subjects and 6 activities. Data set was split into a list of 180 individual sets using `split()`. then `mean()` function was applied to each column of each element of the list to calculate means of each *variable* for each *subject* for each *activity*.

`function find_mean(file, data)`
***
* Parameters:
  * file = Location to the path of data source directory
  * data = Reference to extracted data-frame object
* Tasks:
  * Splits data-frame into a list of 180 elements where each element contains the subset of the total data of a particular activity of a particular subject
  * Calculates average of each columns on each elements of the list using `sapply()` on `colMeans()`
* Output:
  * Data-frame with desired output, dimension = `79X180` ( 79 rows, 180 columns)

Final Output
------------

Final output is a single matrix of `dim()` `79 x 180`. Here are some summary of the data.
```
# str(final_tidy_data)
## num [1:79, 1:180] 0.2773 -0.0174 -0.1111 -0.2837 0.1145 ...
##  - attr(*, "dimnames")=List of 2
##  ..$ : chr [1:79] "tBodyAcc-mean()-X" "tBodyAcc-mean()-Y" "tBodyAcc-mean()-Z" "tBodyAcc-std()-X" ...
##  ..$ : chr [1:180] "WALKING.1" "WALKING_UPSTAIRS.1" "WALKING_DOWNSTAIRS.1" "SITTING.1" ...
```