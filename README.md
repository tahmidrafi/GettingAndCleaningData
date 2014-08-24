Getting and Cleaning Data
=========================

This repository is created as a assignment to the Data Science specialization courses. It is from the course Getting and Cleaning Data. the package contains a *R Script* to perform necessary operations on the data, a README file to describe the operations & a CODEBOOK file to define the variables in the data.

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
|X_train.txt          |Contains training data set for all features|7352:| 561:|
|X_test.txt           |Contains training data set for all features|2947:| 561:|
|y_train.txt          |Contains activity id for all training set  |7352:|   1:|
|y_test.txt           |Contains activity id for all test set      |2947:|   1:|
|subject_train.txt    |Contains subject id for all training set   |7352:|   1:|
|subject_test.txt     |Contains subject id for all test set       |2947:|   1:|
|activity_labels.txt  |contains activity id along with name text  |   6:|   2:|
|features.txt         |Contains list of all features              | 561:|   2:|
|required_features.txt|Contains short list of features with only mean() & std() values|79:|2:|

