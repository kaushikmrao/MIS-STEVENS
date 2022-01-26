########### Basic Operations for Dataframe ############

# Simple operators: +, -, *, /
# logical operators: <, <=, >, >=, ==, !=, !x, x | y, x & y

# Import Fama-French three factor dataset
FF <- read.csv("Data/FF_3_Factors.CSV")

# Know your data after importing it 
class(FF)
dim(FF) # 1128 rows, 5 columns
colnames(FF)
str(FF)
# "YM": year-month
# "Mkt.RF": market return minus RF (excess return on the market)
# "SMB": factor small-minus-big
# "HML": factor high-minus-low  
# "RF": risk-free rate (one-month Treasury bill rate)
# For details, refer to the following link
# http://mba.tuck.dartmouth.edu/pages/faculty/ken.french/Data_Library/f-f_factors.html
head(FF) # July.1926
tail(FF) # June.2020
1128/12 # 94-year of data

# How to change the name of the variables
# YM -> Date
colnames(FF)
colnames(FF)[1] <- "Date"
colnames(FF)
head(FF$Date)

# Change it back to "YM"
colnames(FF)[1] <- "YM"

# Request 1: add a new column called "Mkt" (market return).
# the two vectors need to have the same length

# Vector addition  (element-wise)
FF$Mkt <- FF$Mkt.RF + FF$RF
length(FF$Mkt)

# Subtraction (element-wise)
FF$Mkt - FF$RF
# Multiplication (element-wise)
FF$Mkt * FF$RF
# Division (element-wise)
FF$SMB / FF$Mkt.RF

# How to turn off scientific notations
options(scipen = 999)
FF$SMB / FF$Mkt.RF

#### Logical Operators ####
# if x > 1 (element-wise)
FF$Mkt > 1 # returns a vector of T or F
head(FF$Mkt > 1, 5)
head(FF$Mkt, 5)

# logical operators: <, <=, >, >=, ==, !=, !x, x | y, x & y
# == is "Exactly equal to"
tail(FF$YM, 5)

tmp <- FF$YM == 202004
tail(tmp, 5)

tmp <- FF$YM > 202004
tail(tmp, 5)

# Statement "variable[condition] <- expression"
# will only make the assignment when condition is TRUE.

# Request 2: Create a new variable called "Mkt.Up"
# Mkt.Up is 1 when the market return in that month is above 0 (greater or equal to)
# and    is 0 when the market return in that month is below 0
FF$Mkt.Up <- 0 # a new vector with all zero
FF$Mkt.Up[FF$Mkt >= 0] <- 1 # Assign 1 to the rows which satisfy the condition

# Use ifelse() to construct a similar variable
FF$Mkt.Down <- ifelse(FF$Mkt<0,'Down','Up')

# print market returns in 'Down' months
FF$Mkt[FF$Mkt.Down=='Down']
FF$Mkt[FF$Mkt<0]
FF[FF$Mkt<0, 'Mkt']

# which() tells you which items or rows satisfied the conditions
tmp <- head(FF$Mkt,6) # 3.18  2.89  0.59 -2.92  2.84  2.90
tmp
which(tmp >= 0) # 1 2 3 5 6
which(tmp >= 2) # 1 2 5 6

# During the last 94 years (1128 months), what is the percentage of up months?
sum(FF$Mkt.Up)
length(FF$Mkt.Up)
sum(FF$Mkt.Up)/length(FF$Mkt.Up) # 63% of the months have positive market returns

#### sort data ####
# Let's first take a subset of FF
tmp <- FF[1:6, c("YM", "Mkt")] # first 6 rows and only 2 columns
tmp 

# What if you want to take the last 6 rows
(nrow(FF)-5):nrow(FF) # 1123 1124 1125 1126 1127 1128
tmp <- FF[(nrow(FF)-5):nrow(FF), c("YM", "Mkt")] 
tmp

tmp$Mkt # 0.02  -8.01  -13.27  13.65   5.59   2.46
order(tmp$Mkt) # 3 2 1 6 5 4
# What order() tells you is that 
# the ordered 1st (smallest) item is the 1st item before ordered
# the ordered 2nd            item is the old item before ordered
# the ordered 3rd            item is the old item before ordered
# the ordered 4th (largest)  item is the old item before ordered

# Sort data in ascending order
tmp[c(3,2,1,6,5,4),]
tmp[order(tmp$Mkt),]
# the above two operations give the same result
tmp <- tmp[order(tmp$Mkt),]

# Sort data in descending order
tmp <- tmp[order(-tmp$Mkt),]
tmp

#### Merge ####
tmp1 <- FF[1:6, c("YM", "Mkt", "RF")]
tmp1

tmp2 <- FF[4:9, c("YM", "SMB", "HML")]
tmp2

tmp <- merge(tmp1, tmp2, by="YM")
tmp

merge(tmp1, tmp2, by="YM", all.x = T)

merge(tmp1, tmp2, by="YM", all.y = T)

merge(tmp1, tmp2, by="YM", all = T)

# What if the name of the key is different in the two datasets
colnames(tmp2)
colnames(tmp2)[1] <- 'Date'

merge(tmp1, tmp2, by="YM") # Error. There is no column 'YM' in tmp2

merge(tmp1, tmp2, by.x="YM", by.y = 'Date')
# Of course, you can also change 'Date' to 'YM' and then merge

