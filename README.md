# dvd-rental-data-analysis
SQL and R data analysis project on a DVD rental dataset to extract business insights and strategic recommendations.

---

## Project Overview

This project explores a relational database from a fictional DVD rental company, analyzing:
- Customer segmentation and revenue distribution.
- Daily and weekly revenue trends.
- Rental duration patterns across movie categories.

### Tools and Skills
- **SQL**: PostgreSQL
- **R**: dplyr, ggplot2, readr
- **Techniques**: Statistical Testing (t-test, ANOVA), Sensitivity Analysis, Data Visualization

---

## Key Analyses

### 1. Customer Revenue Distribution
- **Business Question**: Is there a significant difference in revenue between the top 10% and the bottom 90% of customers?
- **Approach**: SQL aggregation and R t-test.
- **Insight**: Top 10% of customers contribute a disproportionately high revenue.

**[View SQL Query](SQL/dvd_rental_analysis.sql)**
**[View R Analysis](R/customer_revenue_analysis.R)**

---

### 2. Daily Revenue Trends
- **Business Question**: What are the daily revenue patterns?
- **Approach**: Aggregated revenue by day and plotted trends.
- **Insight**: Sundays generate the most revenue; midweek underperforms.

**[View SQL Query](SQL/dvd_rental_analysis.sql)**
**[View R Analysis](R/customer_revenue_analysis.R)**

---

### 3. Rental Duration by Movie Category
- **Business Question**: Are rental durations different across categories?
- **Approach**: ANOVA and Tukey post-hoc test.
- **Insight**: Slight variation, but not significant enough for business strategy changes.

**[View SQL Query](SQL/dvd_rental_analysis.sql)**
**[View R Analysis](R/customer_revenue_analysis.R)**

---

##  Key Takeaways
- Identified high-value customer segments critical to revenue.
- Suggested customer retention and marketing strategies.
- Provided strategic insights to optimize operations based on data.
- Developed skills in SQL, R, and advanced statistical analysis.

---

## Repository Structure

```
/SQL
    dvd_rental_analysis.sql

/R
    customer_revenue_analysis.R

/Plots
    daily_revenue_trends.png
    revenue_boxplot.png

README.md
Portfolio_Summary.docx (Optional)
```

---


