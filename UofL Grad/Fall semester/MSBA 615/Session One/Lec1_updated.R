#install.packages(c("tidyverse", "dslabs"))
# The 'library()' function loads the packages into the current R session, making their functions available.
# 'tidyverse' is a collection of packages for data science, including data manipulation (dplyr) and plotting (ggplot2).
# 'dslabs' is a package containing datasets for learning data science.
library(tidyverse)
library(dslabs)

#plots
# Sample Data
# A vector is a one-dimensional array of data points of the same type.
advertising <- c(5, 7, 8, 10, 12, 15)
sales <- c(50, 65, 78, 85, 95, 105)

# Scatter Plot
plot(advertising, sales, 
     main = "Advertising vs Sales Revenue", 
     xlab = "Advertising Spend ($1000s)", 
     ylab = "Sales Revenue ($1000s)", 
     pch = 19, col = "blue")


# arithmatic operations

# In R, '<-' is the conventional assignment operator, though '=' also works.
# Here, we assign the value 5 to the variable 'x'.

var1=2
print(var1)

var1<-2.5
print(var1)
x <- 5
x-1


x=15
x-1



# Vectors and Vector Operations
#c() is used to create a vector
# vector contains similar type of elements
x <- c(10, -1, 3.5, 2, 12, 24)
print(x)
x1 <- c(10, -1, 3.5, 2, 12, "abc")
print(x1)


# in R indexing start at 1
# whatever slciing is provided is inclusive unlike in python where it startes as inclusives and ends as exclusive
# python x[0]=10,x[1]=-1
# R: x[0] is nothing or zero always, x[1] gives 1st element
# x[1:3]: python will give me x[1],x[2]
# R will give me x[1],x[2],x[3]
x <- c(10, -1, 3.5, 2, 12, 24)
x[1:4]

#x[3:4]

#Vectorization
# When you perform an operation on a vector, R applies it to each element individually.
# This is called vectorization and is much faster than using a loop.
x <- c(10, -1, 3.5, 2, 12, 24)
x # Original vector: c(10, -1, 3.5, 2, 12, 24)



y<-x*3  # elementwise operation
y

x
# If you perform an operation between two vectors of different lengths, R "recycles" the shorter vector.
x <- c(10, -1, 3.5, 2, 12, 24)
x1 <- c(1,2,3)

# Here, x1 is recycled to become c(1, 2, 3, 1, 2, 3) to match the length of x.
x
x+x1

sum((x - mean(x))^2)

(x - mean(x))^2



mean(x)
sum((x - mean(x))*(x - mean(x)))/length(x)


# another way to create vector
x <- -3:5
x

x<-c(1.5,2,2.5,3,3.5,4,4.5)
x
# one more way
x<-seq(from=1.5, to=4.5, by=0.5)
x
vec1<-seq(10,90,length=15)
vec1
# yet another way
x<-seq(from=2, to=6, by=0.4)
x
x<-seq(from=-1, to=1, length=6)


x<-1:10
x
x<-rep(1:10,each=4)
x

# yet another way
x<-rep(2:5,each=3)
x
x<-c(2:5,seq(1,2,by=0.2),rep(4:5,each=3))
x
# try: 1:3 + rep(seq(from=0,by=10,to=30), each=3)
# try: 1:10 * c(-1,1)


# R has special values for non-standard numbers.
# Inf / -Inf: Infinity, e.g., 1/0
# NaN: Not a Number, e.g., 0/0
# NA: Not Available, used for missing data.
# beware of infinite, nan and na
v <- c(-100, Inf, -Inf, NaN, NA)
print(v)
is.finite(v)
# passing a vector through the variable to find which specific on is.'finite'
v[is.finite(v)]
is.nan(v)
# NA(not availabe)  is for missing data while NAN(not a number) is for corrupted data 
is.na(v)
sum(is.finite(v))


# combining vectors is easy
x <- 1:10
y <- 11:20
x
y
# 'rbind()' (row-bind) treats vectors as rows and combines them into a matrix.
rbind(x, y)

# 'cbind()' (column-bind) treats vectors as columns and combines them into a matrix.
cbind(x, y)
rbind(x, y)
cbind(x, y)

# subsetting is basically slicing
x <- c(5,9,2,14,-4)
x[3]  # index start from 1
y<-1
# Access multiple elements by providing a vector of indices.
x[c(1,2,4)]
x[c(y,2,3,5)]

# Logical Subsetting: This is a powerful feature.
# Create a logical vector (TRUE/FALSE) based on a condition.
x[x>3]
sum(x[x>3])
x[3:length(x)]



# coercion
# If a vector contains different data types, R will "coerce" them to the most flexible type.
# The hierarchy is: character > numeric > logical.
x <- c("1", "b", "3")
as.numeric(x)


