# 2024-Salary-Analysis-for-Machine-Learning-Engineers

![image](https://github.com/user-attachments/assets/d1572c4f-6849-4e31-8472-d0156ef2e9d9)

##  Project Overview
This project provides an **interactive Shiny Dashboard** for exploring salary distributions of professionals working in **Machine Learning and Data Science** fields.  
It allows filtering by experience level, job title, company size, and country to better understand **salary patterns in 2024**.

The dashboard offers a user-friendly and dynamic interface built with `shinydashboard`, enabling deep data exploration and interactive visualizations.

---

##  Features
- **Dynamic Filtering**
  - Filter salaries by:
    - Experience Level (`EN`, `MI`, `SE`, `EX`)
    - Job Title
    - Company Size (`S`, `M`, `L`)
    - Employee Residence Country  

- **Interactive Visualizations**
  - Plotly-powered box plots showing salary distribution by experience level  
  - Smooth, modern UI/UX design with `shinydashboard`

- **Automatic Data Cleaning**
  - Missing values are automatically removed (`na.omit()`)

---

##  Tech Stack
| Category | Libraries |
|-----------|------------|
| Web App Framework | `shiny`, `shinydashboard` |
| Data Manipulation | `tidyverse`, `dplyr` |
| Visualization | `ggplot2`, `plotly` |

---

##  Dataset: `salaries.csv`
This dataset contains salary information for data-related roles across multiple countries and company sizes.

| Column | Description |
|--------|--------------|
| `work_year` | Year of the salary report |
| `experience_level` | Experience level (`EN`, `MI`, `SE`, `EX`) |
| `employment_type` | Type of employment (FT, PT, CT, FL) |
| `job_title` | Job title |
| `salary` | Salary in local currency |
| `salary_currency` | Currency of the salary |
| `salary_in_usd` | Salary converted to USD |
| `employee_residence` | Country of residence |
| `remote_ratio` | Percentage of remote work (0–100) |
| `company_location` | Country of the company |
| `company_size` | Size of the company (`S`, `M`, `L`) |

---

##  Previous EDA & ML Analysis
Before building the dashboard, an **Exploratory Data Analysis (EDA)** was performed:
- Summary statistics and data cleaning  
- Average salary grouped by experience, country, and company size  
- Visualization of salary vs remote ratio and country-based salary trends  
- Correlation heatmap to explore variable relationships  

**Machine Learning Models:**
- Linear Regression model for salary prediction  
- Random Forest model to identify key factors affecting salaries  

---

##  How to Run the App
```r
# Install dependencies
install.packages(c("shiny", "shinydashboard", "tidyverse", "dplyr", "ggplot2", "plotly"))

# Run the app
library(shiny)
runApp("app.R")


