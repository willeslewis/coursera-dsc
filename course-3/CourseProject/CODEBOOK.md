Variables:

-subjectid: This is an integer which identifies one of the 30 subjects involved in the original UCI HAR Dataset study.

	*Integer: 1-30 

-activity: A character describing one of six activities the subjects participated in.

	*Character: “laying”, “standing”, “sitting”, “walking”, “walking_downstairs”
	            “walking_upstairs”

-Remaining variables are numeric and are means of features in the original dataset
grouped by subjectid and activity.

	*Numeric (double): [-1,1] units are normalized such that features in the original
	 dataset are normalized to [-1,1].

	*Names of variables whose means are taken are preserved from the original UCI HAR 
	 Dataset. 
         Please see ‘./UCI HAR Dataset/README.txt’ and ‘./UCI HAR Dataset/features_info.txt’ for details on their meaning. 

