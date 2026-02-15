library(tidyverse)
library(dslabs)
library(ggrepel)

#Ensure mpg is available from ggplot2
data(mpg, package = "ggplot2")
data(gapminder)
data(heights)
data(mtcars)
#theme_set(theme_minimal(base_size = 12)) # for elegant plots

#1) Create a scatterplot of engine size (displ) vs highway mileage (hwy). Map
#class to color. Add a title and axis labels. [2 points]
ggplot(mpg, aes(x = displ,y = hwy, color = class)) +
  geom_point() +
  labs(
    title = "Engine Size vs Highway Mileage",
    x = "Engine Size",
    y = "Highway Mileage",
  )
  

#2) Make a bar chart of count of cars by class. Rotate x-axis labels if needed. [2 points]
ggplot(mpg, aes(x=class)) +
  geom_bar(fill = "Navy blue") +
  labs(
  title = "Cars by Class",
  x = "Class",
  y = "count"
  ) 
  

#3) Use the heights dataset Plot the distribution of female heights: [2points]

#a)Histogram with binwidth = 1 
heights |>
  filter(sex == "Female") |>
  ggplot(aes(x = height)) +
  geom_histogram(binwidth = 1, fill = "pink", col = "brown")

# b) Density plot with geom_density()
heights |>
  filter(sex == "Female") |>
  ggplot(aes(x = height)) +
  geom_density(fill = "purple", alpha = 0.4)


#4) Compare life expectancy trends over time for two countries (Brazil, Japan)
#in the gapminder dataset using ggplot2? [2 points]

gapminder |>
  filter(country %in% c("Brazil", "Japan"), !is.na(life_expectancy)) |>
  ggplot(aes(x = year,y = life_expectancy, fill = country)) +
  geom_area() +
  labs(
    title = "Life expectancy by Country",
    x = "Year",
    y = "Life Expectancy"
  )

#5) Visualize the relationship between horsepower and miles per gallon in the
#mtcars dataset using ggplot2, with a regression line? [2 points]

mtcars |>
  ggplot(aes(x = mpg, y = hp)) +
  geom_point(color = "navyblue", size = 2) + 
  geom_smooth(method = "lm") +
  labs(
    title = "Horse Power vs Miles Per Gallon",
    x = "Miles Per Gallon",
    y = "Horse Power"
  )

