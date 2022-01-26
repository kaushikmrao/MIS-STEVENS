########### Read and Save Data ############
?getwd
getwd()

#### Read CSV File ####
# First, know your working directory
getwd()
# If you are under the right directory, you can import your data
FF <- read.csv("Data/FF_3_Factors.CSV")
dim(FF) # [1] 1128    5
colnames(FF) # [1] "YM" "Mkt.RF" "SMB" "HML" "RF"  

# You can also use read.table
FF <- read.table("Data/FF_3_Factors.CSV") 
dim(FF) # [1] 1129    1
colnames(FF) # [1] "V1"

FF <- read.table("Data/FF_3_Factors.CSV", sep = ',') 
FF <- read.table("Data/FF_3_Factors.CSV", sep = ',', header = T) 
# read.table() can be used to read .txt files

# Note:
# If you open R studio by double clicking the R file you work with,
# your working directory will be the folder where your R file is stored
# However, if you open R studio directly, you will be in the default directory

# What if you need to change your working directory to your desktop
# You can do it manually
setwd("C:/Users/kerwi/Desktop/R")
setwd("C:/Users/kerwi/Desktop")
# "kerwi" is the name of my laptop
getwd()

FF <- read.csv("Data/FF_3_Factors.CSV")
# Error: Cannot find the data file

# Or you can do it under "Files" in R studio
# Find "More". 
# Under "More", find "Go to working directory" and "save as working directory"

### If you haven't change the working directory back, you cannot proceed
setwd("C:/Users/kerwi/Desktop/R")
FF <- read.csv("Data/FF_3_Factors.CSV") # works

# Use read_csv (underscore) to import large dataset 
# And it is the standard way to import csv data in R studio
library(readr)
FF_csv <- read_csv("Data/FF_3_Factors.CSV")

# Let's try "Import Dataset" function in R studio
# library(readr)
# FF_3_Factors <- read_csv("Data/FF_3_Factors.CSV")
# View(FF_3_Factors)
# View() opens another window to show the data


#### Read Excel File ####
# Again, you can simply use "Import Dataset"
library(readxl)
FF_Excel <- read_excel("Data/FF_3_Factors_Excel.xlsx")
View(FF_Excel)


#### Some Useful Commands ####
class(FF) # Class or type of an object.
str(FF) # Number of elements/components.
summary(FF) # Number of elements/components.
dim(FF) # Number of elements/components.
nrow(FF) # Number of elements/components.
ncol(FF) # Number of elements/components.

FF$Mkt.RF
length(FF$Mkt.RF) 

# I often use name "tmp" to define a temporary object
tmp1 <- cbind(FF, FF_Excel) # Combines objects as columns.
tmp2 <- rbind(FF, FF_Excel) # Combines objects as rows.

head(FF, 10) # show the first n obs (rows)
tail(FF, 4)  # show the last n obs (rows)

# save data
write.csv(tmp1, "Data/tmp1.csv")
write.csv(tmp1, "Data/tmp1.csv", row.names = F)
# write.table(tmp1, "Data/tmp1.csv", sep = ',', row.names = F)

ls() # Lists current objects.

rm(tmp1) # Deletes one or more objects.
rm(list = ls()) # remove all objects

