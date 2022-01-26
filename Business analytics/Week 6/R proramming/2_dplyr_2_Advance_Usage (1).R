#### Package "dplyr" ####
library(dplyr)

# .groups is an argument of summarise() func 
#           to specify the grouping structure of the output
# recommend: .groups = 'drop'   
#           which drops any grouping structure one summarise() is done
?summarise

mtcars %>% 
  group_by(cyl, am) %>%
  summarise(mpg = mean(mpg), .groups='drop')
# the results are the same, so typically we do not worry about .groups

# count the number of obs for each group
res <- mtcars %>%
  group_by(cyl, am) %>%
  summarise(num_obs = n())

# mutate
tmp <- mtcars %>%
  group_by(cyl, am) %>%
  mutate(num_obs = n()) %>% 
  arrange(cyl, am)

# give each obs in each group an index 1:n()
tmp <- mtcars %>%
  group_by(cyl, am) %>%
  mutate(num_obs = 1:n()) %>% 
  arrange(cyl, am)

# FF dataset
FF <- read.csv("Data/FF_3_Factors.CSV")
FF <- FF[FF$YM>=201801,]
FF$YM
class(FF$YM)

## Introduce substr()
'Hello_World'
substr('Hello_World', 1, 5)
substr('Hello_World', 1, 8)
substr('Hello_World', 7, 11)
nchar('Hello_World') # number of characters

# for vectors
FF$YM
substr(FF$YM,1,4)
class(substr(FF$YM,1,4))
as.integer(substr(FF$YM,1,4))
FF$Year <- as.integer(substr(FF$YM,1,4))

# Now I can group FF by Year
res <- FF %>% 
  group_by(Year) %>%
  summarise(Mkt.RF=mean(Mkt.RF),
            SMB=mean(SMB),
            HML=mean(HML))

# mutate
res <- FF %>% 
  group_by(Year) %>%
  mutate(Mkt.RF.mean=mean(Mkt.RF),
         SMB.mean=mean(SMB),
         HML.mean=mean(HML))

# lag monthly factor values within each year
res <- FF %>% 
  group_by(Year) %>%
  mutate(SMB.lag=lag(SMB,1))
# Note: many packages have lag() functions
#           so specify the package whenever use it
dplyr::lag(FF$YM)

res <- FF %>% 
  group_by(Year) %>%
  mutate(SMB.lag=dplyr::lag(SMB,2))


# summarise multiple columns like we did before
res <- FF %>% 
  group_by(Year) %>%
  summarise(Mkt.RF=mean(Mkt.RF),
            SMB=mean(SMB),
            HML=mean(HML),
            RF=mean(RF))

# for the same operation, we have to write in separate lines
# we can simplify the code by using across() function
colnames(FF)

res <- FF %>% 
  group_by(Year) %>%
  summarise(across(2:5, mean, .names = "Mean_{.col}"))
?across

colnames(FF)
res <- FF %>% 
  group_by(Year) %>%
  summarise(across("Mkt.RF":"RF", mean, .names = "{.col}.mean"))

res <- FF %>% 
  group_by(Year) %>%
  summarise(across("Mkt.RF":"HML", list(mean = mean, sd = sd), .names = "{.col}.{.fn}"))

