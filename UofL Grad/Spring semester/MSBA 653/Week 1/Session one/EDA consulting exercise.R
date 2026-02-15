library(tidyverse)
library(dslabs)
library(ggrepel)


head(HeavenlyChocolatesInClass)

summary(HeavenlyChocolatesInClass)

HeavenlyChocolatesInClass |>
  ggplot(aes(x = Time)) +
  geom_histogram(color = "navyblue", size = 2) + 
  labs(
    title = "Heavenly Chocolates Amount Spent",
    x = "Time spent"
  )


HeavenlyChocolatesInClass |>
  ggplot(aes(y = `Amount Spent`, x = Time)) +
  geom_point(size = 2) +
  geom_smooth(method = "lm") +
  labs(
  title = "Heavenly Chocolates Amount Spent v. Time",
  y = "Amount spent",
  x = "Time"
)

HeavenlyChocolatesInClass |>
ggplot( aes(x = Day, y = `Amount Spent`)) +
  geom_boxplot() +
  facet_wrap(~Browser) +
  theme_bw() +
  labs(title = "Amount Spent by Day (faceted by Browser)")



