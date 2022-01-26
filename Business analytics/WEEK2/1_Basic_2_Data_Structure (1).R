########### Data Structure in R ############
# Some codes are from <<R in Action>>

# Know the R data structures:
# scalars, vectors, matrices, arrays, data frames, and lists.

#### Vectors ####
# A vector is a one-dimensionsal data
# One vector can contain only one type [num, char, logi] of data
# A scalar is just a one-element vector

# Scalar
5

# c() -- combine function 
c(5)

a <- c(1, 2, 5, 3, 6, -2, 4)     # numeric vector
b <- c("one", "two", "three")    # character vector
c <- c(TRUE, FALSE, T, F, T, F)  # logical vector
# T = TRUE, F = FALSE
T
F
class(a) # class(object) gives you the class or type of an object.
class(b)
class(c)

# If you change one element in a numeric vector to string, 
#    it becomes a character vector
a[4] <- 'OK'
class(a) # a was numeric
a
as.numeric(a) # coercion introduces NA

# T is often taken as 1, and F is taken as 0 
c(T, F) # logical
c(T, F, 2) # numeric if logical and numeric are mixed
# Example
T+F+2
sum(T, F, 2) # 1+0+2
sum(T, F, T) # 1+0+1

# What if a vector has all three types of data? It is a character vector
d <- c(F, "two", 2)
class(d)
# vector must only be one type (numeric, character, or logical)

# Use [] to refer to elements of a vector
a # vector a
a <- as.integer(a)
a

a[3] # take the 3rd element of vector a
a[c(1, 3, 5)] # 1st, 3rd, and 5th element
a[2:6] # take from the 2nd to the 6th element
# use : to generate a sequence of numbers
2:6
c(2:6)
6:2
# Alternative way to generate a sequence 
?seq
seq(1,6,1)
seq(1,6)
seq(1,6,by=0.5) # the last argument is the length of your step


#### Matrix ####
# Matrix has two dimensions
# Each element has to be in the same type (num, char, or logi)
?matrix
matrix(1:20, nrow=4, ncol=5)
matrix(1:20, nrow=5, ncol=4)
matrix(1:20, 5, 4)

# Since there are only two dimensions, you can specify either one
matrix(1:20, nrow=5) 

matrix(1:20, nrow=5, ncol=6) # Interesting to know
matrix(1:18, nrow=5) # Interesting to know
matrix(1:20) # Interesting to know

# The matrix is filled by columns as a default setting
# byrow = F 
matrix(1:20, nrow=5) 
matrix(1:20, nrow=5, byrow = F)
matrix(1:20, nrow=5, byrow = T)

is.matrix(a) # test if its argument is a (strict) matrix.
as.matrix(a) # turn its argument into a matrix

# Give names to rows and columns
cells <- c(1,26,24,68)
rnames <- c("R1", "R2")
cnames <- c("C1", "C2")
matrix(cells, nrow=2, dimnames=list(rnames, cnames))

# take elements from a matrix
x <- matrix(1:10, nrow=2)
x

# object[rows, columns]
x[2,] # 2nd row
x[,2] # 2nd column
x[1,4] # 1st row & 4th column
x[1, c(4,5)] # 1st row & (4th,5th) column


#### Array ####
# Array is similar to matrix but can have more than two dimensions
# myarray <- array(vector, dimensions)
# where vector contains the data for the array
z <- array(1:24, c(2, 3, 4))
#                c(# of rows, # of columns, # of matrices)
z
z[1,2,3] # 1st row, 2nd column, 3rd matrix

# What if four dimensions?
z <- array(1:16, c(2, 2, 2, 2)) # a matrix of matrix
z


#### Data Frame ####
# Data frame is more general than matrix 
# Different columns can contain different modes of data (numeric, character, logical)
# Data frames are the most commonly used data structure in R
# mydata <- data.frame(col1, col2, col3,.)
?data.frame

# An example from <<R in Action>>
# We have four vectors, two are numeric and two are character
patientID <- c(1, 2, 3, 4)
age <- c(25, 34, 28, 52)
diabetes <- c("Type1", "Type2", "Type1") # only three elements
status <- c("Poor", "Improved", "Excellent", "Poor")

# Combine the four vectors together and form a dataframe
data.frame(patientID, age, diabetes, status)
# Error: differing number of rows

