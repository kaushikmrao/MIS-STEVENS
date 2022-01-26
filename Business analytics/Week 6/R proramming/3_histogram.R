# Bar plots look at the relationship between two variables
# Histogram look at the distribution of one variable

# plot(x,y,type='h') -- histogram-like bar plots
# hist()             -- histogram

1:100
hist(1:100, breaks = 10)

rep(6,10)
x=c(1:100, rep(6,10))
hist(x, breaks = 10)

# sample from a standard normal distribution
?rnorm
rnorm(1000)
hist()
hist(rnorm(100000), breaks = 100)

library(ggplot2)
df <- mpg
# histogram
hist(df$hwy, breaks = 30)
ggplot(data = df, aes(x=hwy)) + geom_histogram(bins = 30)

# bar plots
ggplot(data = df, aes(x=displ, y=hwy)) + geom_point()
plot(df$displ, df$hwy, type = 'h')

plot(df$displ, df$hwy, type = 'b') # 'b' in plot() refers to 'both'
?plot
