# Practice 1
#Ugochukwu Achara
#1 Create a numeric vector named temps with the following values: c(72, 75, 68, 80, 78, 65, 85). 
temps <- c(72, 75, 68, 80, 78, 65, 85)
# Calculate the average temperature. 
avg_temps <- mean(temps)
# Find the number of days where the temperature was above the average.
 temp_above_avg <- temps[temps>avg_temps]
 temp_above_avg 


#2 Generate a sequence of numbers from 5 to 50 with a step of 5. 
 seq(from = 5, to = 50, by = 5)
#  Store it in a variable called multiples.
 multiples <-  seq(from = 5, to = 50, by = 5)
# Using logical subsetting, extract and display only the numbers in multiples that are greater than 25.
 multiples_greater_than_25 <- multiples[multiples > 25]
 multiples_greater_than_25
 
#3 Create a vector mixed_data with the values c(10, NA, "25", 30, "forty"). 
 mixed_data <- c(10, NA, "25", 30, "forty")
#  Determine which elements in mixed_data are not numeric. 
 as.numeric(mixed_data)
#. Use the is.na() function to identify any missing values. What happens when you try to calculate the mean of this vector?
 is.na(mixed_data)
# What happens when you try to calculate the mean of this vector?
 mean(mixed_data)
 # I cannot calculate the mean because the vector is not entirely numeric

 
#4 Write a function called check_parity() that takes a single number as input. 
 #  The function should return "Even" if the number is even and "Odd" if the number is odd. 
 #  Test your function with the numbers 12 and 7.
 check_parity <- function(num) {
   if (num %% 2 == 0) 
     return("Even")
   else 
     return("Odd")
 }

check_parity(12)
check_parity(7)

#5 Convert `c("1", "b", "3")` to numeric. Explain the output.
data <- c("1", "b", "3")
as.numeric(data)

# R coerce a vector with different data types to the most flexible type and hierarchy is: character > numeric > logical

#6 
x <- c("a","b","c","a")
y <- c("b","c","d")
# (i) Return a logical vector showing which elements of x appear in y. 
x %in% y 
# (ii) Return the index positions of x’s elements in y.
match(x,y)

#7 Create an ordered factor for grades: 
#`c("B","A-","A","A-","B")` with the level order B < A-< A+. 
# Show the levels and print it.

grades <- factor(c("B","A-","A","A-","B"),
                 levels = c("B", "A-", "A"),
                 ordered = T)
levels(grades)
print(grades)


#8 Given the weekly sales data 
sales <- c(45, 52, 58, 60, 63, 70) 
#use vectorization to calculate the percentage change in sales from one week to the next using 
percentage_change <- (sales[-1] - sales[-length(sales)]) / sales[-length(sales)] * 100
#which automatically computes week-to-week differences without loops. 
#Then, apply sapply() to classify each week’s sales into categories —"High" if sales > 60, "Medium" if between 50 and 60, and "Low" if below 50.




