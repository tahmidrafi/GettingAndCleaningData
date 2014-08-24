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
  |  activity_labels.txt
  |  features.txt
  |  features_info.txt
  |  README.txt
  |  required_features.txt
```
