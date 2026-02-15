library(tidyverse)
library(dslabs)
library(ggrepel)


#EDA
#Retention date

#Dataset view
head(retentiondata_case)


#Summary Stats
summary(retentiondata_case)
glimpse(retentiondata_case)
sapply(retentiondata_case[, sapply(retentiondata_case, is.numeric)], sd)

#Missing and duplicated values
colSums(is.na(retentiondata_case))
sum(duplicated(retentiondata_case))

#Frequency table
table(retentiondata_case$left_flag)
prop.table(table(retentiondata_case$left_flag)) 

#datatypes
sapply(retentiondata_case, class)

# Meaningful patterns
ggplot(retentiondata_case, aes(y = age_years)) +
  geom_boxplot(outlier.colour = "red") +
  theme_minimal()

ggplot(retentiondata_case, aes(y = extra_data_fees_total, x = left_flag)) +
  geom_boxplot(outlier.colour = "red") +
  theme_minimal()


#average churn rate
library(dplyr)
library(purrr)

# Your dataset
df <- retentiondata_case

# Convert left_flag to numeric churn indicator
# yes = 1 (churned), no = 0 (not churned)
df <- df |>
  mutate(churn = ifelse(left_flag == "Yes", 1, 0))

# Identify categorical variables (factor or character)
cat_vars <- df %>%
  select(where(~ is.factor(.) || is.character(.))) %>%
  # Exclude the churn variable itself
  select(-left_flag, -acct_ref, - cust_ref) %>%
  names()

# Function to compute avg churn for one categorical variable
compute_churn <- function(var) { df |> 
    group_by(across(all_of(var))) |> 
    summarise(avg_churn = mean(churn, na.rm = TRUE)) |> 
    rename(category = all_of(var)) |> 
    mutate(variable = var) |> 
    relocate(variable, category) }


# Apply to all categorical variables and combine results
churn_summary <- map_df(cat_vars, compute_churn)

churn_summary

#Trend
ggplot(retentiondata_case, aes(x = monthly_fee)) +
  geom_histogram(fill = "steelblue", color = "white") +
  labs(
    title = "Distribution of Average GB Downloaded",
    x = "Average GB Downloaded",
    y = "Count of Customers"
  ) +
  theme_minimal()

ggplot(retentiondata_case, aes(x = monthly_fee)) +
  geom_histogram(aes(y = ..density..), binwidth = 5, fill = "skyblue", color = "white", alpha = 0.7) +
  geom_density(color = "red", size = 1.2) +
  labs(
    title = "Trend and Distribution of Monthly Fee",
    x = "Monthly Fee",
    y = "Density"
  ) +
  theme_minimal()

retentiondata_case |>
  mutate(
    left_flag_clean = trimws(tolower(left_flag)),
    churn = ifelse(left_flag_clean == "yes", 1, 0)
  ) |>
  group_by(churn) |>
  summarise(avg_monthly_fee = mean(monthly_fee, na.rm = TRUE))



#churn by recent offer
df |> 
  group_by(recent_offer) |> 
  summarise(churn_rate = mean(churn, na.rm = TRUE)) |> 
  ggplot(aes(x = recent_offer, y = churn_rate, fill = recent_offer)) + 
  geom_col() + scale_y_continuous(labels = scales::percent_format()) + 
  labs( title = "Churn Rate by Recent Offer", x = "Recent Offer", y = "Churn Rate (%)" ) + 
  theme_minimal() + 
  theme(legend.position = "none")

#churn rate for multiple categorical variables

df <- retentiondata_case |>
  mutate(
    left_flag_clean = trimws(tolower(left_flag)),
    churn = ifelse(left_flag_clean == "yes", 1, 0)
  )

cat_vars <- c("add_on_security", "add_on_backup",
              "add_on_protection")

df_long <- df |>
  pivot_longer(cols = all_of(cat_vars),
               names_to = "variable",
               values_to = "category")

