# 2024-Salary-Analysis-for-Machine-Learning-Engineers

This project provides an exploratory data analysis and visualization of a dataset containing salary information for data-related roles. The goal is to uncover patterns based on experience level, company size, location, and remote work ratios.

## Dataset

The dataset used in this analysis is `salaries.csv`, which includes fields such as:

- `work_year`: The year of the salary report.
- `experience_level`: Experience level of the employee (e.g., EN, MI, SE, EX).
- `employment_type`: Type of employment.
- `job_title`: Title of the job.
- `employee_residence`: Country of residence.
- `remote_ratio`: Percentage of remote work (0 to 100).
- `company_location`: Country of the company.
- `company_size`: Size of the company (S, M, L).
- `salary_in_usd`: Salary in USD.

## Libraries Used


install.packages("tidyverse")
install.packages("dplyr")
install.packages("ggplot2")
install.packages("summarytools")
install.packages("corrplot")
install.packages("randomForest")
install.packages("plotly")

## Visualizations & Analysis

### Data Cleaning
Missing values are removed using na.omit().

### Salary Statistics
Average salary is calculated and visualized by:

Experience Level

Company Size

Job Title

Employee Residence

Work Year

Correlation Analysis
Numeric encoding for company_size allows correlation with remote_ratio and salary_in_usd.

A correlation matrix is visualized using corrplot.

Regression & Machine Learning
A linear model (lm) is built to predict salary based on experience and remote ratio.

A Random Forest model is used to determine variable importance.

Key Plots
Salary vs. Remote Ratio: Scatter plot with experience level coloring.

Salary Distribution by Experience: Box plot grouped by experience level.

Salary by Country: Horizontal bar chart sorted by average salary.

Salary by Job Title: Ranked bar chart of average salary per job.

Average Salary by Year: Enhanced line chart with labels and styling.

Interactive Plot: Remote ratio vs. salary visualized with ggplotly().

Highlight Plot

ggplot(avg_salary_by_year, aes(x = year, y = mean_salary, group = 1)) +
  geom_line(color = "#0073C2FF", size = 1.5) +
  geom_point(color = "#EFC000FF", size = 4) +
  geom_text(aes(label = round(mean_salary, 0)), vjust = -1, size = 3.5) +
  labs(title = "Yıllara Göre Ortalama Maaş Değişimi",
       x = "Yıl", y = "Ortalama Maaş (USD)") +
  theme_minimal(base_size = 14)
