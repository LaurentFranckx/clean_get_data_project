clean\_get\_data\_project
======================


##Study design

###Summary of raw data

We have used data that were collected by Anguita et al. (2012) - see 
[http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) 

These data can be downloaded directely from
[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip ](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip )

In the remainder of this section, we describe the *original* data and the operations performed on them by Anguita et al. (2012).

As explained by Anguita et al. (2012), their data have been collected in experiments with a group of 30 volunteers (the '**subjects**') within an age bracket of 19-48 years. Each person performed six '**activities**' (WALKING, WALKING\_UPSTAIRS, WALKING\_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, Anguita et al. captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the **training** data and 30% the **test** data. 

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These **time domain signals** (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Anguita et al. filtered them using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into **body** and **gravity acceleration signals** (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain **Jerk signals** (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the **magnitude** of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate **frequency domain signals**). 

Anguita et al. have used these signals to estimate variables of the feature vector for each pattern:  '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

- tBodyAcc-XYZ
- tGravityAcc-XYZ
- tBodyAccJerk-XYZ
- tBodyGyro-XYZ
- tBodyGyroJerk-XYZ
- tBodyAccMag
- tGravityAccMag
- tBodyAccJerkMag
- tBodyGyroMag
- tBodyGyroJerkMag
- fBodyAcc-XYZ
- fBodyAccJerk-XYZ
- fBodyGyro-XYZ
- fBodyAccMag
- fBodyAccJerkMag
- fBodyGyroMag
- fBodyGyroJerkMag

The set of variables that Anguita et al. estimated from these signals are: 

- mean():  	Mean value
- std():	Standard deviation
- mad():	Median absolute deviation 
- max():	Largest value in array
- min():	Smallest value in array
- sma():	Signal magnitude area
- energy():	Energy measure. Sum of the squares divided by the number of values.
- iqr():	Interquartile range
- entropy():	Signal entropy
- arCoeff():	Autorregresion coefficients with Burg order equal to 4
- correlation():	correlation coefficient between two signals
- maxInds(): index of the frequency component with largest magnitude
- meanFreq():	Weighted average of the frequency components to obtain a mean frequency
- skewness():	skewness of the frequency domain signal 
- kurtosis():	kurtosis of the frequency domain signal 
- bandsEnergy()	Energy of a frequency interval within the 64 bins of the FFT of each window.
- angle(): Angle between to vectors

Anguita et al. have obtained additional vectors by averaging the signals in a signal window sample. These were used on the angle() variable:

- gravityMean
- tBodyAccMean
- tBodyAccJerkMean
- tBodyGyroMean
- tBodyGyroJerkMean


###Performed transformations

From these raw data, we have selected all the variables expressing the means (mean()) and the standard deviations (std()) of each feature.  For each subject-activity pair, we have then calculated the average value of these means and standard deviations for each feature.

The R script performs the following tasks:

* Loads the original tables with the list of features and the denominations of the activity levels.
* Loads (both for the training and the test set) the tables containing respectively (for each observation) the *subject*, the *activity* and the reported *features*.
* Combines (both for the training and the test set) these three tables into one table (the *test* and the *training* table) that gives, for each observation, the *subject*, the *activity* and the reported *features*.
* Combines  the *training* and the *test* table in one single table representing all the observations (the *global* table).
* Selects, within this *global* table, all the features expressing means and standard deviations.
* "Cleans" the names of the selected features according to the naming conventions described below.
* For each *subject-activity* pair, calculates the average value (accross the observations) of the selected features. These average values are contained in the *summary* table.
* Adds the names of the *activities* to the  *summary* table, and writes the *summary* table to the disk. 

##Codebook

###Naming conventions

The names of the selected features follow "camel case" - see [http://en.wikipedia.org/wiki/CamelCase](http://en.wikipedia.org/wiki/CamelCase). 
Starting from the original names, the script has achieved this by:

* Eliminating all hyphens and parentheses from the names of the selected features.
* Expanding the names of the selected features where it improves readability or if they do not comply with CamelCase notation ("std" to "StanDev", "mean" to "Mean"  and "acc" to  "Accel").

### List of variables and description

In what follows:

* “**average value**” is short-hand for “average value for each subject-activity” pair. 
* “**gravity acceleration signal**” refers to the acceleration signal from the smartphone accelerometer in standard gravity units 'g' (m/s2).
* “**body acceleration signal**” refers to the signal obtained by subtracting the gravity from the total acceleration(m/s2).
* “ **angular velocity**” is measured by the gyroscope for each window sample and is expressed in radians/second.
* "**variable\_nameXYZ**" is short hand notation for "**variable\_nameX**, **variable\_nameY** and **variable\_nameZ**"

The table "average\_activity\_subject.txt" contains the following variables: 

* **label**: The original label of each activity; there are 6 activity labels
* **activityname**: The name of each activity: : WALKING, WALKING\_UPSTAIRS, WALKING\_DOWNSTAIRS, SITTING, STANDING, LAYING.
* **subject**: The code corresponding to each subject. There are 30 subjects, identified by numbers ranging from 1 to 30.
* **tBodyAccStanDevXYZ**:           	The average value of the standard deviation of the time domain body acceleration signal (X, Y and Z coordinates, respectively)
* **tGravityAccStanDevXYZ**: The average value of the standard deviation of the time domain gravity acceleration signal (X, Y and Z coordinates, respectively)
* **tBodyAccJerkStanDevXYZ**:      	The average value of the standard deviation of the time domain body linear acceleration jerk signal (X, Y and Z coordinates, respectively)
* **tBodyGyroStanDevXYZ**: The average value of the standard deviation of the time domain body angular velocity signal (X, Y and Z coordinates, respectively)
* **tBodyGyroJerkStanDevXYZ**: The average value of the standard deviation of the time domain body angular velocity jerk signal (X, Y and Z coordinates, respectively)
* **tBodyAccMagStanDev**: The average value of the standard deviation of the magnitude of the time domain body acceleration signal
* **tGravityAccMagStanDev**:     	The average value of the standard deviation of the magnitude of the time domain gravity acceleration signal
* **tBodyAccJerkMagStanDev**:     	The average value of the standard deviation of the magnitude of the time domain body linear acceleration jerk signal
* **tBodyGyroMagStanDev**:       	The average value of the standard deviation of the magnitude of the time domain body angular velocity signal 
* **tBodyGyroJerkMagStanDev**:   	The average value of the standard deviation of the magnitude of the time domain body angular velocity jerk signal
* **fBodyAccStanDevXYZ**: The average value of the standard deviation of the frequency domain body acceleration signal (X, Y and Z coordinates, respectively)
* **fBodyAccJerkStanDevXYZ**: The average value of the standard deviation of the frequency domain body linear acceleration jerk signal (X, Y and Z coordinates, respectively)
* **fBodyGyroStanDevXYZ**:	The average value of the standard deviation of the frequency domain body angular velocity signal (X, Y and Z coordinates, respectively)
* **fBodyAccMagStanDev**: The average value of the standard deviation of magnitude of the frequency domain body acceleration signal
* **fBodyBodyAccJerkMagStanDev**:	The average value of the standard deviation of the magnitude of the frequency domain body linear acceleration jerk signal
* **fBodyBodyGyroMagStanDev**: The average value of the standard deviation of the magnitude of the frequency domain body angular velocity signal
* **fBodyBodyGyroJerkMagStanDev**: The average value of the standard deviation of the magnitude of the frequency domain body angular velocity jerk signal
* **tBodyAccMeanXYZ**: 	The average value of the mean of the time domain body acceleration signal (X, Y and Z coordinates, respectively)
* **tGravityAccMeanXYZ**:           	The average value of the mean of the time domain gravity acceleration signal (X, Y and Z coordinates, respectively)
* **tBodyAccJerkMeanXYZ**: 	The average value of the mean of the time domain body linear acceleration jerk signal (X, Y and Z coordinates, respectively)
* **tBodyGyroMeanXYZ**:           	The average value of the mean of the time domain body angular velocity signal (X, Y and Z coordinates, respectively)
* **tBodyGyroJerkMeanXYZ**:          	The average value of the mean of the time domain body angular velocity jerk signal (X, Y and Z coordinates, respectively)
* **tBodyAccMagMean**:            	The average value of the mean of the magnitude of the time domain body acceleration signal
* **tGravityAccMagMean**:The average value of the mean of the magnitude of the time domain gravity acceleration signal
* **tBodyAccJerkMagMean**:The average value of the mean of the magnitude of the time domain body linear acceleration jerk signal
* **tBodyGyroMagMean**: The average value of the magnitude of the mean of the time domain body angular velocity signal
* **tBodyGyroJerkMagMean**: The average value of the mean of the magnitude of the time domain body angular velocity jerk signal
* **fBodyAccMeanXYZ**:               	The average value of the mean of the frequency domain body acceleration signal (X, Y and Z coordinates, respectively)
* **fBodyAccJerkMeanXYZ**: The average value of the mean of the frequency domain body linear acceleration jerk signal (X, Y and Z coordinates, respectively)
* **fBodyGyroMeanXYZ**:              	The average value of the mean of the frequency domain body angular velocity signal (X, Y and Z coordinates, respectively)
* **fBodyAccMagMean**: The average value of the mean of the magnitude of the frequency domain body acceleration signal
* **fBodyBodyAccJerkMagMean**: The average value of the mean of the magnitude of the frequency domain body linear acceleration jerk signal
* **fBodyBodyGyroMagMean**: The average value of the mean of the magnitude of the frequency domain body angular velocity signal
* **fBodyBodyGyroJerkMagMean**: The average value of the mean of the magnitude of the frequency domain body angular velocity jerk signal



