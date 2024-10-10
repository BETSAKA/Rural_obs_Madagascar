# Load required libraries
library(tidyverse)
library(haven)        # To read .dta (Stata) files
library(purrr)

# Define the path where the data is located
data_path <- "data/dta_format/"

# Function to load data, select relevant columns, and bind with year
load_and_select <- function(year) {
  file_path <- paste0(data_path,  year, "/res_m_a.dta")  # Assuming file naming convention
  
  # Load the data
  data <- read_dta(file_path)
  
  # Select household number and 's1a' (whether people know how to read), add survey year
  selected_data <- data %>%
    select(household_number = j5, s1a, s1b) %>%
    mutate(year = year)
  
  return(selected_data)
}

# Define the years you want to process
years <- 1999:2015  # Example range, adjust as needed

# Load, select and bind rows for all years
all_data <- map_df(years, load_and_select)


# Calculate total and percentage per year for each modality
percentage_per_year <- all_data %>%
  mutate(reads_writes = s1a == 1 & s1b == 1) %>%
  group_by(year) %>% 
  summarise(percentage = mean(reads_writes, na.rm = TRUE), .groups = 'drop') 


ggplot(percentage_per_year, aes(x = year, y = percentage)) +
  geom_col(position = "dodge") +
  labs(x = "Year", y = "Percentage", fill = "Can read and write") +
  theme_minimal()
