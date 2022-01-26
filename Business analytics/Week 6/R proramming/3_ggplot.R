## Why do we need visualization?

# It is easier for people to perceive 
#   length, size, shape, color than numbers and words. 
# Visualization is a mapping from numbers to figures 
#   that people can have better understanding on. 
# Introduce package "ggplot2"

# It is very important to imagine the figure 
#   you would like to present to people 
#   before you actually construct the figure. 

## Examples of bad figures
# 1. mtcars
df <- mtcars
colnames(df)
# plot(x-axis, y-axis, plot types)
plot(df$cyl, df$mpg, type = 'p') # points

plot(df$cyl, df$mpg, type = 'l') # lines
plot(df$cyl, df$mpg, type = 'h') # histogram
plot(df$cyl, df$mpg, type = 's') # steps
# Only points (scatter) plot seems reasonable

# 2. Fama-French data
FF <- read.csv("C:/Users/kerwi/Dropbox/QF104/Week_8/Data/FF_3_Factors.CSV", stringsAsFactors=TRUE)
FF$Mkt <- FF$Mkt.RF + FF$RF
# I would like to look at my cumulative return 
# if I invest $100 in the market portfolio in Jan 2000
FF[,-1] <- FF[,-1]/100
df <- FF[FF$YM>201000,]
df$Date <- as.Date(paste0(df$YM,'28'), format = '%Y%m%d')
df$CumRET <- cumprod(df$Mkt+1)*100

plot(df$Date, df$CumRET, type = 'p') # points
plot(df$Date, df$CumRET, type = 'l') # lines
plot(df$Date, df$CumRET, type = 'h') # histogram
plot(df$Date, df$CumRET, type = 's') # steps
# line plot looks better


# The following websites can help you understand what kinds of plots ggplot2 can draw
# https://www.r-graph-gallery.com/ggplot2-package.html
# http://r-statistics.co/ggplot2-Tutorial-With-R.html
# http://r-statistics.co/Top50-Ggplot2-Visualizations-MasterList-R-Code.html

## Let's now introduce ggplot2
library(ggplot2)
# ?ggplot2

# There is another dataset about cars in ggplot2
# View(mpg)
dim(mpg) # 234 11
dim(mtcars) # 32 11
# ?mpg

df <- mpg
unique(df$class) # "type" of car
sort(unique(df$displ)) # engine displacement, in liters
sort(unique(df$hwy)) # highway miles per gallon
unique(df$drv) # the type of drive train,  where f = front-wheel drive,
               #                          r = rear wheel drive, 4 = 4wd
unique(df$year) # 1999, 2008
# ?ggplot
# The structure is as follows:
# ggplot(data = df, mapping = aes(x, y, other aesthetics))
?aes
ggplot(data = df, aes(x=displ, y=hwy)) # not enough to plot
# To print, we need to at least specify the types of the plots
# plot(): p, l, h, s
# ggplot(): geom_point(), geom_line(), geom_histogram(), geom_step()
ggplot(data = df, aes(x=displ, y=hwy)) + geom_point()
plot(df$displ, df$hwy, type = 'p')

# You can start with the basic structure of the plot
# then add components to it
# To demonstrate, let's first assign the plot strucutre to 'g'
g <- ggplot(data = df, aes(x=displ, y=hwy))
g + geom_point()

# ?geom_smooth
# show patterns in the presence of overplotting
# e.g., add a regression line (with gray area as confidence interval)
g + geom_point() + geom_smooth(method = 'lm', formula = 'y ~ x')
# Recall what we can get using plot()
plot(df$displ, df$hwy, type = 'p')
abline(lm(df$hwy ~ df$displ), col='blue')
# Use se=FALSE to not show the confidence interval
g + geom_point() + geom_smooth(method = 'lm', formula = 'y ~ x', se=FALSE)

# Separate obs using 'drv'
ggplot(data = df, aes(x=displ, y=hwy, color=drv)) + geom_point()
# Separate obs using 'drv'
ggplot(data = df, aes(x=displ, y=hwy, color=drv, shape=as.factor(year))) + geom_point()
# Note that the legend is automatically generated

# The single plot starts to get confusing
# You can plot two separate figures side by side
# Use facet_grid(. ~ var) for horizontal exhibition
ggplot(data = df, aes(x=displ, y=hwy, color=drv)) + 
  geom_point() + 
  facet_grid(. ~ as.factor(year))

# Use facet_grid(var ~ .) for vertical exhibition 
ggplot(data = df, aes(x=displ, y=hwy, color=drv)) + 
  geom_point() + 
  facet_grid(as.factor(year) ~ .)

# Two-dimensional separations
ggplot(data = df, aes(x=displ, y=hwy, color=drv)) + 
  geom_point() + 
  facet_grid(as.factor(year) ~ class)

