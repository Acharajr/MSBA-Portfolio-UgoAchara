
library(tidyverse)
library(dslabs)
library(stringr)


glimpse(gapminder)
summary(gapminder)
head(gapminder)

# Goal of the EDA
# Explore how fertility, population, and time affect life expectancy
# across continents. 
# Hypothesis: As fertility decreases and GDP increases, life expectancy improves.

# Check for NAs. Even if 0, the next step is good practice.
print(colSums(is.na(gapminder)))

# Check for duplicates.
print(sum(duplicated(gapminder)))


# We impute missing values for life_exp, pop, and fertility
# using the mean of their respective continent.
gapminder <- gapminder |>
    group_by(continent) |>
    mutate(
        # Impute life_exp
        life_expectancy = ifelse(          
            is.na(life_expectancy),        
            mean(life_expectancy, na.rm = TRUE),
            life_expectancy
        ),
        # Impute population
        population = ifelse(             
            is.na(population),            
            mean(population, na.rm = TRUE),
            population
        ),
        # Impute fertility
        fertility = ifelse(
            is.na(fertility),
            mean(fertility, na.rm = TRUE),
            fertility
        )
    ) |>
    ungroup() # remove the grouping

# Re-check missing values. Should all be 0 now.
print(colSums(is.na(gapminder)))


gapminder <- gapminder |>
    distinct()


# In a real project, you'd do this to clean messy text.
gapminder <- gapminder |>
    mutate(
        country_upper = toupper(country),                 # make ALL CAPS
        country_snake = str_replace_all(country, " ", "_"), # replace spaces with _
        country_abbr  = str_sub(country, 1, 3)            # first 3 letters
    )

glimpse(gapminder)
# Show a few rows to see the result
gapminder |>
    select(country, country_upper, country_snake, country_abbr) |>
    head() |>
    print()



# We convert types and create a 'pop_millions' feature.

gapminder <- gapminder |>
    mutate(
        country = as.character(country),  # treat country as text
        continent = as.factor(continent), # treat continent as factor
        year = as.integer(year)           # year should be integer
    ) |>
    mutate(
        pop_millions = population / 1e6          # population in millions (easier scale)
    )

# Check structure again. 
# and the new string columns.
glimpse(gapminder)

# VISUALIZE OUTLIERS: BOXPLOT BY CONTINENT 
# We create this plot before removing outliers to see them.
box_plot <- gapminder |>
    ggplot(aes(x = continent, y = life_expectancy, fill = continent)) +
    geom_boxplot() +
    labs(
        title = "Life Expectancy by Continent (Before Outlier Removal)",
        x = "Continent",
        y = "Life Expectancy (years)"
    ) +
    theme(legend.position = "none")
print(box_plot)


# DETECT AND REMOVE OUTLIERS (LIFE EXP) 
# Now that we've seen them, we remove outliers using the IQR method.
gapminder <- gapminder |>
    group_by(continent) |>
    mutate(
        Q1 = quantile(life_expectancy, 0.25, na.rm = TRUE),
        Q3 = quantile(life_expectancy, 0.75, na.rm = TRUE),
        IQR = Q3 - Q1,
        lower_bound = Q1 - 1.5 * IQR,
        upper_bound = Q3 + 1.5 * IQR
    ) |>
    filter(
        life_expectancy >= lower_bound,
        life_expectancy <= upper_bound
    ) |>
    ungroup() |>
    # Drop the helper columns
    select(-Q1, -Q3, -IQR, -lower_bound, -upper_bound)

# ANALYSIS: HISTOGRAM OF LIFE EXPECTANCy
# This histogram is now based on the cleaned data.
hist_plot <- gapminder |>
    ggplot(aes(x = life_expectancy)) +
    geom_histogram(binwidth = 2, fill = "steelblue", color = "black") +
    labs(
        title = "Distribution of Life Expectancy (Outliers Removed)",
        x = "Life Expectancy (years)",
        y = "Number of country-year observations"
    )
print(hist_plot)

# ANALYSIS: FERTILITY VS LIFE EXPECTANCY 
scatter_2012 <- gapminder |>
    filter(year == 2012) |>
    ggplot(aes(x = fertility, y = life_expectancy, color = continent)) +
    geom_point(size = 2) +
    labs(
        title = "Fertility vs Life Expectancy (2012)",
        x = "Fertility (children per woman)",
        y = "Life Expectancy (years)",
        color = "Continent"
    )
print(scatter_2012)

# ANALYSIS: FACETED VIEW (1962 VS 2012)
scatter_faceted <- gapminder |>
    filter(year %in% c(1962, 2012)) |>
    ggplot(aes(x = fertility, y = life_expectancy, color = continent)) +
    geom_point() +
    facet_grid(year ~ continent) +
    labs(
        title = "Fertility vs Life Expectancy: 1962 vs 2012",
        x = "Fertility (children per woman)",
        y = "Life Expectancy (years)"
    )
print(scatter_faceted)

# ANALYSIS: TREND FOR BRAZIL AND JAPAN 
countries_to_plot <- c("Brazil", "Japan")

line_plot_countries <- gapminder |>
    filter(country %in% countries_to_plot) |>
    ggplot(aes(x = year, y = life_expectancy, color = country)) +
    geom_line(size = 1) +
    geom_point(size = 2) +
    labs(
        title = "Life Expectancy Over Time: Brazil vs Japan",
        x = "Year",
        y = "Life Expectancy (years)",
        color = "Country"
    )
print(line_plot_countries)

# ANALYSIS: SUMMARY STATISTICS BY CONTINENT
avg_life_exp_by_continent <- gapminder |>
    group_by(continent) |>
    summarize(
        # We use the full name here
        avg_life_exp = mean(life_expectancy)
    )

print(avg_life_exp_by_continent)

# ANALYSIS: INDIA VS CHINA
line_plot_ind_chn <- gapminder |>
    filter(country %in% c("India", "China")) |>
    ggplot(aes(x = year, y = life_expectancy, color = country)) +
    geom_line(size = 1) +
    geom_point(size = 2) +
    labs(
        title = "Life Expectancy Trend: India vs China",
        x = "Year",
        y = "Life Expectancy (years)",
        color = "Country"
    )
print(line_plot_ind_chn)
