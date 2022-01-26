### Question: (depend on HW4)
# What if you want to know the average return across all factors 
#                                          in each calendar month?

# You may want to use dplyr group_by()
# Recall how to apply group_by()
library(dplyr)
df <- mtcars
unique(df$cyl) # 4 6 8
# cyl is a variable -- it has three unique value
# so you can group mtcars by 'cyl'
df %>%
  group_by(cyl) %>%
  summarise(mpg=mean(mpg))
# Is there any variable in 'res' to group by? No
# Factor returns are columns
# call it 'wide-format'

# convert it into 'long-format': all factors in one column
## reshape2
library(reshape2)

# function melt()
?melt
res.melt <- melt(data = res, 
                 id.vars = 'Month', 
                 variable.name = 'Factor',
                 value.name = 'RET')
# 'Factor' can work as a group_by variable
tmp <- res.melt %>%
  group_by(Factor) %>%
  summarise(RET=mean(RET))

# Why do we need reshape?
# To use group_by() in 'dplyr'
# To use ggplot() in 'ggplot2'
library(ggplot2)
ggplot(data = res.melt, aes(x=as.factor(Month), y=RET, fill=Factor)) + 
  geom_bar(stat="identity", position=position_dodge()) + 
  theme_bw()

?geom_bar

# What if you would like to convert the long-format to wide-format
# Use function acast() and dcast()
# 'a' and 'd' stand for 'array' and 'dataframe' as output
colnames(res.melt)
?dcast
res.cast <- dcast(data=res.melt, 
                 formula = Month ~ Factor, 
                 value.var = 'RET')
# You will find res.cast is exactly the original res
