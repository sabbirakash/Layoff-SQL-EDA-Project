# 💼 Layoff Trends SQL Project – Data Cleaning & EDA

This project explores global layoff data using **pure SQL**. It involves:
- Cleaning and transforming raw data
- Performing exploratory data analysis (EDA)
- Extracting insights on company layoffs across industries, years, countries, and more.

---

## 📌 Objective

To clean real-world layoff data and extract meaningful trends about layoffs across industries, countries, time periods, and funding stages using SQL.

---

## 🗂️ Dataset

The dataset contains global layoff information, including:
- Company name
- Location, country, industry
- Total employees laid off and percentage
- Company stage and funds raised
- Date of layoff event

---

## 🧹 Phase 1: Data Cleaning with SQL

Performed cleaning in a staging table using SQL:

### Key Steps:
- ✅ Removed duplicate records using `ROW_NUMBER() OVER (...)`
- ✅ Trimmed whitespace and standardized text (e.g., industry, country names)
- ✅ Fixed inconsistent entries (e.g., “United States” vs. “United States of America”)
- ✅ Converted date strings to `DATE` format using `STR_TO_DATE()`
- ✅ Handled missing or null values (e.g., industry, total_laid_off)
- ✅ Dropped unnecessary rows and columns

👉 See: [`Layoff Data Cleaning SQL Project.sql`](./Layoff%20Data%20Cleaning%20SQL%20Project.sql)

---

## 📊 Phase 2: Exploratory Data Analysis (EDA)

Using cleaned data, explored trends via SQL queries:

### Key Insights:
- 🔹 **Top companies** with the most layoffs (e.g., Meta, Amazon)
- 🔹 Layoff trends **by year** and **by month**
- 🔹 Industries most affected (e.g., Crypto, Retail, Finance)
- 🔹 Countries and locations with highest layoffs
- 🔹 Startups vs. matured companies – comparison via funding and stage
- 🔹 Identified companies with **100% layoffs** (shutdowns)
- 🔹 Rolling monthly layoff trends using window functions

👉 See: [`Layoff EDA SQL Project.sql`](./Layoff%20EDA%20SQL%20Project.sql)

---

## 🔧 Tools Used
- **SQL (MySQL)**
- **DBMS Workbench / VS Code**

---

## 📈 What I Learned

- How to **clean and standardize** messy real-world data with SQL
- How to perform **effective EDA using raw queries**
- How to use advanced SQL functions like `ROW_NUMBER()`, `DENSE_RANK()`, and window functions

---

## 📎 Future Work

- Visualize these insights using Power BI or Tableau
- Predict future layoffs based on trends (via ML)
- Automate ETL pipeline for updated data

---

## 🔗 Connect with Me

Feel free to connect on [LinkedIn](https://www.linkedin.com/in/sabbirakash/) or view more projects on my [GitHub](https://github.com/sabbirakash).
