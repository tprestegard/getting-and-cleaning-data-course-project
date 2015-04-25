# Code Book for Getting and Cleaning Data course project
--------------------------------------------------------------------------------

################################################################################
This tidy dataset was created from the Human Activity Recognition Using
Smartphones Dataset Version 1.0, originally published in
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge
L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a
Multiclass Hardware-Friendly Support Vector Machine. International
Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz,
Spain. Dec 2012.
################################################################################

################################################################################
### EXPERIMENTAL DESCRIPTION
The experiments have been carried out with a group of 30 volunteers
within an age bracket of 19-48 years. Each person performed six activities
(WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)
wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded
accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial
angular velocity at a constant rate of 50Hz. The experiments have been
video-recorded to label the data manually. The obtained dataset has been randomly
partitioned into two sets, where 70% of the volunteers was selected for generating
the training data and 30% the test data. 
################################################################################

################################################################################
### RAW DATA
The raw data included 561 different measurements, subject ID, activity ID, and
activity description.  There were two datasets - one marked "training" and one
marked "test."  A description of the raw data measurements follow:

tBodyAcc-XYZ

tGravityAcc-XYZ

tBodyAccJerk-XYZ

tBodyGyro-XYZ

tBodyGyroJerk-XYZ

tBodyAccMag

tGravityAccMag

tBodyAccJerkMag

tBodyGyroMag

tBodyGyroJerkMag

fBodyAcc-XYZ

fBodyAccJerk-XYZ

fBodyGyro-XYZ

fBodyAccMag

fBodyAccJerkMag

fBodyGyroMag

fBodyGyroJerkMag

The variable list is too extension to describe each individually so we will
describe each component of the variable names.
The prefix "t" indicates time domain and "f" indicates frequency domain.
The full acceleration signal can be separated into "Body" and "Gravity" components.
"Acc" indicates data from the accelerometer and "Gyro" indicates data from the gyroscope.
"Jerk" indicates a jerk measurement (3rd time derivative of displacement).
The signals may be divided up into their X,Y,Z components, or the full magnitude
of the measurement may be given (marked by "Mag" in the variable name).

For each of these signals, the following properties were estimated:
mean(): mean value

std(): standard deviation

mad(): median absolute deviation

max(): largest value in array

min(): smallest value in array

sma(): signal magnitude area

energy(): energy measure. Sum of the squares divided by the number of values. 

iqr(): interquartile range 

entropy(): signal entropy

arCoeff(): autorregresion coefficients with Burg order equal to 4

correlation(): correlation coefficient between two signals

maxInds(): index of the frequency component with largest magnitude

meanFreq(): Weighted average of the frequency components to obtain a mean frequency

skewness(): skewness of the frequency domain signal 

kurtosis(): kurtosis of the frequency domain signal 

bandsEnergy(): energy of a frequency interval within the 64 bins of the FFT of each window.

angle(): angle between two vectors.

The combination of signals and properties produces 561 variables in the raw dataset.
################################################################################

################################################################################
### DESCRIPTION OF TIDY DATASET
The tidy dataset contains 68 variables in total - the first two are the subject
ID and the activity, and the other 66 are the averages of mean and standard
deviation measurements from the raw dataset.
The tidy data have been averaged over subject and activity; since there are 
30 subjects and 6 activities, this results in 180 total observations.
Thus, the tidy dataset has dimensions of 180 x 68.
A more complete description of the variables in the tidy dataset can be
found below in the "TIDY DATA VARIABLE DESCRIPTION" section.
################################################################################

################################################################################
### CREATING THE TIDY DATA FILE
1. Download the data from
   https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
2. Run the cleaning script "run_analysis.R".

################################################################################

################################################################################
### HOW TO LOAD THE TIDY DATASET
```
read.table("tidy_data.txt", header=TRUE, sep=" ")
```
################################################################################

################################################################################
### DESCRIPTION OF DATA CLEANING CODE (run_analysis.R)
1. Load activity labels and description from "activity_labels.txt" in the raw
   dataset.  This matches an ID number to an activity description.
2. Load variable names from "features.txt" in the raw dataset.
3. Load data files for the training and test datasets ("train/X_train.txt" and
	"test/X_test.txt") and assign to data tables.
4. Load the activity IDs for each observation in the training and test
	datasets ("train/y_train.txt" and "test/y_test.txt").
5. Load the subject IDs for each observation in the training and test datasets
	("train/subject_train.txt" and "test/subject_test.txt").
