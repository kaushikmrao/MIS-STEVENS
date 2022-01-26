#### Package "dplyr" ####
library(dplyr)

# %>% "pipelining" can be read as "then"
mtcars
df <- mtcars


# calculate the mean mpg for all cars
mean(df$mpg) # R basic
df %>% summarise(mean(mpg)) # dplyr

# calculate the mean mpg for cars within different groups
#  for example, we group cars by the Number of cylinders (cyl)
?mtcars
unique(df$cyl)
sort(unique(df$cyl))
tmp <- sort(unique(df$cyl))
for (i in tmp) {
  # print(i)
  print(paste('For cars with cyl ==', i, 'the mean mpg is:', mean(df$mpg[df$cyl==i])))
  # print(mean(df$mpg[df$cyl==i]))
}

df %>% group_by(cyl) %>% summarise(mpg = mean(mpg))
# assign the result to a new variable
df.mean <- df %>% group_by(cyl) %>% summarise(mpg = mean(mpg))

# Recommand to write dplyr in separate lines
df.mean <- df %>%
  group_by(cyl) %>%
  summarise(mpg = mean(mpg))

# you can group df by two or more varibales
tmp <- df %>%
  group_by(cyl, am) %>%
  summarise(mpg = mean(mpg))

# "summarise" summarizes the original dataset into a smaller dataset:
#     each group is summarized into one row 
# "mutate" adds a new column to the original dataset
tmp <- df %>%
  group_by(cyl) %>%
  mutate(avg.mpg = mean(mpg))
# You can think of mutate as merge(df, df.mean, by='cyl')

tmp <- df %>%
  group_by(cyl) %>%
  mutate(avg.mpg = mean(mpg)) %>%
  arrange(cyl)

# filter rows with conditions
tmp <- df %>% filter(cyl < 5)

# you can also do the filter after you get the summarized result
df %>%
  group_by(cyl, am) %>%
  summarise(mpg = mean(mpg))

df %>%
  group_by(cyl, am) %>%
  summarise(mpg = mean(mpg)) %>% 
  filter(mpg < 20)
