# R Analysis: Customer Revenue Distribution and Daily Revenue Trends

# Load required libraries
library(readr)
library(dplyr)
library(ggplot2)

# Customer Revenue Analysis

# Load customer revenue data
customer_data <- read.csv("~/Downloads/Q5_SQL.csv")

# Arrange data by total revenue descending
customer_data <- customer_data %>% arrange(desc(total_amount))

# Define top 10% cutoff
top_10_pct_cutoff <- quantile(customer_data$total_amount, 0.90)

# Create group variable
customer_data$group <- ifelse(customer_data$total_amount >= top_10_pct_cutoff, "Top 10%", "Bottom 90%")

# Perform t-test
t_test_result <- t.test(total_amount ~ group, data = customer_data)
print(t_test_result)

# Create a boxplot
boxplot(total_amount ~ group, data = customer_data, main = "Top 10% vs Bottom 90% Revenue")

# Sensitivity Analysis

top10 <- customer_data %>% filter(group == "Top 10%")
bottom90 <- customer_data %>% filter(group == "Bottom 90%")

for (i in seq(0.9, 0.5, by = -0.01)) {
  simulated_top10 <- top10
  simulated_top10$total_amount <- simulated_top10$total_amount * i
  test_df <- rbind(simulated_top10, bottom90)
  test <- t.test(total_amount ~ group, data = test_df)
  cat("Reduction:", i, "p-value:", test$p.value, "\n")
  if (test$p.value > 0.05) {
    cat("No longer significant at", i * 100, "% of original top 10% revenue\n")
    break
  }
}

# Daily Revenue Trend Analysis

# Load daily revenue data
daily_revenue <- read_csv("~/Downloads/SQL_6.csv")

# Order the weekdays properly
daily_revenue$weekday_name <- factor(
  daily_revenue$weekday_name,
  levels = c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday")
)

# Create bar plot of total revenue by day
ggplot(daily_revenue, aes(x = weekday_name, y = total_revenue)) +
  geom_col(fill = "skyblue") +
  geom_text(aes(label = paste0("$", round(total_revenue, 0))), vjust = -0.5, size = 3) +
  labs(title = "Daily Revenue Trend", x = "Day", y = "Total Revenue") +
  theme_minimal()

# Weekly Revenue Trends by Day

# Load weekly revenue data
df <- read.csv("~/Downloads/graphbyday.csv")

# Order weekday names
df$weekday_name <- factor(
  df$weekday_name,
  levels = c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday")
)

# Plot line graph for weekly revenue trend
ggplot(df, aes(x = week_number, y = total_revenue, color = weekday_name)) +
  geom_line(size = 1.2) +
  labs(title = "Weekly Revenue Trends by Day of the Week",
       x = "Week Number",
       y = "Total Revenue",
       color = "Weekday") +
  theme_minimal()

# Remove outliers using IQR method
cleaned_df <- df %>%
  group_by(weekday_name) %>%
  mutate(
    q1 = quantile(total_revenue, 0.25),
    q3 = quantile(total_revenue, 0.75),
    iqr = q3 - q1,
    upper_bound = q3 + 1.5 * iqr,
    lower_bound = q1 - 1.5 * iqr
  ) %>%
  filter(total_revenue <= upper_bound & total_revenue >= lower_bound) %>%
  ungroup()

# Optional: Summarize cleaned data
summary_stats <- cleaned_df %>%
  group_by(weekday_name) %>%
  summarise(
    Mean_Revenue = mean(total_revenue),
    Median_Revenue = median(total_revenue),
    Max_Revenue = max(total_revenue),
    SD = sd(total_revenue),
    Count = n()
  )
print(summary_stats)