6. Assign column names to each data table using the variable names from step 2.
7. Pick out only variables that are mean or standard deviation measurements.
8. Add the activity IDs from step 4 to a new variable in each data table.
9. Add the subject IDs from step 5 to a new variable in each data table.
10. Bind the training and test data tables into one data table.
11. Use a left_join to add activity descriptions to the data table
    based on the activity IDs.
12. Remove activity IDs since they are not useful.
13. Group observations by subject ID and activity.
14. Calculate the mean of each measurement in each group.
15. Clean up variable names using the following format:
	- Replace "t" and "f" prefixes with "time" and "freq", respectively.
	- Replace erroneous occurrences of "BodyBody" with "Body".
	- Replace "-" by "_".
	- Replace "Acc" by "Accel".
	- Remove occurrences of "()".
	
	These steps were taken to improve variable readability and remove
	problematic variable name formatting.
16. Save the new tidy data in a space-separated text file.


################################################################################

################################################################################
### TIDY DATA VARIABLE DESCRIPTIONS
subject_id - ID number of the subject performing the trial.  Has 30 unique values
		     (integers between 1 and 30).
activity   - description of the activity being performed by the subject.  Has 6
             unique values (LAYING, SITTING, STANDING, WALKING,
			 WALKING_DOWNSTAIRS, WALKING_UPSTAIRS).

The other 66 variables are given below.  The names have been modified from those
given in the raw dataset but not significantly.  Their variable descriptions
can be determined from their names and the following descriptions of the name components.

The prefix "time" indicates time domain and "freq" indicates frequency domain.
The full acceleration signal can be separated into "Body" and "Gravity" components.
"Accel" indicates data from the accelerometer and "Gyro" indicates data from the gyroscope.
"Jerk" indicates a jerk measurement (3rd time derivative of displacement).
The signals may be divided up into their X,Y,Z components, or the full magnitude
of the measurement may be given (marked by "Mag" in the variable name).

Other 66 variable names:

timeBodyAccel_mean_X

timeBodyAccel_mean_Y

timeBodyAccel_mean_Z

timeBodyAccel_std_X

timeBodyAccel_std_Y

timeBodyAccel_std_Z

timeGravityAccel_mean_X

timeGravityAccel_mean_Y

timeGravityAccel_mean_Z

timeGravityAccel_std_X

timeGravityAccel_std_Y

timeGravityAccel_std_Z

timeBodyAccelJerk_mean_X

timeBodyAccelJerk_mean_Y

timeBodyAccelJerk_mean_Z

timeBodyAccelJerk_std_X

timeBodyAccelJerk_std_Y

timeBodyAccelJerk_std_Z

timeBodyGyro_mean_X

timeBodyGyro_mean_Y

timeBodyGyro_mean_Z

timeBodyGyro_std_X

timeBodyGyro_std_Y

timeBodyGyro_std_Z

timeBodyGyroJerk_mean_X

timeBodyGyroJerk_mean_Y

timeBodyGyroJerk_mean_Z

timeBodyGyroJerk_std_X

timeBodyGyroJerk_std_Y

timeBodyGyroJerk_std_Z

timeBodyAccelMag_mean

timeBodyAccelMag_std

timeGravityAccelMag_mean

timeGravityAccelMag_std

timeBodyAccelJerkMag_mean

timeBodyAccelJerkMag_std

timeBodyGyroMag_mean

timeBodyGyroMag_std

timeBodyGyroJerkMag_mean

timeBodyGyroJerkMag_std

freqBodyAccel_mean_X

freqBodyAccel_mean_Y

freqBodyAccel_mean_Z

freqBodyAccel_std_X

freqBodyAccel_std_Y

freqBodyAccel_std_Z

freqBodyAccelJerk_mean_X

freqBodyAccelJerk_mean_Y

freqBodyAccelJerk_mean_Z

freqBodyAccelJerk_std_X

freqBodyAccelJerk_std_Y

freqBodyAccelJerk_std_Z

freqBodyGyro_mean_X

freqBodyGyro_mean_Y

freqBodyGyro_mean_Z

freqBodyGyro_std_X

freqBodyGyro_std_Y

freqBodyGyro_std_Z

freqBodyAccelMag_mean

freqBodyAccelMag_std

freqBodyAccelJerkMag_mean

freqBodyAccelJerkMag_std

freqBodyGyroMag_mean

freqBodyGyroMag_std

freqBodyGyroJerkMag_mean

freqBodyGyroJerkMag_std

################################################################################
