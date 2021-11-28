#author: KatMal
#date: 28.11.2021
#
library(dplyr)

hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

str(hd) #195 observations and 8 variables, two character columns and otherwise numeric data
str(gii) #195 observatiions and 10 variables, one character columns the rest are numeric

dim(hd) #195, 8
dim(gii) #195, 10

summary(hd)
summary(gii)

#renaming the columns
hd <- hd %>%
  rename(
    HDI.Index = Human.Development.Index..HDI.,        
    life_exp = Life.Expectancy.at.Birth,              
    exp_edu = Expected.Years.of.Education,
    mean_edu = Mean.Years.of.Education,               
    GNIperC = Gross.National.Income..GNI..per.Capita,
    GNI_rank = GNI.per.Capita.Rank.Minus.HDI.Rank  
  )


gii <- gii %>%
  rename(
    GII.Index = Gender.Inequality.Index..GII.,              
    mat_mort = Maternal.Mortality.Ratio,                    
    teen_birth = Adolescent.Birth.Rate,                       
    representation_perc = Percent.Representation.in.Parliament,        
    eduF = Population.with.Secondary.Education..Female.,
    eduM = Population.with.Secondary.Education..Male.,  
    labfF = Labour.Force.Participation.Rate..Female.,    
    labfM = Labour.Force.Participation.Rate..Male. 
  )
#mutating data

gii$edu_ratio <- gii$eduF / gii$eduM
gii$labour_ratio <-- gii$labfF / gii$labfM

#merging

human = merge(gii,hd, by='Country')
dim(human) #195 observations, 19 columns

write.table(human, file='human.tsv', sep = '\t') #writing file

