# Exercise 5: dplyr grouped operations

# Install the `"nycflights13"` package. Load (`library()`) the package.
# You'll also need to load `dplyr`
#install.packages("nycflights13")  # should be done already
library("nycflights13")
library("dplyr")
View(flights)
# What was the average departure delay in each month?
# Save this as a data frame `dep_delay_by_month`
# Hint: you'll have to perform a grouping operation then summarizing your data

# Which month had the greatest average departure delay?
dep_delay_by_month <- flights %>%
  group_by(month) %>%
  summarize(avg_dep_delay = mean(dep_delay, na.rm = T)) %>%
  filter(avg_dep_delay == max(avg_dep_delay)) %>%
  pull(month)

# If your above data frame contains just two columns (e.g., "month", and "delay"
# in that order), you can create a scatterplot by passing that data frame to the
# `plot()` function
month_delay <- flights %>%
  group_by(month) %>%
  summarize(avg_dep_delay = mean(dep_delay, na.rm = T))

plot(month_delay)

# To which destinations were the average arrival delays the highest?
# Hint: you'll have to perform a grouping operation then summarize your data
# You can use the `head()` function to view just the first few rows
high_avg_arr_delay <- flights %>%
  group_by(dest) %>%
  summarize(avg_arr_delay = mean(arr_delay, na.rm = T)) %>%
  filter(avg_arr_delay == max(avg_arr_delay, na.rm = T)) %>%
  pull(dest)

# You can look up these airports in the `airports` data frame!
View(airports)
look_up <- airports %>%
  filter(faa == high_avg_arr_delay)
# Which city was flown to with the highest average speed?
dest_high_speed <- flights %>%
  group_by(dest) %>%
  summarize(avg_speed = mean( (distance / air_time ), na.rm = T ) ) %>%
  filter(avg_speed == max(avg_speed, na.rm = T)) %>%
  pull(dest)

cty_high_speed <- airports %>%
  filter(faa == dest_high_speed) %>%
  pull(name)
            