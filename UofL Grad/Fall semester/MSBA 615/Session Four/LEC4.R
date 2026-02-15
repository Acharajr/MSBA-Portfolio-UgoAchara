library(tidyverse) 
library(dslabs)

library(readxl)

library(readr)
# read_csv is in readr
murders <- read_csv("C:/Users/mmray/OneDrive/Desktop/MSBA 615/murders.csv")
View(murders) # read_csv returns a tibble


var1<-read_excel(file.choose())
head(var1)


# import and store the dataset 
# read.csv is base r, returns a dataframe
data1 <- read.csv(file.choose(), header=T)

  # display the data
data1


# import and store the dataset in data2
data2 <- read.table(file.choose(), header=T) #more generic, base r

# display data
data2

library(readxl)

gfg_data=read_excel(file.choose())

gfg_data


# date time

str(polls_us_election_2016)
glimpse(polls_us_election_2016)
head(polls_us_election_2016)

polls_us_election_2016$startdate |> head()

class(polls_us_election_2016$startdate)

as.numeric(polls_us_election_2016$startdate) |> head()
#Dates in R are stored as the number of days since 1970-01-01.
as.numeric(as.Date("1970-01-02"))

# ggplot is aware of this format but the labels are string
polls_us_election_2016 |> filter(pollster == "Ipsos" & state == "U.S.") |>
    ggplot(aes(startdate, rawpoll_trump)) +
    geom_line()

# take a random sample
set.seed(2002)
dates <- sample(polls_us_election_2016$startdate, 10) |> sort()
dates

month(dates)
month(dates, label = TRUE)
day(dates)
quarter(dates)
tibble(date = dates, month = month(dates), day = day(dates), year = year(dates))


library(lubridate)
# Functions are ymd, mdy and dmy
# ymd assumes the dates are in the format YYYY-MM-DD and tries to parse as well as possible.

x <- c(20090101, "2009-01-02", "2009 01 03", "2009-1-4",
       "2009-1, 5", "Created on 2009 1 6", "200901 !!! 07")
x
class(x)
y<-ymd(x)
class(y)
y
#be careful
x1 <- "09/01/02"
# 2009-01-02?
# Sept 1, 2002?
# Jan 9, 2002?
c(ymd(x),mdy(x),dmy(x))


now() |> hour()




# make_date()

# Create a date from its components
make_date(year = 2023, month = 12, day = 2)


# Create a date from a character string
make_date(2023, "December", 2)




# Round a date to the nearest month
date <- ymd("2023-12-17")
round_date(date, unit = "month")# Round a date to the nearest year
round_date(date, unit = "year")



# Calculate the difference between two dates
date1 <- ymd("2023-12-02")
date2 <- ymd("2025-01-15")

# Calculate the difference in days
date2 - date1


# Calculate the difference in half of months
interval(date1, date2) / days(15)

interval(date1, date2) / months(4)


interval(date1, date2) / years(1)
# Strings

library(stringr)

# combine srings
str_c("Mr.", "John", "Doe", sep = "")

strings <- c("apple", "banana", "pear", "apple pie")

# Detect strings containing "apple"
str_detect(strings, "apple")


str_detect(strings, "^A")     # starts with A
str_detect(strings, "ing$")   # ends with ing

# Detect strings containing "a" or "e"
str_detect(strings, "[a-e]")


strings <- c("apple", "banana", "pear", "apple pie")

# Replace the first "a" with an "A"
str_replace(strings, "a", "A")


# Replace all "a" with an "A"
str_replace_all(strings, "a", "A")


strings <- c("apple,ba nana,pear", "apple,p ie")

# Split the strings by commas
str_split(strings, ",")


strings <- c("  apple  ", "banana ", " pear")

# Trim whitespace from the strings
str_trim(strings)






