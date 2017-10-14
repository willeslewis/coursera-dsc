
Summary Analysis of Smartphones Dataset
==================================================================
Analysis script created by: Will Lewis

Original UCI HAR Dataset from: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

### References: [1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
==================================================================
## Important Information:

For ease of use, as well as cross-referencing in the CODEBOOK.md, I have included the original UCI HAR Dataset in a directory of that name. The data and additional contents therein have not been altered by me and are not my work. Please cite Ref. [1] if using any of the content therein. The files ‘CODEBOOK.md’, ‘README.md’, ‘run_analysis.R’, and ‘summary_means_by_subject_and_activity.csv’ have been created by me.


## Script Summary:

For details on the raw data used for this analysis see ./UCI HAR Dataset/README.txt.
The summary analysis performed by ‘run_analysis.R’ performs the following steps:

	1) Merges the training and the test sets to create one data set

	2) Extracts only the measurements on the mean and standard deviation for each 
	   measurement. By this, it is meant, only those columns in the original data 
	   set which are means or standard deviations of the original measurement, 
	   denoted by -mean() or -std() in the variable name. Note that variables
	   whose name contains mean but not in the form -mean() are excluded.

	3) Uses descriptive activity names to name the activities in the data set
	   by converting integer representations of the activity to a descriptive 
	   character through use of factors

	4) Appropriately labels the data set with descriptive variable names. Here 
	   we choose to keep the original feature names, though it is important to 
	   note that I summarize this data by taking means on various groups as 
	   described in 5) below.

	5) From the data set in step 4, I create a second, independent tidy data set
	   ‘summary_means_by_subject_and_activity.csv’ with the mean of each feature
	   variable grouped by subjected and activity.


The summary dataset includes the following files:
=========================================

- 'README.md’

- ‘CODEBOOK.md’: Shows information about the variables used on the feature vector.

- ‘run_analysis.R’: The R script for performing the data summarization

- 'summary_means_by_subject_and_activity.csv’: The summary dataset.

Notes: 
======
- Features from the original data set are normalized and bounded within [-1,1].

- Values in the summary dataset are thus in normalized units

- Each summary record is in a row of the summary dataset

- Please ensure that script variables such as dir are appropriately set so that the 
  required data is accessible to the script.
