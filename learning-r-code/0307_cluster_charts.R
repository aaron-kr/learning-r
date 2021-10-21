# File:    0307_cluster_charts.R
# Project: LearningR

# INSTALL & LOAD PKGS ####

# pacman must already be installed; then load contributed
# packages (including pacman) with pacman
pacman::p_load(pacman, rio, tidyverse)

# LOAD DATA ####

# Save data to 'df', rename outcome as 'y' (if it helps)
# Specify outcome as df$y

df <- import('D:/Desktop/Dev/learning-r/data/StateData.xlsx') %>%
  as_tibble() %>%
  select(
    state_code,
    psychRegions,
    instagram:modernDance
  ) %>%
  mutate(psychRegions = as.factor(psychRegions)) %>%
  rename(y = psychRegions) %>%
  print()

# ANALYZE ####

# With standard object and var names, same code can be reused for different analyses

# Calculate clusters
hc <- df %>% # Get data
  dist %>%   # Compute distance/dissimilarity matrix
  hclust     # Computer hierarchical clusters

# Plot dendrogram
hc %>% plot(labels = df$state_code)

# Draw boxes around clusters
hc %>% rect.hclust(k = 2, border = 'gray80') # 2 boxes
hc %>% rect.hclust(k = 3, border = 'gray60') # 3 boxes
hc %>% rect.hclust(k = 4, border = 'gray40') # 4 boxes

# CLUSTER CHARTS ####

# CLEAN UP ####

# Clear environment
rm(list = ls())

# Clear packages
detach("package:datasets", unload = TRUE)  # For base

# Clear plots
dev.off()  # But only if there IS a plot

# Clear console
cat("\014")  # ctrl+L

# Clear mind :)
