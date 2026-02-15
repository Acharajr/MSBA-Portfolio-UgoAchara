library(tidyverse)



stores <- tribble(
  
  ~store, ~region, ~sales, ~customers,
  
  "A",  "North",  120,    30,
  
  "B",  "North",  150,    35,
  
  "C",  "South",  90,    22,
  
  "D",  "South",  110,    28,
  
  "E",  "East",   80,    20,
  
  "F",  "East",  130,    32,
  
  "G",  "West",   70,    18,
  
  "H",  "West",   95,    25,
  
  "I",  "North",  160,    40,
  
  "J",  "South",  100,    24
  
)



stores

#Answer the following questions

#1) Visualize the relationship between customers and sales.

ggplot(stores, aes(x = customers, y = sales)) +
  geom_point() + 
  labs(
    title = "Sales per Customer",
    x = "Customer",
    y = "Sales"
  )



#2) To the visualization in question 1, add blue color to all data points. check how it is different from mapping the region column to color.

#mapping color to region
ggplot(stores, aes(x = customers, y = sales, color = region)) +
  geom_point() +
  labs(
    title = "Sales per Customer in Each Region",
    x = "Customer",
    y = "Sales"
  )

#Mapping color to all data points 
ggplot(stores, aes(x = customers, y = sales,)) +
  geom_point(color = "blue") +
  labs(
    title = "Sales per Customer",
    x = "Customer",
    y = "Sales"
  )

#3) Visualize the store counts by region.
ggplot(stores, aes(x = region, fill = region)) +
  geom_bar() +
  labs(
    title = "Stores per Region",
    x = "Region",
    y = "Store count"
  )



#4) Visualize the sales distribution by region using box plot.
ggplot(stores, aes(x = region, y = sales)) +
  geom_boxplot(fill = 'grey') +
  labs(
    title = "Sales distribution by Region",
    x = "Region",
    y = "Sales"
  )

