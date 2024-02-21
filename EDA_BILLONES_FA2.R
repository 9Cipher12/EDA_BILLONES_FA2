
file_path <- "C:/Users/Cipher/Desktop/EDA_CRISTEL_FA2/cytof_one_experiment.csv"

# Read the CSV file
df <- read.csv(file_path)

# View the dataframe
View(df)

# 1
library(tidyr)

df$cell_id <- 1:nrow(df)
reshaped_df <- pivot_longer(df, 
                            cols = -cell_id, 
                            names_to = "protein_identity", 
                            values_to = "amount")

dim(reshaped_df)  

#2

library(dplyr)

summary_stats <- reshaped_df %>%
  group_by(protein_identity) %>%
  summarise(
    median_protein_level = median(amount),
    median_abs_dev = mad(amount)
  )

print(summary_stats)

#3

library(ggplot2)

ggplot(summary_stats, aes(x = median_abs_dev, y = median_protein_level)) +
  geom_point() +
  labs(x = "MAD (Median Absolute Deviation)",
       y = "Median Protein Level",
       title = "Spread-Location (s-l) Plot")

#4
library(tidyr)
library(dplyr)
file_path <- "C:/Users/Cipher/Desktop/EDA_CRISTEL_FA2/gymData.csv"
gymData <- read.csv(file_path)
View(gymData)

gymData_reshaped <- gymData %>%
  # Reshape the data to long format using pivot_longer
  pivot_longer(cols = -country, 
               names_to = c("Event", "Year"), 
               names_pattern = "(.*)_(\\d{4})",
               values_to = "Score") %>%
  # Separate the Year column to only keep the year
  mutate(Year = as.integer(Year)) # convert year to integer

# View the reshaped dataset
View(gymData_reshaped)