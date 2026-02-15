# tidying data
# tidy data format
#install.packages(tidyverse)
#install.packages(dslabs)
# Load packages
library(tidyverse)   # includes dplyr, ggplot2, tidyr, purrr, readr, etc.
library(dslabs)      # contains example datasets like murders, heights, gapminder

########################################################
#  Exploring the murders dataset
########################################################
#Question, how do I know which data sets are within a program like dslabs?

# murders is a tibble (data frame) with US state murder data
class(murders)

# First six rows (preview)
head(murders)

# Basic summary statistics of each column
summary(murders)

# Structure: names, types, and examples of values
str(murders)

# A tibble is a modern data frame. It prints cleaner, handles types more safely, 
# never converts strings to factors, and works consistently with tidyverse tools.
glimpse(murders)

#Good practice to create copy of the dateset. Create dataframe from the dataset
murders_copy <- murders |>as.data.frame()


# how to access each column (data analysts job)
# To find column names of trhe dataset, use name(dataset)
names(murders)

# To access each column in R, use dataset name $ dollar sign and column name
murders$population

#murders$rate

murders$abb

murders$total


class(names(murders))

#Bottom 6 part of the dataset with tail just like you use head for the top 6 
tail(murders)




# dplyr 
# data refining

#mutate, mutate() adds new columns or modifies existing ones.
# mutate(dataframe, what you want to do and on which column you want to do it)
# Keep the column name if you want to change something within the column 
# assign new name if you want to add new column to the dataframe
#whatever operation is performed on every element within the assigned column
# add new column 
murders <- mutate(murders, crimerate = total/(population))
head(murders)
# check column names are directly used without ""
str(murders)



# transform
# You can also transform existing columns (creating temporary tibbles).
# Note: below we do not overwrite murders, just show examples.

# Don't forget to store in a new variable after you use mutate
newmur <- mutate(murders, population = log2(population))
head(newmur)

# can do it across multiple columns
# create vector of the column names then apply operator
mutate(murders, across(c(population, total), log10))
head(murders)
mutate(murders, across(where(is.numeric), log2))
mutate(murders, across(where(is.character), tolower))



# choose your rows and columns
# filter is for choosing the rows you want and select is for choosing the columns you want

# subsetting rows with filter
# data frame as the first argument and then a conditional statement as the second. 

filter(murders, abb == "KY")
filter(murders, crimerate <= 0.000005)

head(filter(murders, region == "South"))

# subsetting columns with select

newdf1<-select(murders,state,abb)
newdf1
new_dataframe <- select(murders, state, region, crimerate)
head(new_dataframe)
glimpse(new_dataframe)
glimpse(filter(new_dataframe, crimerate <= 0.71))

# You can use both select filter but do select first before filter as this is best practices

# piping in R
#In R we can perform a series of operations, for example select and then filter, by sending the results of one function to another using what is called the pipe operator: %>% or |>.
# %>%
var1<-  murders |> select(state, region, crimerate) |> filter(crimerate <= 0.71)
var1
#filter(select(murders, state, region, crimerate), crimerate <= 0.71)


# Piping breaks the operation into steps which makes data easier to work with
# this makes debugging easier as you can simply go through each operator to locate the one causing issues 
#the pipe sends the result of the left side of the pipe to be the first argument of the function on the right side of the pipe. 

sqrt(25)

25 |> sqrt() |> sum(13) 


64 |> sqrt() 
# left side object will be considered as the 1st argument of the function on the right side of the pipe
sqrt(64)|> sum(90) 


sum(sqrt(64),90)
98 |> sum(-20)

sum(98,-20)
sum(8,90)

5 |> sqrt()

16 |> sqrt()

#murders |> select(state, region, crimerate)|> filter(crimerate < 0.000005)

x<-select(murders,state, region, crimerate)
filter(x,crimerate<0.000005)

murders |> select(state, region, crimerate) |> filter(crimerate < 0.000005)

filter(select(murders,state, region, crimerate),crimerate < 0.000005)

# Summarizing data
head(heights)

glimpse(heights)

x1<-filter(heights,sex=="Female")
names(x1)
mean(x1$height)

heights |> filter(sex=="Female") |> summarize(average = mean(height))


glimpse(x1)

summary(x1)

heights |> 
    filter(sex == "Female") |>
    summarize(average = mean(height))


# groupby and summarize
var1<-heights |> 
    group_by(sex) |>
    summarize(average = mean(height))
var1
class(var1)

# sorting
# Sample dataset
df <- data.frame(
    Name = c("Alice", "Bob", "Charlie", "David"),
    Age = c(25, 30, 22, 28),
    Score = c(88, 75, 90, 85)
)

# Arrange by Age in ascending order
df_sorted <- df |> arrange(Age)
print(df_sorted)

# Arrange by Score in descending order
df_sorted_desc <- df |> arrange(desc(Age))
print(df_sorted_desc)

murders |> 
    arrange(region, crimerate) |> 
    head()

# tibbles
murders |> group_by(region) |>summarize(average = mean(crimerate)) |>arrange(average)
murders |> group_by(region) |> class()

5 |> sum(4)

# purrr package and map function: purrr::map() vs sapply() (just a taste)

compute_s_n <- function(n) {
    sum(1:n)
}
n <- 1:25
s_n <- sapply(n, compute_s_n)
print(s_n)

library(purrr)
s_n <- map(n, compute_s_n)
class(s_n)
print(s_n)

head(murders)
# case when
#case_when(): multi-condition if/else for categories

murders |> 
    mutate(group = case_when(
        abb %in% c("ME", "NH", "VT", "MA", "RI", "CT") ~ "New England",
        abb %in% c("WA", "OR", "CA") ~ "West Coast",
        region == "South" ~ "South",
        TRUE ~ "Other")) |>
    group_by(group) |>
    summarize(crimerate = sum(total)/sum(population))


# Sample dataset
df2 <- data.frame(
    Name = c("Alice", "Bob", "Charlie", "Alice", "Bob", "Charlie", "Alice"),
    Category = c("A", "B", "A", "A", "B", "B", "A")
)
head(df2)
# Count occurrences of each Name
df_count <- df2 |> count(Name)
print(df_count)

# Count occurrences of each Category
df_count_category <- df2 |> count(Category)
print(df_count_category)



# reshaping with pivot_longer / pivot_wider
########################################################

# Wide format: each row is a student, columns are subject scores
scores_wide <- tibble(
    student = c("A", "B", "C"),
    math    = c(80, 90, 75),
    english = c(85, 88, 92)
)
scores_wide

# pivot_longer(): "wide -> long" (subject variable in one column)
scores_long <- scores_wide |>
    pivot_longer(
        cols = c(math, english),        # columns to turn into rows
        names_to = "subject",           # name for new "subject" column
        values_to = "score"             # name for new "score" column
    )
scores_long

# Now each row is (student, subject, score).
# This is "tidy" for many modeling and plotting tasks.

# pivot_wider(): "long -> wide" (go back to original shape)
scores_wide_again <- scores_long |>
    pivot_wider(
        names_from = subject,           # column that will become new column names
        values_from = score             # column that contains values
    )
scores_wide_again
