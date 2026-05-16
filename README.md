# 📊 Netflix Content Trends & Growth Analysis Using SQL


**📁 Dataset Information**

Source: Netflix Movies & TV Shows dataset

Total Records: 8,800+ titles

The dataset includes different data formats, such as duration stored as text and date values stored as VARCHAR, so cleaning and transformation were required before analysis.

🛠 Project Workflow

**1️⃣ Data Cleaning & Preparation:**

- Converted date_added from VARCHAR into proper DATE format.

- Created a numeric duration column (duration_int) for analysis.

- Analyzed Movies and TV Shows separately for better insights.

- Checked null values and reviewed overall data quality.

**2️⃣ Exploratory Data Analysis:**

- Content split between Movies and TV Shows

- Movie duration analysis using min, max, and average

- TV Show season-wise distribution

- Longest-running TV Shows using window functions

- Country-wise content availability

- Year-wise content production pattern

- Year-over-Year (YoY) growth analysis

- Content addition trend based on added year

- Movies vs TV Shows growth trend by year added


**📈 Key Insights:**

- Movies make up the major share of the platform, covering nearly 70% of total content.

- Around 67% of TV Shows have only 1 season, showing a high number of limited-series titles.

- Strong content production growth was seen between 2015–2018.

- The highest production year was 2018.

- Content additions peaked in 2019, showing rapid platform expansion.

- The 2016–2019 growth period was mainly driven by Movies.

- The decline after 2019 suggests slower additions or a more focused content strategy.


**🎯 Business Understanding:**

The analysis shows that Netflix expanded rapidly between 2015–2019 with strong content acquisition and movie-focused additions, followed by a visible slowdown in later years.


**This project demonstrates:**

- Data cleaning and preparation skills

- SQL querying using aggregations, window functions, and CTEs

- Trend and growth analysis

- Business-focused interpretation of data
