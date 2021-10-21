# File:     0212_spreadsheet_import.R
# Project:  Learning R

# If your data is rectangular (no headers, merged cells, etc)
# you can use an Excel Spreadsheet

# INSTALL AND LOAD PACKAGES ####

# install pacman (package manager) if needed
if (!require('pacman')) install.packages('pacman')

# Load contributed packages with pacman
pacman::p_load(pacman, party, rio, tidyverse)
# pacman: loading/unloading packages
# party: decision trees
# rio: importing data
# tidyverse: for so many reasons...

# LOAD AND PREPARE DATA ####

# Save data to 'df' ('data frame')
# Rename outcome as 'y' (if it helps)
# Specify outcome with df$y

# Import CSV files with readr::read_csv() from tidyverse
(df <- read_csv('D:/Desktop/Dev/learning-r/data/StateData.csv'))

# Import other formats with rio::import() from rio
(df <- import('D:/Desktop/Dev/learning-r/data/StateData.xlsx') %>% as_tibble())

# or...
df <- import('D:/Desktop/Dev/learning-r/data/StateData.xlsx') %>%
  as_tibble() %>%
  select(state_code,
         psychRegions,
         instagram:modernDance) %>%
  mutate(psychRegions = as.factor(psychRegions)) %>%
  rename(y = psychRegions) %>%
  print()

# CLEAN UP #####################################################################

# Clear environment
rm(list = ls())

# Clear packages
p_unload(all) # unload all pacman packages
detach("package:datasets", unload = TRUE)  # For base

# Clear plots
dev.off()  # But only if there IS a plot

# Clear console
cat("\014")  # ctrl+L

# Clear mind :)
