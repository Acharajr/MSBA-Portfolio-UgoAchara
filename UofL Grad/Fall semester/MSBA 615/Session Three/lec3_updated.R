
library(tidyverse)
library(dslabs)
library(ggrepel)

data(murders)
data(heights)
data(gapminder)



head(murders)

# Basic scatter + smooth
murders |>
    ggplot(aes(x = population/10^6, y = total)) +
    geom_point() +
    geom_smooth()

# Labels without global aes 
murders |>
    ggplot() +
    geom_point(aes(x = population/10^6, y = total)) +
    geom_text(aes(x = population/10^6, y = total, label = abb))

# Global aes to avoid redundancy
murders |>
    ggplot(aes(population/10^6, total)) +
    geom_point() +
    geom_text(aes(label = abb))

# Mapping vs setting color
murders |>
    ggplot(aes(population/10^6, total)) +
    geom_point(aes(color = region), size = 2) +
    geom_text(aes(label = abb), nudge_x = 1.5)

murders |>
    ggplot(aes(population/10^6, total)) +
    geom_point(color = "blue", size = 3)


# Building layers step-by-step


p0 <- murders |>
    ggplot(aes(population/10^6, total))

p1 <- p0 + geom_point(aes(color = region), size = 3)
p2 <- p1 + geom_text(aes(label = abb), nudge_x = 0.1)
p3 <- p2 + scale_x_log10() + scale_y_log10()

r <- murders |>
    summarize(rate = sum(total)/sum(population)*10^6) |>
    pull(rate)

p4 <- p3 + geom_abline(intercept = log10(r), lty = 2, color = "darkgrey")

p5 <- p4 + labs(
    title = "US Gun Murders in 2010",
    x = "Population in millions (log scale)",
    y = "Total murders (log scale)",
    color = "Region"
)

p5

# cleaned version with better labels
murders |>
    ggplot(aes(population/10^6, total)) +
    geom_abline(intercept = log10(r), lty = 5, color = "darkgrey") +
    geom_point(aes(color = region), size = 3) +
    geom_text_repel(aes(label = abb)) +
    scale_x_log10() +
    scale_y_log10() +
    labs(
        title = "US Gun Murders in 2010",
        x = "Population in millions (log scale)",
        y = "Total murders (log scale)",
        color = "Region"
    )


# 1D Plots: distributions – heights


head(heights)

# Histogram
heights |>
    filter(sex == "Female") |>
    ggplot(aes(height)) +
    geom_histogram(binwidth = 1, fill = "blue", col = "black")

# Density
heights |>
    filter(sex == "Female") |>
    ggplot(aes(height)) +
    geom_density(fill = "blue", alpha = 0.4)

# Boxplot by gender
heights |>
    ggplot(aes(sex, height)) +
    geom_boxplot()


# Bar plots: proportions – murders


murders |>
    ggplot(aes(y = region)) +
    geom_bar(color = "red")

tab <- murders |>
    count(region) |>
    mutate(proportion = n/sum(n))

tab |>
    ggplot(aes(region, proportion)) +
    geom_col()


# Faceting and time series using gapminder


head(gapminder)

# Single year scatter
gapminder |>
    filter(year == 1962) |>
    ggplot(aes(fertility, life_expectancy, color = continent)) +
    geom_point()

# Facet by year
gapminder |>
    filter(year %in% c(1962, 1992, 2012)) |>
    ggplot(aes(fertility, life_expectancy, color = continent)) +
    geom_point() +
    facet_grid(. ~ year)

# Time series for one country
gapminder |>
    filter(country == "United States") |>
    ggplot(aes(year, fertility)) +
    geom_line()

# Time series for two countries (fertility)
countries <- c("South Korea", "Germany")

gapminder |>
    filter(country %in% countries, !is.na(fertility)) |>
    ggplot(aes(year, fertility, color = country)) +
    geom_line()

# Time series for two countries (life expectancy)
countries <- c("Brazil", "Japan")

gapminder |>
    filter(country %in% countries, !is.na(life_expectancy)) |>
    ggplot(aes(year, life_expectancy, color = country)) +
    geom_line()


# Regression trend line: mtcars


ggplot(mtcars, aes(x = hp, y = mpg)) +
    geom_point(size = 3) +
    geom_smooth(method = "lm", color = "darkgrey") +
    scale_x_continuous(name = "Horsepower") +
    scale_y_continuous(name = "Miles per Gallon") +
    labs(title = "Horsepower vs. Miles per Gallon in mtcars")

x <- c(20090101, "2009-01-02", "2009 01 03", "2009-1-4")

ymd(x)

str_trim("  Hello World!  ")

sum(2,3) |> sum(20) |> sqrt() - 25|>sqrt()