churn_rates <- df_long |>
  group_by(variable, category) |>
  summarise(churn_rate = mean(churn, na.rm = TRUE))

ggplot(churn_rates, aes(x = category, y = churn_rate, fill = category)) +
  geom_col() +
  scale_y_continuous(labels = scales::percent_format()) +
  facet_wrap(~ variable, scales = "free_x") +
  labs(
    title = "Churn Rate Across Multiple Categorical Variables",
    x = "Category",
    y = "Churn Rate (%)"
  ) +
  theme_minimal() +
  theme(legend.position = "none")


#Relationships
#Churn by Internet plan
retentiondata_case |>
  ggplot(aes(x = internet_plan, fill = factor(left_flag))) +
  geom_bar(position = "fill") +
  scale_fill_manual(values = c("skyblue", "pink")) +
  theme_bw() +
  labs(title = "Churn by Internet Plan",
       x = "Internet Plan",
       y = "Proportion",
       fill = "Churn")

#Churn by dependents
retentiondata_case |>
  ggplot(aes(x = has_dependents, fill = factor(left_flag))) +
  geom_bar(position = "fill") +
  scale_fill_manual(values = c("skyblue", "pink")) +
  theme_bw() +
  labs(title = "Churn by whether Customer has Dependents or not",
       x = "Has Dependents",
       y = "Proportion",
       fill = "Churn")

#Churn by contract type
retentiondata_case |>
  ggplot(aes(x = contract_term, fill = factor(left_flag))) +
  geom_bar(position = "fill") +
  scale_fill_manual(values = c("skyblue", "pink")) +
  theme_bw() +
  labs(title = "Churn by Contract Type",
       x = "Contract Term",
       y = "Proportion",
       fill = "Churn")

#churn by monthly fee
retentiondata_case |>
  group_by(contract_term, left_flag) |>
  summarise(avg_monthly_fee = mean(monthly_fee, na.rm = TRUE), .groups = "drop") |>
  ggplot(aes(x = contract_term, y = avg_monthly_fee, fill = factor(left_flag))) +
  geom_col(position = "fill") +
  scale_fill_manual(values = c("skyblue", "pink")) +
  labs(
    title = "Customer Churn by Contract Term and Average Monthly Fee",
    x = "Contract Term",
    y = "Proportion",
    fill = "Churn"
  )

#churn by payment method
  retentiondata_case |>
    filter(contract_term == "Month-to-month") |>
    ggplot(aes(x = pay_method, fill = left_flag)) +
    geom_bar(position = "dodge") +
    labs(
      title = "Customer Churn for Month-to-Month Contracts",
      subtitle = "Grouped by payment method",
      x = "Payment Method",
      y = "Number of Customers",
      fill = "Churned (Left)"
    ) +
    theme_minimal() +
    scale_fill_brewer(palette = "Set1")

#Churn prop by internet Technology
retentiondata_case |>
  ggplot(aes(x = internet_tech, fill = factor(left_flag))) +
  geom_bar(position = "fill") +
  scale_fill_manual(values = c("skyblue", "pink")) +
  theme_bw() +
  labs(
    title = "Churn Proportion by Internet Technology",
    x = "Internet Technology",
    y = "Proportion",
    fill = "Churn"
  )
 #churn by internet tech and download speed
retentiondata_case |>
  ggplot(aes(x = internet_tech, y = avg_gb_download, fill = factor(left_flag))) +
  geom_boxplot() +
  theme_bw() +
  labs(
    title = "Average GB Download by Internet Tech and Churn",
    x = "Internet Technology",
    y = "Average GB Download",
    fill = "Churn (Left Flag)"
  )

retentiondata_case |>
  ggplot( aes(x = avg_gb_download, fill = factor(left_flag))) +
  geom_bar() +
  facet_wrap(~ internet_plan) +
  theme_bw() +
  labs(title = "Churn by internet tech faceted by internet plan")





