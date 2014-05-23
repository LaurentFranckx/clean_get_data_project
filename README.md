clean\_get\_data\_project
======================

# Introduction

The raw data were collected by Anguita et al. (2012) and are freely available at:

[http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
 
Anguita et al. (2012) have collected their data in experiments  with a group of 30 volunteers (the *subjects*). Each person performed six *activities*  wearing a smartphone  on the waist. The  signals measured during these activities were then subjected to additional filtering and transformations. In total, 561 features were reported per observation.  

A detailed description of the original study design and of the features that were reported can be found in  CODE\_BOOK.md (available in this repository). 

From this initial set of features, we have selected all the variables expressing the means (mean()) and the standard deviations (std()) of each variable.  For each *subject-activity* pair, we have then calculated the average value (accross the observations) of these means and standard deviations for each feature.

#Instruction list

* Start from a folder containg the folder ./data/UCI HAR Dataset where UCI HAR Dataset contains the *unzipped* raw data obtained from [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip ](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip ), maintaining the original folder structure. 
* Run run\_analysis.R 
* The outputfile is average\_activity\_subject.txt  

We have written *run\_analysis.R*  with *R version 3.1.0* and we have run the script on a *x86\_64-w64-mingw32/x64 (64-bit)* platform. 

#Codebook

* The codebook containing the detailed description of all variables can be found in CODE\_BOOK.md (available in this repository). 