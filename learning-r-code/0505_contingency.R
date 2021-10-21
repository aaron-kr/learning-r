# File:    0505_contingency.R
# Project: LearningR

# Contingency = cross tabulation

# INSTALL & LOAD PKGS ####

# pacman must already be installed; then load contributed
# packages (including pacman) with pacman
install.packages('pacman')
pacman::p_load(pacman, rio, tidyverse)

# LOAD & PREP DATA ####

# Save Categorical Variables
df <- import('~/Desktop/Dev/learning-r/data/StateData.xlsx') %>%
  as_tibble() %>%
  select(
    state_code,
    region,
    psychRegions,
  ) %>%
  mutate(psychRegions = as.factor(psychRegions)) %>%
  print()

# ANALYZE DATA ####

ct <- table(df$region, df$psychRegions)
ct

# Can also get cell, row, and column %
# with rounding to 2 decimal places
# multiply by 100 to make %

p_load(magrittr) # to get arithmetic aliases

# Row %
ct %>%
  prop.table(1) %>% # 1 = row %
  round(2) %>%
  multiply_by(100)

# Column %
ct %>%
  prop.table(2) %>% # 2 = col %
  round(2) %>%
  multiply_by(100)

# Total %
ct %>%
  prop.table() %>%
  round(2) %>%
  multiply_by(100)

# Chi-squared test (but n is small)
tchi <- chisq.test(ct)
tchi

# Additional tables
tchi$observed  # Observed frequencies (same as ct)
tchi$expected  # Expected frequencies
tchi$residuals # Pearson's residual
tchi$stdres    # Standardized residual

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
