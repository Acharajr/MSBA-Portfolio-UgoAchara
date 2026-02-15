library(tidyverse)   

#  Custom dataset
set.seed(42)
store_df <- tibble(
  store_id = 1:20,
  region   = rep(c("North","South","East","West"), each = 5),
  category = sample(c("A","B","C"), size = 20, replace = TRUE),
  units    = sample(50:300, size = 20, replace = TRUE),
  price    = round(runif(20, min = 5, max = 20), 2),
  online   = sample(c(TRUE, FALSE), size = 20, replace = TRUE, prob = c(0.6, 0.4))
) |>
  mutate(revenue = units * price)

store_df

# Question
#1)	Create a new dataframe by Keeping only `store_id`, `region`, and `revenue`.
newstore_df1 <- select(store_df, store_id, region, revenue)
newstore_df1

#2)	Filter rows where `region` is `"South"` and `online` is `TRUE`.
fil <- filter(store_df, region == "South",online == "TRUE")
fil
#2 using piping 
filstore_df <- store_df |> filter (region == "South", online == "TRUE") 
filstore_df

#3)	Add `avg_price = revenue / units`. Show the first 6 rows only.
newstore_df2 <- mutate(store_df, avg_price = revenue / units)
head(store_df2)

#4)	Arrange data by `region` ascending and `revenue` descending.
region_asc <- store_df |> arrange(region)
region_asc

revenue_desc <- store_df |> arrange(desc(revenue))
revenue_desc

#5)	Compute the overall average of `revenue`.
avg_revenue <- store_df |> summarize(average = mean(revenue))
avg_revenue

#6)	Compute total revenue and average units per `region`. Sort by total revenue descending.
var6 <- store_df |> 
  group_by(region) |> 
  summarize(total_rev = sum(revenue), avg_units = mean(units)) |> 
  arrange(desc(total_rev))
var6

#7 From `store_df`, 
# return a tibble of West region online rows with columns: `store_id`, `category`, and a new `rev_per_unit = revenue / units`, 
#sorted by `rev_per_unit` descending.

store_df |> filter(region == "West", online == "TRUE") |>
  mutate(rev_per_unit = revenue / units) |> 
  select(store_id, category, rev_per_unit) |>
  arrange(desc(rev_per_unit))

