# Each Question Carries 2 Points Each
# Group Name: Ugochukwu Achara, Samuel Ibikunle, Thylia Watson

# Question 1:  
# Given the following vector:
values <- c(-3, 7, 2, -5, 10, 0, -8)
#1.	Find the sum of the squared differences from the mean values.
 sum((values - mean(values))^2)
 values
 
#2.	Create a sequence that starts at 1, ends at 20, and has an increment of 3.
 vec1 <- seq(from = 1, to = 20, by = 3)
 vec1
#3.     Using the sequence from part (2), calculate the sum of all values that are greater than 10.
 # vec1 = 1  4  7 10 13 16 19
 vec1sum <- sum(vec1[vec1 > 10])
 vec1sum
 
#Question 2:
#Consider the vector data that contains various special values:
data <- c(4, NaN, 7, Inf, -Inf, NA, 10, -2, NaN)
 
#1.	Identify and return all elements that are finite in data.
fin_values <- is.finite(data)
fin_values

#2.	Replace all NaN values in data with 0 and display the modified vector.
is.nan(data)
data[is.nan(data)] <- 0
data

#3.	Check if there are any NA values in data. If any exist, replace them with the mean of the finite values in data.
is.na(data)
data[is.na(data)] <- mean(is.finite(data))
data

#Question 3:
#Consider the following vector representing satisfaction ratings for a product survey:
satisfaction <- c("High", "Medium", "Low", "High", "Low", "Medium", "High")

#1.	Convert satisfaction into a factor with ordered levels: Low, Medium, High.
satisfaction <- factor(c("High", "Medium", "Low", "High", "Low", "Medium", "High"),
                       levels = c("Low", "Medium", "High"),
                       ordered = TRUE)

#2.	Count how many respondents rated their satisfaction as "High".
high_satisfaction <- sum(satisfaction == "High")
high_satisfaction

#3.	Display the levels of the satisfaction factor in order.
levels(satisfaction)
print(satisfaction)

#Question 4:
#Given the vector scores representing students' scores:
scores <- c(85, 92, 78, 60, 55, 88, 72)

#1.	Create a new vector pass_fail, where a score of 70 or above is labeled "Pass" and below 70 is labeled "Fail".
pass_fail <- ifelse(scores >= 70,"Pass", "Fail")
pass_fail

#2.	Create a custom function grade_assign() that assigns grades based on the following criteria:
#o	90 and above: "A"
#o	80-89: "B"
#o	70-79: "C"
#o	Below 70: "D"
grade_assign <- function(score) { 
        if (score >= 90) return("A") 
        else if (score >= 80) return("B") 
        else if (score >= 70) return("C") 
        else return("D")
        }

#3.	Apply the grade_assign() function to the scores vector to categorize each student’s grade.
grades <- sapply(scores, grade_assign)
grades

#Question 5 :
#Suppose you have the following vectors representing product categories and sales numbers:
products <- c("Laptop", "Tablet", "Smartphone", "Desktop", "Laptop", "Smartphone", "Accessory")
sales <- c(500, 300, 700, 200, 400, 650, 150)


#1.	Find the Best-Selling Product: Identify the product category with the highest sales.
#2.	Find Sales of a Specific Product: Write a function find_sales(product_name) that takes a product category (e.g., "Laptop") as input and returns its total sales.
find_sales <- function(product_name){
        sum(sales[products == product_name])
}

find_sales("Laptop")  
#3.	Compute Basic Sales Statistics: 
# Calculate and return the minimum, maximum, and average sales values.
# Test your function with find_sales("Laptop").
min_sales <- max(-sales)
max_sales <- max(sales)
avg_sales <- mean(sales)

min_sales  
max_sales  
avg_sales  
