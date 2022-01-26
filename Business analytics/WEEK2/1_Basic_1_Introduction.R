########### Some Basics ############
# Use # (pound sign) to write comments
# Anything appeared after the pound sign will be ignored by the R interpreter
# Or use shortcut (Shift+Ctrl+c) to un/comment one line or a block

# To execute one or multiple lines, click the "Run" symbol above
#                                   or use shortcut (Ctrl+Enter)

# Assignment operation: left arrow
x <- "Hello World" # less-than sign + minus sign
print(x)
x # calling variable x also prints x

# You can directly print the value
"Hello World"
Hello World # Error. Use "" or '' represent a string
print("Hello World")
print(111)

# Right arrow also works
"Hello World!!!" -> y # minus sign + greater-than sign
print(y)

# Print(y) # R is case sensitive

# = (equal sign) should also work, though not standard in R
y = "equal sign also works"
print(y)

# R as a calculator
# Basic Calculation
4 + 3
1 - 4
3 * 5
9 / 2
6 ^ 2

5 / 2
5 %/% 2 # integer division: the integer of 5/2
5 %% 2  # modulus: the reminder of 5/2


# scientific notation is on by default
options(scipen = 0) # turn on scientific notation
exp(2)
exp(50)
exp(709) #What is the value of infinity in R
exp(710) #Inf

options(scipen = 999) # shut down scientific notation
exp(2)
exp(50)
exp(709) 
exp(710) #Inf

# get detailed information from R
help("options")
help(options)
?options 
# when scipen is a large number (999), scientific notation is turned off
# when scipen is a small number (0),   scientific notation is turned on 

# To get help, use Help, help(), or ? 
help("read.csv") # built-in help
help(read.csv) # built-in help
?read.csv # built-in help

exp(log(6))
sin(pi/2)
cos(pi)
max(3,1,7)
min(3,1,7)
sum(3,1,7)
prod(3,1,7)
sqrt(9)
factorial(4) # factorial 1*2*3*4

# TRUE and FALSE
TRUE
FALSE

1>2
2>1

# if(){}else{}
i <- 0
if(i==0){print(i+1)} # conditional execution: if i==0, then execute
# == is a logical operator which compares if two things are exactly equal
i==0
i>0
i==1
i!=1 # whether i is not equal to 1

if(i==0){print("Condition is true.")}else{print("Condition is false")}
if(i!=0){print("Condition is true.")}else{print("Condition is false")}

if(i!=0){
  print("Condition is true.")
}else{
  print("Condition is false")
}



# c() define a vector
x <- c(1,2,3)
print(x)

# for-loop
for(i in x){
  print(i+1)
}

