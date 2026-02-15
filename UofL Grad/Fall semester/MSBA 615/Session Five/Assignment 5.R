library(tidyverse)  # dplyr + ggplot2 + readr

library(lubridate)  # dates

getwd()
setwd("~/Library/CloudStorage/OneDrive-NorthwesternUniversity/Grad School/UofL Grad/MSBA 615/Session Five/")

sales <- read_csv("sales_data_sample.csv", show_col_types = FALSE)

#1) Get an overview of the sales dataset (number of rows, columns, types of the columns) and print the 1st 6 rows. [1 point]
glimpse(sales)
head(sales)


#2) Check for missing values and duplicate rows. Comment briefly on whether the dataset looks clean or needs attention. [2 point]
#cheack for missing values
print(colSums(is.na(sales)))
# Check for duplicates.
print(sum(duplicated(sales)))

#This is clean data set with little attention needed. 
#The na values are in the columns that one would expect like the Address 2 column, state and territory. These are columns that vary depending on where the customer is based. 

#3) Create a new separate dataset to keep only orders from USA belonging to Classic Cars, and select only the most relevant columns like   ORDERNUMBER, PRODUCTLINE, COUNTRY, SALES. Print the 1st 6 rows of this dataset. [2 points]
USA_orders <- sales |> 
  select(ORDERNUMBER, PRODUCTLINE, COUNTRY, SALES) |>
  filter(PRODUCTLINE == "Classic Cars",COUNTRY == "USA") 
  

head(USA_orders)

#4) Create a new variable that measures revenue per unit (SALES divided by quantity ordered). This should be reflected in the original sales dataset. [2 points]
sales <- sales |> mutate(REVENUE_PER_UNIT = SALES/QUANTITYORDERED)
head(sales)

#5) Using sales amount, create three order categories: High, Medium, and Low (SALES > 4000 ~ "High", SALES > 2000 ~ "Medium"). Create a new group summary which tells total sales for each category. Then use a bar plot to present your findings. [3 points]
sales <- sales |>
  mutate(sales_category = case_when(
    SALES > 4000 ~ "High",
    SALES > 2000 ~ "Medium",
    TRUE ~ "Low"
  )) 

group_summary <- sales |>
group_by(sales_category) |>
summarise(TotalSales = sum(SALES)) 

group_summary |> ggplot(aes(x = sales_category, y = TotalSales)) +
  geom_bar(color = "tomato", stat = "identity", fill = "purple") +
  labs(title = "Total Sales by Order Category",
       x = "Sales Category",
       y = "Total Sales") 

head(sales)
#6) Compute total sales for each product line and store it in a new dataframe. Comment, Which product line has the highest total sales? Visualize it with an appropriate bar plot. [3 points]
Total_sales_per_product_line <- sales |>
  select(PRODUCTLINE) |>
  

#7) Compute total sales by country and store it in a new dataframe. Comment the top three countries by sales. Use a bar plot to show your findings. [3 points]

#8) Calculate total sales for each month across all years (Hint: group with month id and year id). Visualize the trend with appropriate plot type. Comment which months show consistently higher sales across different years? [4 points]


  
sales_by_MY <- sales %>%
  group_by(MONTH_ID, YEAR_ID) %>%
  summarise(TotalSales = sum(SALES, na.rm = TRUE))

  
  