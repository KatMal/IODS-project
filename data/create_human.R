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

## Exercise 5 starts here

#The data set is about country specific human development index (HDI) and gender inequality index (GII).
#HDI measures the development of the country and includes measurements such as life expectancy
#and years of education as well as the GNI. GII measures the inequality between the sexes across different countries.
#GII contains information regarding the secondary educational attainment of the sexes and labour force participation.
#Additionally the GII measures the number of female representatives in the parliament.
#GII also contains information regarding the maternal mortality rate as well as the rate of teen pregnancies and births.
#Overall both HDI and GII rank countries according to how well they do by the things they measure

#The human dataset below contains the above information from the HDI and GII datasets as well as the ratio of secondary
#education attainment between women and men ans well as the labour force participation ratio between women and men.


human <- read.csv(file='data/human.tsv', sep = '\t')
human$labour_ratio <- human$labfF / human$labfM #had to fix this as there is a typo on line 44 that creates a negative value

dim(human) # the data set has 19 variables and 195 observations
str(human) #most of the data is numeric with some character variables

#changing GNI to numeric

human$GNIperC <- as.numeric(sub(",", "",human$GNIperC, fixed = TRUE))

#taking only wanted columns and rows
regions = c('East Asia and the Pacific', 'Europe and Central Asia', 'Latin America and the Caribbean', 'Sub-Saharan Africa', 'World', 'South Asia', 'Arab States')

#na.omit gets rid of all rows with na values including the regions so the vector above was not needed
human2 <- subset(na.omit(human), select = c('Country', 'edu_ratio', 'labour_ratio', 'exp_edu', 'life_exp', 'GNIperC', 'mat_mort', 'teen_birth', 'representation_perc'))

row.names(human2) <- human2$Country
human2 <- subset(human2, select = -Country)

dim(human2) # 155 observations, 8 variables

write.table(human2, file='data/human2.tsv', sep = '\t', row.names = TRUE) #writing file
