library(tidyverse)
library(dslabs)
library(ggrepel)

#Preview 
head(HeavenlyChocolatesInClass)

# Summary of all variables
summary(HeavenlyChocolatesInClass)

#standard deviation for numeric vars
sapply(HeavenlyChocolatesInClass[, sapply(HeavenlyChocolatesInClass, is.numeric)], sd) 

# Check for missing values and duplicated values
colSums(is.na(HeavenlyChocolatesInClass)) 

sum(duplicated(HeavenlyChocolatesInClass))

#Step 1
#Frequency Tables for categorical tables
#Count
table(HeavenlyChocolatesInClass$Day)
table(HeavenlyChocolatesInClass$Browser) 

#Probability
prop.table(table(HeavenlyChocolatesInClass$Day))

prop.table(table(HeavenlyChocolatesInClass$Browser))
             

# Frequency Histogram
HeavenlyChocolatesInClass |>
  ggplot(aes(x = `Pages Viewed`)) +
  geom_histogram(binwidth = 0.5, fill = "skyblue", color = "black") +
  labs(title = "Histogram (Frequency)") +
  theme_minimal()

#Boxplot
HeavenlyChocolatesInClass |>
  ggplot(aes(y = `Time`)) +
  geom_boxplot(outlier.colour = "red") +
  theme_minimal()

#Step 2
#Relationship plot
HeavenlyChocolatesInClass |>
  ggplot(aes(x = Time, y = `Amount Spent`, color = Browser, size = Browser)) +
  geom_point() +
  theme_minimal()

HeavenlyChocolatesInClass |>
  ggplot(aes(x = `Pages Viewed`, y = `Amount Spent`, color = Browser)) +
  geom_point() +
  theme_minimal()

HeavenlyChocolatesInClass |>
  ggplot(aes(x = Time, y = `Amount Spent`, color = Browser, size = `Pages Viewed`)) +
  geom_point() +
  theme_minimal()

#Step 3
HeavenlyChocolatesInClass |>
  ggplot( aes(x = Day, y = `Amount Spent`)) +
  geom_boxplot() +
  facet_wrap(~Browser) +
  theme_bw() +
  labs(title = "Amount Spent by Day (faceted by Browser)")
# Amount Spent is highest on Fridays and Mondays regardless of browser. 
# However, there are more customers that shop using chrome on average compared to all other browsers
# Target marketing efforts to chrome users compared to any other browsers. (If the funds available allow then Firefox users as well)


