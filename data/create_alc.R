#Author: KatMal
#Date: 20.11.2021
#this is a script for merging the following dataset: https://archive.ics.uci.edu/ml/datasets/Student+Performance, student.zip
library(dplyr)

mat <- read.table("student-mat.csv", sep = ';', header = TRUE)
por <- read.table("student-por.csv", sep = ';', header = TRUE)

dim(mat) #33 variables and 395 rows
dim(por) #33 variables and 649 rows

str(mat) #there are character and integer variables
str(por) #the variables are the same in both data sets

unwanted_columns = c("failures", "paid", "absences", "G1", "G2", "G3")
join_columns = setdiff(colnames(mat), unwanted_columns)

joint_student = merge(mat,por, by=join_columns, suffix = c(".math", ".por")) #this function seems to do the inner join correctly as there are 370 students afterwards

alc <- select(joint_student, one_of(join_columns)) #selecting the columns for which there is only one

#copied this from datacamp
for(column_name in unwanted_columns) {
  two_columns <- select(joint_student, starts_with(column_name))
  first_column <- select(two_columns, 1)[[1]]
  
  if(is.numeric(first_column)) {
    alc[column_name] <- round(rowMeans(two_columns))
  } else {
    alc[column_name] <- first_column
  }
}

#making the alcohol consumption columns
alc['alc_use'] <- rowMeans(select(alc, c('Dalc', 'Walc')))
alc['high_use'] <- ifelse(alc$alc_use>2, TRUE, FALSE) #one line function for making if else statement

glimpse(alc) #370 students

write.table(alc, file='joint_student_data.tsv', sep = '\t') #writing file
