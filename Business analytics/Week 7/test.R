
library(readxl)
library(dplyr)

data <- read_excel("midterm.xlsx",col_names = TRUE)                                                                        
df <- data.frame(data)
df
data[RET == NA] <- 0 &&  data[SHROUT == " "] <- 0                       # Replace 0 with NA
data  
df %>% 
  select(PERMNO, date, SHRCD, TICKER, PRIMEXCH,PRC, RET, SHROUT) %>%
  filter(SHRCD %in% c("10", "11"), PRIMEXCH %in% c('N','A','Q'))
df
  test <-df$PRC*df$SRHOUT
  test