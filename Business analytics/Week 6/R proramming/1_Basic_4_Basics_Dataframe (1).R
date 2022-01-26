
library(readxl)
library(ggplot2)

data <- read_excel("Sales Transactions.xlsx",skip = 2,col_names = TRUE)                                                                        
df <- data.frame(data)
df$Amount = as.numeric(df$Amount)


test <-aggregate(df[,6], list(df$Region, df$Product), mean)
test
f1 <- test
colnames(df1) <- c('Regions','Product','Amount')
df1

p<-ggplot(df1, aes(x=Regions, y=Amount, fill=Product)) +
  geom_bar(stat="identity")+theme_minimal()
p


