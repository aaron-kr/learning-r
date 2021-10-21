# File:     0208_packages.R
# Project:  Learning R

# INSTALL AND LOAD PACKAGES ####

# install pacman (package manager) if needed
if (!require('pacman')) install.packages('pacman')

# Load contributed packages with pacman
pacman::p_load(pacman, party, psych, rio, tidyverse)
# pacman: loading/unloading packages
# party: decision trees
# psych: many statistical procedures
# rio: importing data
# tidyverse: for so many reasons...

library(datasets) # for example datasets

# LOAD AND PREPARE DATA ####

# Save data to 'df' ('data frame')
# Rename outcome as 'y' (if it helps)
# Specify outcome with df$y

# Import CSV files with readr::read_csv() from tidyverse
(df <- read_csv('data/StateData.csv'))

# Import other formats with rio::import() from rio
(df <- import('data/StateData.xlsx') %>% as_tibble())

# or...
df <- import('data/StateData.xlsx') %>%
  as_tibble() %>%
  select(state_code,
    psychRegions,
    instagram:modernDance) %>%
  mutate(psychRegions = as.factor(psychRegions)) %>%
  rename(y = psychRegions) %>%
  print()

# ANALYZE DATA ####

# By using standardized object and variable names, the same
# code can be reused for different analyses

# Decision tree using party::ctree
# df[,-1] excludes the state_code
fit <- ctree(y = ., data = df[,-1]) # create tree
fit %>% plot()
fit %>%
  predict() %>%
  table(df$y)

hc <- df %>%  # get data
  dist %>%    # compute distance/dissimilarity matrix
  hclust %>%  # Compute hierarchical clusters
  plot(labels = df$state_code)  # plot dendrogram

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
