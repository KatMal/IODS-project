#author KatMal
#date: 12.12.2021
#


#downloading data
BPRS <- read.table('https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt', sep = " ", header = TRUE)
RATS <- read.table('https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt', sep = "\t", header = TRUE)

dim(BPRS) #40 observations, 11 variables
dim(RATS) #16 observations, 13 variables

names(BPRS) #both datasets have subjects & treatment group and then information from different time steps
names(RATS)

str(BPRS) #only int columns in both datasets
str(RATS)

summary(BPRS) #median and mean diverge somewhat in the weekly data
summary(RATS) #median and mean seem to be quite different

#converting to factors
library(dplyr)
library(tidyr)

BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

RATS$Group <- factor(RATS$Group)
RATS$ID <- factor(RATS$ID)

#converting to long form
BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)
BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(BPRSL$weeks, 5, 5)))

RATSL <-  RATS %>% gather(key = WD, value = weight, -Group, -ID)
RATSL <-  RATSL %>% mutate(Time = as.integer(substr(RATSL$WD, 3, 4)))
#checking the data

names(BPRSL)
names(RATSL)

glimpse(BPRSL) #360 rows, 5 columns, factor level data for treatment & subject
# chr data for weeks and adjusted int data for week that corresponds to the weeks one
#int data for bprs
glimpse(RATSL)# 176 rows, 5 columns, factor data for ID and group
#similarly chr data for Times and corresponding int Time
#rats is also int

summary(BPRSL)
summary(RATSL)

#in general it seems that the long form data "stacks" all the times from the 
#wide form data on top each other in columns

#saving data
write.table(RATSL, file='data/ratsl.tsv', sep = '\t') 
write.table(BPRSL, file='data/bprsl.tsv', sep = '\t') 
