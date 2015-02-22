# GCDProject
The project for the Getting &amp; Cleansing Data module of Data Science

# Processing
Data is read in, firstly from the original test data sets, and correctly labelled with numeric activities and subjects. In this manner data integrity is preserved. Similarly, data is read in from the train data sets. The two fully added-to data sets are then joined to form a merged data set.

In the merged data set, the activities are noted in text (factor) form. The columns to be kept are then defined, and the other columns are discarded. This annotated and reduced dataset is now written as Total.txt, and includes a header line.

#Data dictionary
There are 81 column names in the reduced data set. This includes a testId, in text form (see activity_labels.txt) and a subjectID, which is numeric (to preserve anonymity of the participants). The other column headings are described in features_info.txt.
