#author: katmal
#date: 13.11.2021
#this is a script for data analysis in execise 2
library(dplyr)

learn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

#basic analysis of the shape and dimensions of the data:

dim(learn14) #the data has 183 rows and 60 columns
str(learn14) #most of the columns contain integer data except for the gender columns which has factor type data

#these were copied from the datacamp exercise
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

#making new columns
learn14$attitude <- learn14$Attitude / 10
learn14$deep <- rowMeans(select(learn14, one_of(deep_questions)))
learn14$surf <- rowMeans(select(learn14, one_of(surface_questions)))
learn14$stra <- rowMeans(select(learn14, one_of(strategic_questions)))

colnames(learn14)[57] <- "age"
colnames(learn14)[59] <- "points"

analysis_data <- select(learn14[learn14$points != 0,], one_of(c("gender", "age", "attitude", "deep", "surf", "stra", "points")))
dim(analysis_data) #166 rows and 7 columns

#setting new working directory path and saving data
setwd("C:\\Users\\katri\\Documents\\IODS-project")
write.table(analysis_data, file="C:\\Users\\katri\\Documents\\IODS-project\\data\\learning2014.txt", sep ='\t')

learn14 <- read.table("C:\\Users\\katri\\Documents\\IODS-project\\data\\learning2014.txt", sep = '\t', header = TRUE)

str(learn14) #the new analysis_data has 166 observations and 7 variables
head(learn14) #looks correct