# You can still add regression lines to the plots
ggplot(data = df, aes(x=displ, y=hwy, color=drv)) + 
  geom_point() + 
  facet_grid(. ~ as.factor(year)) + 
  geom_smooth(method = 'lm', formula = 'y ~ x')
# If you used color arugment in aes(), 
# geom_smooth() generate regression lines for each color (group)

# You can print regression lines without scatter plots
ggplot(data = df, aes(x=displ, y=hwy, color=drv)) + 
  # geom_point() + 
  facet_grid(. ~ as.factor(year)) +
  geom_smooth(method = 'lm', formula = 'y ~ x')

## Add labels
# labels: xlab(), ylab(), labs(), ggtitle()
ggplot(data = df, aes(x=displ, y=hwy, color=drv)) + 
  geom_point() + 
  ggtitle("Fuel Economy of Popular Cars") + 
  xlab("Engine displacement (liters)") + 
  ylab('Highway miles per gallon')


##########################
df <- mpg
# Histogram
ggplot(data = df, aes(x=hwy)) + 
  geom_histogram(bins = 30) # bins in (ggplot) == breaks in (hist) 
?geom_histogram

str(df)
# Histogram: each plot has its own y-axis
ggplot(data = df, aes(x=hwy)) + 
  geom_histogram(bins = 30) + 
  facet_wrap(~class, scales = "free_y")

# Stack histogram: each color represents a different type of drive train
# Purpose: visualize how the distribution is composed 
# Use "fill" in aes()
ggplot(data = df, aes(x=hwy, fill=drv)) + 
  geom_histogram(bins = 30) 

# density plot -- smoother than histogram
ggplot(data = df, aes(x=hwy)) + 
  geom_density()

ggplot(data = df, aes(x=hwy, color=drv)) + 
  geom_density()

# Boxplot
ggplot(data = df, aes(x=drv, y=hwy)) + 
  geom_boxplot()
?geom_boxplot
# The lower and upper hinges correspond to 
# the first and third quartiles (the 25th and 75th percentiles).

# The upper whisker extends from the hinge to the largest value 
#   no further than 1.5 * IQR from the hinge 
# (where IQR is the inter-quartile range, 
#   or distance between the first and third quartiles).

# Data beyond the end of the whiskers are called 
#   "outlying" points and are plotted individually.

# Violin-plot
ggplot(data = df, aes(x=class, y=hwy)) + 
  geom_violin()
?geom_violin

# change color and size and transparency of points
ggplot(data = mpg, aes(x=displ, y=hwy)) + 
  geom_point()

ggplot(data = mpg, aes(x=displ, y=hwy)) + 
  geom_point(color = 'steelblue', size=2, alpha=0.5)

# Add one regression line with different groups
ggplot(data = mpg, aes(x=displ, y=hwy)) + 
  geom_point(aes(color=drv), size=2) + 
  geom_smooth(method = 'lm', formula = 'y ~ x')

## Change themes
# theme(legend.position='none')
# theme_bw()
ggplot(mpg, aes(displ, hwy)) + 
  geom_point(aes(color=drv), size=2) + 
  geom_smooth(method = 'lm', formula = 'y ~ x') +
  theme_dark()
?theme_bw
# The classic dark-on-light ggplot2 theme. 
# May work better for presentations displayed with a projector

ggplot(mpg, aes(displ, hwy)) + 
  facet_grid(year ~ drv) + 
  geom_point(size=2) + 
  geom_smooth(method = 'lm', formula = 'y ~ x') + 
  theme_bw(base_size = 10)

ggplot(mpg, aes(displ, hwy)) + 
  facet_grid(year ~ drv) + 
  geom_point(size=2) + 
  geom_smooth(method = 'lm', formula = 'y ~ x') + 
  theme_light(base_size = 10)


## Deal with outliers
rnorm(10) # Generate 10 realization from standard normal distribution N(0,1)
tmp <- data.frame(x=1:100, y=rnorm(100)) # random variable N(0,1)
tmp[50, 2] <- 100 # This is a outlier by design
plot(tmp$x, tmp$y, type = 'l')
plot(tmp$x, tmp$y, type = 'l', ylim = c(-3,3))

ggplot(data = tmp, aes(x, y)) + geom_line()

# Ignore the outlier 
ggplot(data = tmp, aes(x, y)) + geom_line() + ylim(-3,3)

# Include the outlier
ggplot(data = tmp, aes(x, y)) + geom_line() + coord_cartesian(ylim = c(-3,3))

# ggsave
ggplot(data = mpg, aes(x=displ, y=hwy)) + geom_point()
g <- ggplot(data = mpg, aes(x=displ, y=hwy)) + geom_point()
ggsave(g, filename = 'C:/Users/kerwi/Desktop/mpg.pdf')
# different types
ggsave(g, filename = 'C:/Users/kerwi/Desktop/mpg.png')
