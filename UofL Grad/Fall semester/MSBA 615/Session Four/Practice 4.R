#Question 1 

#You are analyzing a dataset of employee details. The dataset contains a column joining_date with the joining dates of employees.

employee_data <- tibble(
  employee_id = c(1, 2, 3, 4, 5),
  joining_date = ymd(c("2021-04-15", "2019-06-20", "2020-11-10", "2023-02-05", "2018-08-30"))
)

#1.    Create a new column rounded_month that rounds the joining_date to the nearest month.
employee_data<-employee_data |> mutate(employee_data, 
                        rounded_month = round_date(joining_date, unit = "month"))

#2.    Create another column rounded_year that rounds the joining_date to the nearest year.
employee_data<- employee_data |> mutate(employee_data, 
                        rounded_year = round_date(joining_date, unit = "year"))
head(employee_data)

#Question 2 
#You are working with a dataset of product launches. 
#The dataset contains columns launch_date and current_date. 
#Calculate the time differences.

product_data <- tibble(
  product_id = c("A1", "B2", "C3", "D4", "E5"),
  launch_date = ymd(c("2022-01-10", "2020-03-15", "2021-07-25", "2023-01-05", "2019-11-20")),
  current_date = ymd("2025-04-16") # Assume today's date
  
)

#1.    Calculate the difference in months and years between launch_date and current_date.
#2.    Add two new columns difference_in_months, years_since_launch .
product_data <- product_data |> 
  mutate(product_data, Diff_in_months = interval(launch_date,current_date)/ months(6)) |>
  mutate(product_data, years_since_launch = interval(launch_date,current_date)/ years(1))
  
product_data


#Question 3 
#You have a dataset of customer feedback. It contains a column feedback with customer comments.

feedback_data <- tibble(
  customer_id = c(101, 102, 103, 104, 105),
  feedback = c("Amazing service", "great product", "Slow delivery", "Excellent support", "Not worth the price")
)

#1.    Detect which feedback contains the word "great". Create a new column for this.
feedback_data <- feedback_data |> mutate(feedback_data, has_great = str_detect(feedback,"great"))
feedback_data 

#2.    Create a new column feedback_uppercase that converts all occurrences of the word "great" (case insensitive) to uppercase.
feedback_data <- feedback_data |> mutate(feedback_data, feedback_uppercase = str_replace_all(feedback,"great", "GREAT"))
feedback_data
