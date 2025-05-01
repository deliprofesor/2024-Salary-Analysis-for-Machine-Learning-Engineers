# 2024-Salary-Analysis-for-Machine-Learning-Engineers

![image](https://github.com/user-attachments/assets/d1572c4f-6849-4e31-8472-d0156ef2e9d9)


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

- Data Preparation: The data was loaded, missing values were identified and removed.

- Summary Statistics: The basic characteristics of the data were summarized, and salary distributions along with other variables were analyzed.

- Group-Based Analysis: Average salary by experience level, company size, and country was calculated.

- Visualization: A scatter plot was created to show the relationship between salary and remote working ratio. Bar charts were prepared to display salary distribution by country and yearly salary trends. A correlation heatmap and box plots were used to visualize relationships between variables.

- Machine Learning Models: A linear regression model was built for salary prediction, and its accuracy was evaluated. A Random Forest model was used to determine the importance of features in salary prediction.
