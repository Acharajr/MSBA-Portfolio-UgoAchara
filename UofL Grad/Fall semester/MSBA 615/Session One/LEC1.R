#install.packages(c("tidyverse", "dslabs"))
library(tidyverse)
library(dslabs)

# arithematic operations
# In R '<-' is the conventional assignment opperator 
# Here, we assign the value 15 to the variable 'x'


var1 <- 2
print(var1)

x<- 15
x-1

x=15
x-1

# vectors and vector operators 
# 'c()' is used to create a vector
# Vectors contain similar type of elements e.g data types
x <- c(1, -1, 3.5, 2)
print(x)

x+1  # element wise operation

sum((x - mean(x))^2)

(x - mean(x))^2

x - mean(x)

mean(x)
# another way
x <- -3:5
x

# yet another way
x<-seq(from=2, to=6, by=0.4)
x
x<-seq(from=-1, to=1, length=6)
x

# yet another way
x<-rep(2:5,each=3)
x

x <- c(2:5, seq(1,2, by = 0.2),rep(4:5, each = 3))
x

# try: 1:3 + rep(seq(from=0,by=10,to=30), each=3)
# try: 1:10 * c(-1,1)

# beware of infinite, nan and na
#v <- c(0, Inf, -Inf, NaN)
#is.finite(v)
#is.nan(v)
#is.na(v)

# combining vectors is easy
x <- 1:10
y <- 11:20
rbind(x, y)
cbind(x, y)

# subsetting is basically slicing
x <- c(5,9,2,14,-4)
x[3]  # index start from 1
x[c(2,3,5)]
x[3:length(x)]

# coercion
x <- c("1", "b", "3")
as.numeric(x)


# factors
#Factors are useful for storing categorical data.
# Creating a factor
colors <- factor(c("Red", "Blue", "Green", "Red", "Blue"))
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
x <- c(5, 2, 9, 1, 7)

# Get the maximum value
max(x)  # Output: 9

# Get the index of the maximum value
which.max(x)  # Output: 3 


# which
x <- c(TRUE, FALSE, TRUE, FALSE)
which(x)  # Output: 1 3

#match and %in%
x <- c("a", "b", "c", "a")
y <- c("b", "c", "d")
match(x, y)  # Output: NA 1 2 NA
#This function tells us which indexes of 
#a second vector match each of the entries 
#of a first vector.

x <- c("a", "b", "c", "a")
y <- c("b", "c", "d")
x %in% y  # Output: FALSE TRUE TRUE FALSE
#If rather than an index we want a logical 
#that tells us whether or not each element
#of a first vector is in a second, we can use 
#the function %in%. 



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
system.time(for (i in 1:1e6) i^2)

# vectorization way
system.time(seq_len(1e6)^2)

#SAPPLY (perform element-wise operations on any function)
x <- 1:10
sapply(x, sqrt)

