# Load required libraries
library(ggplot2)
library(tidyverse)

# Load the CSV file
data <- read_csv("graph_modules/modules_en.csv") %>%
  rename(Module = ...1)

# Convert the data to long format
data_long <- data %>%
  pivot_longer(cols = starts_with("19") | starts_with("20"), names_to = "Year", 
               values_to = "Present")

# Convert 'Present' to logical for easier filtering and ordering
data_long <- data_long %>%
  mutate(Present = as.logical(Present))

# Create the lollipop chart
plot <- ggplot(data_long %>% filter(Present), 
               aes(x = Year, y = factor(Module, levels = rev(data$Module)))) +
  geom_segment(aes(xend = Year, yend = Module), size = 1) +
  geom_point(size = 4, color = "black") +
  theme_minimal() +
  labs(title = NULL, x = NULL, y = NULL) +
  theme(axis.text.y = element_text(size = 8), 
        legend.position = "none",
        plot.title = element_blank(),
        plot.subtitle = element_blank(),
        axis.text.x = element_text(angle = 90, hjust = 1),
        axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        axis.text.x.top = element_text(angle = 90, vjust = 0.5, hjust = 0)) +
  scale_x_discrete(position = "top")

ggsave(filename = "chart.png", 
       plot = plot,
       path = "graph_modules",
       width = 1800, height = 1800, units = "px", dpi = 300)

