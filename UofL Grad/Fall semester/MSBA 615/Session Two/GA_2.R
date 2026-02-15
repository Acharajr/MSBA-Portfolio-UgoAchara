#Assignment 2
#Names: Ugochukwu Achara, Samuel Ibikunle, Thylia Watson

library(tidyverse)  
library(dslabs)   

#1.	In the `murders` dataset, add a new column named `rate_per_million`, 
#   which represents the murder rate per million people for each state. 
#   Display the first six rows of the updated dataset.
murders <- mutate(murders, rate_per_million = (total/population)*1000000)
head(murders)


#2.	Filter the `murders` dataset to show only states in the "West" region 
#   with a murder rate (`rate_per_million `) of 1 or higher. Display the results.
filter(murders, region == 'West', rate_per_million >= 1)


#3.	Create a new data frame that includes only the `state`, `rate`, and `rate_per_million` columns 
#   from the `murders` dataset (if required create a ‘rate’ column). 
#   Then, sort this data frame in descending order of murder rate.
murders_rate_by_state_df <- select(murders, 
                                   state, 
                                   rate = total/population, 
                                   rate_per_million) |> 
  arrange(desc(rate))
murders_rate_by_state_df

#4.	Calculate the total population and total number of murders for each region in the `murders` dataset. Display the resulting dataset.
tot_murders_by_region <- murders |> 
  group_by(region) |>
  summarize(tot_pop = sum(population), 
            tot_num = sum(total))
tot_murders_by_region

#5. Add a new column to the `murders` dataset called `size_category` that classifies each state based on its population:
#- "Small" if population is less than 2 million
#- "Medium" if population is between 2 and 10 million
#- "Large" if population is greater than 10 million  

#Then, count how many states fall into each `size_category`.

murders <- murders |> mutate(size_category = case_when(
  population < 2000000 ~ "Small",
  population > 2000000 & population < 10000000  ~ "Medium",
  population > 10000000 ~ "Large"))

murders |> count(size_category)