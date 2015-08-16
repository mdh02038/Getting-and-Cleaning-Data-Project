# Getting-and-Cleaning-Data-Project
Project for coursera class of same name.

## Script instructions
1) download and unzip the data file from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  
2) Run the script: run_analysis.R  
3) The file data2.txt will be created. See CodeBook.mid for file details.  

## Data set processing
1) The data file was loaded using the given variable names into a testing and training data frame.  
2) The testing and training data frames where them merged into one data table keeping any columns with a label that contained the character sequences "mean", "std" or "Mean".  
3) The activity labels were converted to their ascii equivilents.  
4) The columns where then summerize by using the mean function for each combination of "subject" and "label"  

