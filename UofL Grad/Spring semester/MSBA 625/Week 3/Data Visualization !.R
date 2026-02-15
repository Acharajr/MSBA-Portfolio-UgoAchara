library(dplyr)
library(ggplot2)

# Assuming your dataset is named `student_data`
# and the relevant columns are:
#   - International Student Status
#   - Program Description

sasExport071R %>%
  filter(`International Student Status` == "International Student: Yes") %>%
  count(`Program Description`) %>%
  ggplot(aes(x = reorder(`Program Description`, n), y = n)) +
  geom_col(fill = "#2C7FB8") +
  coord_flip() +
  labs(
    title = "International Student Enrollment by Program",
    x = "Program",
    y = "Number of International Students"
  ) 


library(dplyr)
library(ggplot2)
library(stringr)

library(dplyr)
library(ggplot2)
library(stringr)

sasExport071R %>%
  mutate(intl_flag = str_detect(`International Student Status`, "Yes")) %>%
  group_by(`Program Description`) %>%
  summarise(pct_international = mean(intl_flag) * 100) %>%
  arrange(desc(pct_international)) %>%
  slice_head(n = 15) %>%   # <-- show top 15 programs
  ggplot(aes(x = reorder(`Program Description`, pct_international),
             y = pct_international)) +
  geom_col(fill = "#2C7FB8") +
  coord_flip() +
  labs(
    title = "Top 15 Programs by Percentage of International Students",
    x = "Program",
    y = "Percent International"
  ) +
  theme_minimal(base_size = 13)


sasExport071R %>%
  mutate(intl_flag = str_detect(`International Student Status`, "Yes")) %>%
  group_by(Semester) %>%
  summarise(
    total_students = n(),
    intl_students = sum(intl_flag),
    pct_international = (intl_students / total_students) * 100
  ) %>%
  ggplot(aes(x = Semester, y = pct_international, group = 1)) +
  geom_line(size = 1.2, color = "#2C7FB8") +
  geom_point(size = 3, color = "#2C7FB8") +
  labs(
    title = "International Student Enrollment Over Time",
    x = "Semester",
    y = "Percent International"
  ) +
  theme_minimal(base_size = 14) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


library(dplyr)
library(ggplot2)
library(stringr)

sasExport071R %>%
  filter(str_detect(`International Student Status`, "Yes")) %>%   # keep only international students
  count(Semester) %>%                                             # count per semester
  ggplot(aes(x = Semester, y = n, group = 1)) +
  geom_line(size = 1.2, color = "#2C7FB8") +
  geom_point(size = 3, color = "#2C7FB8") +
  labs(
    title = "International Student Enrollment by Semester",
    x = "Semester",
    y = "International Student Count"
  ) +
  theme_minimal(base_size = 14) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


unique(sasExport071R$`International Student Status`)

library(dplyr)
library(ggplot2)
library(stringr)
library(forcats)

library(dplyr)
library(ggplot2)
library(stringr)
library(forcats)

sasExport071R %>%
  # Keep only international students
  filter(str_detect(`International Student Status`, "Yes")) %>%
  
  # Create a clean semester label like "Fall 2019"
  mutate(
    semester_label = paste(Semester, `Academic Year`),
    
    # Extract year (assumes Academic Year is like "2019-2020")
    year_start = as.numeric(str_sub(`Academic Year`, 1, 4)),
    
    # Assign numeric order to semesters
    sem_order = case_when(
      str_detect(Semester, regex("Spring", ignore_case = TRUE)) ~ 1,
      str_detect(Semester, regex("Summer", ignore_case = TRUE)) ~ 2,
      str_detect(Semester, regex("Fall",   ignore_case = TRUE)) ~ 3,
      TRUE ~ 4
    ),
    
    # Build a sortable key
    sort_key = year_start * 10 + sem_order
  ) %>%
  
  # Count international students per semester
  count(semester_label, sort_key) %>%
  
  # Order by the chronological key
  arrange(sort_key) %>%
  mutate(semester_label = factor(semester_label, levels = semester_label)) %>%
  
  ggplot(aes(x = semester_label, y = n, group = 1)) +
  geom_line(size = 1.2, color = "#2C7FB8") +
  geom_point(size = 3, color = "#2C7FB8") +
  labs(
    title = "International Student Enrollment by Semester",
    x = "Semester",
    y = "International Student Count"
  ) +
  theme_minimal(base_size = 14) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