diabetes <- c("Type1", "Type2", "Type1", "Type1")
data.frame(patientID, age, diabetes, status)

patientdata <- data.frame(patientID, age, diabetes, status)
patientdata
# Dataframe contains different types of data, 
# so that class() will returns dataframe instead of types of the data
class(patientdata)

# Take elements in dataframe
patientdata[1:3, 1:2] # [selected rows, selected columns]
# You can also use names to identify rows and columns 
patientdata[1:3, c("diabetes", "status")] 

# By not specifying any row, you select all rows
patientdata[, 1:2]
patientdata[1:2, ]
patientdata[, c("diabetes", "status")]

# If comma is missing, dataframe returns selected columns by default
patientdata[1:2]
# Suggestion: never miss the comma

# Names of columns and rows
colnames(patientdata)
rownames(patientdata)
names(patientdata)

# Use $ to select a particular variable (column)
patientdata$age
patientdata[,2]

# Other information about your dataframe
dim(patientdata) # dimension: row and column
nrow(patientdata)
ncol(patientdata)

# Add a variable in a dataframe
colnames(patientdata)
patientdata$other <- 1:4
patientdata
patientdata[,6] <- c("one","two","three","four") # not named
patientdata

# Now the dataframe has 6 columns, 
# can you skip column 7 to add column 8?
patientdata[,8] <- c('a','b','c','d') # No

# But this operation is allowed when you deal with a vector
a
length(a)
a[10] <- 10
a # it fills up the gap with NAs

# There are many built-in dataset in R
mtcars # mtcars is a dataframe about cars
?mtcars

class(mtcars) # dataframe
dim(mtcars) # dimension
nrow(mtcars) # number of rows
ncol(mtcars) # number of columns
colnames(mtcars) # column names
rownames(mtcars) # row names
summary(mtcars)
?summary
str(mtcars) # Structure of the object
?str

# summary() and str() also work for vectors
summary(mtcars$mpg)
str(mtcars$mpg)

# attach() adds the data frame to the R search path
# so that once you attach a data frame, 
# you do not have to use the $ sign to call a variable
attach(mtcars)
summary(mpg) # = summary(mtcars$mpg)
summary(cyl) # = summary(mtcars$cyl)
detach(mtcars)
# detach() removes the data frame from the search path


#### Factors ####
# Nominal variables: Diabetes (Type1, Type2) 
#                        -- no order is implied. 
# Ordinal variables: Status (poor, improved, excellent) 
#                        -- order is implied but no amount
# Continuous variables:  Age (14.5, 22.8) 
#                        -- both order and amount are implied

# You can store nominal and ordinal variables as factors
patientdata
str(patientdata) # column "diabetes" and "status" are characters 

# Let's convert two char variables to factor variables
patientdata$diabetes
factor(patientdata$diabetes)
factor(patientdata$diabetes, order=TRUE) # order is implied

patientdata$status
factor(patientdata$status, order=TRUE) # order is implied
# By default, factor levels for characters in alphabetical order

# You can override the default by specifying a levels option
factor(patientdata$status, order=TRUE, 
       levels=c("Poor", "Improved", "Excellent"))

# How to convert the variable "status" in patientdata to a factor variable?
# Convert and then assign
patientdata$status <- factor(patientdata$status, order=TRUE, 
                             levels=c("Poor", "Improved", "Excellent"))
patientdata$status 
patientdata$age <- factor(patientdata$age, order=TRUE)
patientdata$age

str(patientdata)

# How to convert factors to numeric
as.numeric(patientdata$age) # Simply conversion gives you the order
as.character(patientdata$age) # Converting to character is simple
# factor -> character -> numeric
as.numeric(as.character(patientdata$age)) 


#### List ####
# You can store different types of data in a list
# matrix() v.s. dataframe(); arrays() v.s. list()
g <- c("A", "B", "C")
h <- c(25, 26, 18, 39)
j <- matrix(1:10, nrow=5)
k <- c("one", "two", "three")
mylist <- list(ID=g, ages=h, j, k) 
# "ID" is the name of the 1st component of the list
# "ages" is the name of the 2nd component of the list
# The 3rd and 4th components are not named
mylist

# If you want to print the 2nd component
# You can either use its name or its position
mylist[[2]]
mylist$ages

