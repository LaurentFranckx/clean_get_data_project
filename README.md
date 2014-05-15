clean\_get\_data\_project
======================

# Introduction

The raw data were collected by Anguita et al. (2012) and are freely available at:

[http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
 
Anguita et al. (2012) have collected their data in experiments with a group of 30 volunteers (the *subjects*) within an age bracket of 19-48 years. Each person performed six *activities* (WALKING, WALKING\_UPSTAIRS, WALKING\_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, Anguita et al. captured 3-axial linear acceleration and 3-axial angular velocity. 

The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The measured signals were then subjected to additional filtering and transformations. In total, 561 features were reported per observation.  

A detailed description of the study design and of the features that were reported can be found in the Word document code\_book (avaialable in this repository). 

From this initial set of features, we have selected all the variables expressing the means (mean()) and the standard deviations (std()) of each variable.  For each *subject-activity* pair, we have then calculated the average value (accross the observations) of these means and standard deviations for each feature.

#Instruction list



* Start from a folder containg the folder ./data/UCI HAR Dataset where UCI HAR Dataset contains the unzipped raw data obtained from [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip ](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip ), maintaining the original folder structure. 
* Run run\_analysis.R 
* The outputfile is average\_activity\_subject.R. 

We have written *run\_analysis.R*  with *R version 3.1.0* and we have run the script on a *x86\_64-w64-mingw32/x64 (64-bit)* platform. 

#Summary of the R script content

The R script performs the following tasks:

* Loads the original tables with the list of features and the denominations of the activity levels.
* Loads (both for the training and the test set) the tables containing respectively (for each observation) the *subject*, the *activity* and the reported *features*, and then joins these three tables.
* Joins the tables for the training and the test set.
* Selects, within this new table, all the features expressing means and standard deviations.
* "Cleans" the names of the selected features according to the naming conventions described below.
* For each *subject-activity* pair, calculates the average value (accross the observations) of the selected features.
* Adds the names of the *activities* to the resulting table, and writes this table to the disk. 

#Naming conventions

The names of the selected features follow "camel case" - see [http://en.wikipedia.org/wiki/CamelCase](http://en.wikipedia.org/wiki/CamelCase). 
Starting from the original names, the script has achieved this by:

* Eliminating all hyphens and parentheses from the names of the selected features.
* Expanding the names of the selected features where it improves readability or if they do not comply with CamelCase notation ("std" to "StanDev"  , "mean" to "Mean"  , "t" to "TimeSign" "f" to "FreqDom"  , and "acc" to  "Accel").

#Codebook

* The codebook containing the detailed description of all variables can be found in the Word document code\_book. 