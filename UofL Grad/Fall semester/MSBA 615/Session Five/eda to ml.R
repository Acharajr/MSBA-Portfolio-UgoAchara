
library(tidyverse)


set.seed(123)  # for reproducibility

# toy data
loan_data <- tibble(
    person_id = 1:20,
    income = round(runif(20, 30000, 120000), 0),          # annual income in dollars
    credit_score = round(runif(20, 580, 800), 0),         # FICO-like credit score
    age = round(runif(20, 22, 60), 0),                    # age in years
    
    # Construct a "loan_approval_chance" between 0 and 1
    # as a weighted combination of income, credit_score, and age + some noise
    loan_approval_chance = round(
        0.4 * income / 100000 +       # higher income -> higher chance
            0.3 * credit_score / 800 +    # higher credit score -> higher chance
            0.1 * age / 60 +              # slightly higher chance for older people
            rnorm(20, mean = 0, sd = 0.05),  # random noise to make it realistic
        2
    )
)

# View the data
glimpse(loan_data)



# Quick numeric summary
summary(loan_data)

# Bar plot: distribution of ages
# Here, we treat age as a categorical variable (factor) to see counts.
loan_data %>%
    ggplot(aes(x = factor(age))) +
    geom_bar(fill = "steelblue") +
    labs(
        title = "Age Distribution",
        x = "Age",
        y = "Number of people"
    )

# Box plot: distribution of income
# Boxplots are used to see median, quartiles, and outliers.
loan_data %>%
    ggplot(aes(y = income)) +
    geom_boxplot(fill = "tomato") +
    labs(
        title = "Boxplot of Income",
        y = "Income (USD)"
    )

# Scatter plot with color and size aesthetics
# Goal: visualize relationship between income and loan_approval_chance,
# while using credit_score as color and age as point size.
loan_data %>%
    ggplot(aes(
        x = income,
        y = loan_approval_chance,
        color = credit_score,
        size = age
    )) +
    geom_point(alpha = 0.8) +
    scale_color_viridis_c() +
    labs(
        title = "Loan Approval Chance vs Income",
        x = "Income (USD)",
        y = "Loan Approval Chance (0 to 1)",
        color = "Credit Score",
        size = "Age"
    )



# In general, higher income and higher credit score tend to have higher loan_approval_chance.
#
# Natural question:
#   "If a new person comes with certain income, credit score, and age,
#    can we PREDICT their loan approval chance?"
#
# This is where supervised machine learning starts.
# We begin with the simplest model: a straight line (simple linear regression).

# Simple Linear Regression:
#    loan_approval_chance ~ income

# Build the model using only income as the predictor.
model1 <- lm(loan_approval_chance ~ income, data = loan_data)

# View model summary
summary(model1)

# Interpretation of the simple regression:
# Model form: loan_approval_chance_hat = b0 + b1 * income
# b0 (Intercept): baseline approval chance when income = 0 (theoretically).
# b1 (slope): change in approval chance for each 1 unit increase in income (1 dollar).
#
# In practice, we interpret b1 as:
#   "for every additional 1000 dollars of income, approval chance changes by 1000 * b1"

# Visualize the regression line
loan_data %>%
    ggplot(aes(x = income, y = loan_approval_chance)) +
    geom_point() +
    geom_smooth(method = "lm", se = TRUE, color = "blue") +
    labs(
        title = "Simple Linear Regression: Income -> Loan Approval Chance",
        x = "Income (USD)",
        y = "Loan Approval Chance"
    )


# The straight line (linear regression) is the simplest predictive rule.
#  - Captures an overall increasing or decreasing trend.
#  - Provides a simple formula:
#       loan_approval_chance_hat = b0 + b1 * income
#  - Gives an interpretable "marginal effect" of income:
#       how much approval chance changes when income changes.
#
# It does NOT:
#  - Capture nonlinear relationships (e.g., diminishing returns at high income).
#  - Use multiple factors together (e.g., income + credit_score + age).
#  - Capture interactions (e.g., income effect might depend on credit_score).


# This motivates moving from simple regression to multiple regression.


# loan_approval_chance ~ income + credit_score + age


model2 <- lm(loan_approval_chance ~ income + credit_score + age, data = loan_data)

# View model summary
summary(model2)

# Interpretation of multiple regression:
# Model form:
#   loan_approval_chance_hat = b0
#                              + b1 * income
#                              + b2 * credit_score
#                              + b3 * age
#
# Each coefficient shows the effect of that variable
# while holding the other variables constant.
#
# For example:
#  - b1: effect of income on approval chance, for a fixed credit_score and age.
#  - b2: effect of credit_score on approval chance, for fixed income and age.
#
# Often, Adjusted R-squared will be higher for multiple regression than
# for simple regression, meaning the model explains more variation.


#Example: Using the model for prediction


# Create a new data frame with a "new" person
new_person <- tibble(
    income = 75000,
    credit_score = 720,
    age = 35
)

# Predict using the simple model (only income)
predict(model1, newdata = new_person)

# Predict using the multiple regression model
predict(model2, newdata = new_person)

# The predicted values represent the estimated loan approval chance
# for this new person, given our learned relationships from the data.