x<-c("Red", "Blue", "Green", "Red", "Blue")
x
# factors
# Factors are a special data type for storing categorical data efficiently.
# R stores the categories ("levels") as integers in the background, which saves memory.
# Creating a factor
colors <- factor(c("Red", "Blue", "Green", "Red", "Blue"),
                 levels = c("Blue", "Red", "Green"),
                 ordered = TRUE)
print(colors)
# Checking levels
levels(colors)
#in the background, R stores these levels as integers and keeps a map to keep track of the labels. This is more memory efficient than storing all the characters.
# Creating an ordered factor
satisfaction <- factor(c("Low", "Medium", "High", "Medium", "Low"),
                       levels = c("Low", "Medium", "High"),
                       ordered = TRUE)
print(satisfaction)


# some important functions may be required in data analysis

# Example vector
x <- c(5, 2, 9, 1, 7, NA)
mean(x)
# Get the maximum value
# The 'na.rm = TRUE' argument (Not Available, ReMove) tells the function to ignore NA values before computing.
max(x,na.rm=TRUE)  # Output: 9

mean(x)

mean(x,na.rm=TRUE)
#another way to do is to extract the finite value and then find the mean or whatever descriptic stats you want
mean(x[is.finite(x)])

vec <- c(10, 20, NA, 30, 40, NA, 50)
# Calculate mean without handling NA (returns NA)
mean(vec)
mean(vec,na.rm=TRUE)
mean(vec[is.finite(vec)])

x <- c(5, 2, 9, 1, 7)
x
max(x)


# Functions to learn = 'Which', 'match', in', 'sapply'

# which
# 'which()' takes a logical vector as input and returns the INDICES where the value is TRUE.
x <- c(TRUE, FALSE, TRUE, FALSE)
# index 1 and index true is true for the above vector 
which(x)  # Output: 1 3

x1 <- c(5, 2, 9, 1, 7)
x1 
x1 > 3 
which(x1>3)

# Get the index of the maximum value
which.max(x1)  # Output: 3 

#match and %in%
x <- c("a", "b", "c", "a")
y <- c("b", "c", "d")

# 'match(x, y)' returns a vector the same length as x. For each element in y,
# it gives the index of its FIRST appearance in y. If not found, it returns NA.
match(x, y)  # Output: NA 1 2 NA
# "a" is not in y -> NA
# "b" is at index 1 in y -> 1
# "c" is at index 2 in y -> 2
# "a" is not in y -> NA

x <- c("a", "b", "c", "a")
y <- c("b", "c", "d")

# The '%in%' operator returns a LOGICAL vector the same length as the left-hand vector.
# It checks if each element of the left vector is present anywhere in the right vector.
x %in% y  # Output: FALSE TRUE TRUE FALSE
y %in% x
# Is "a" in y? -> FALSE
# Is "b" in y? -> TRUE
# Is "c" in y? -> TRUE
# Is "a" in y? -> FALSE 



###Season 2
##Basic programming tools

# Conditionals
a <- 0

if (a != 0) {
    print(1/a)
} else{
    print("No reciprocal for 0.")
}


a <- 0
ifelse(a > 0, 1/a, NA)

a <- c(0, 1, 2, -4, 5)
result <- ifelse(a > 0, 1/a, NA)
result

#functions
# functions are objects, so you can assign them
avg <- function(x){
    s <- sum(x)
    n <- length(x)
    s/n
}
x <- 1:100
avg(x)

 greet <- function(){
     print("hello")
 }
greet()
identical(mean(x), avg(x)) # both the functions are equal

# exercise 
#define a function that computes either the arithmetic or geometric average depending on a user defined variable
avg <- function(x, arithmetic = TRUE){
    n <- length(x)
    ifelse(arithmetic, sum(x)/n, prod(x)^(1/n))
}

# loops

factorial2 = function(n) {
  out = 1
  for (i in 1:n) {
  out = out*i
  }
  out
  }

factorial2(10)

isPrime = function(n) {
    i = 2
      if (n < 2) return(FALSE)
    while (i < sqrt(n)) {
        if (n %% i == 0) return(FALSE)
          i = i+1 }
    return(TRUE)}

isPrime(10)


# loops are slow in R, always try vectorization first

#loop way
system.time(for (i in 1:1e7) i^2)

# vectorization way
system.time(seq_len(1e7)^2)

#SAPPLY (perform element-wise operations on any function)
# The 'apply' family of functions provides a concise way to apply a function over a data structure,
# acting as a bridge between loops and full vectorization.
# 'sapply' (simplified/sequencially apply) applies a function to each element of a vector or list and simplifies the result.
x <- 1:10
sapply(x, sqrt)


# Create a list of numeric vectors
data_list <- list(
    c(10, 20, 5, 40, 25),
    c(3, 8, 15, 6, 2),
    c(100, 50, 75, 125, 110)
)

# Apply which.max() to each vector in the list using sapply
max_indices <- sapply(data_list, which.max)

# Print results
print(max_indices)

