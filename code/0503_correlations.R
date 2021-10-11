# File:    0503_correlations.R
# Project: LearningR

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
    instagram:modernDance
  ) %>%
  print()

# CORRELATION MATRIX ####

cor(df)

# round to 2 decimals
df %>%
  cor() %>%
  round(2)

# SINGLE CORRELATION ####

# Can test one pair of var at a time
# Gives r, hypothesis test, and confidence interval
# values for a standard significance test for a single correlation
cor.test(df$instagram, df$privacy)

# P-VALUES FOR MATRIX ####

# Install "Hmisc" package to get p-values for matrix
p_load(Hmisc)

# Need to coerce from datafram to matrix to get both a
# correlation matrix and p-values (in separate tables)
df %>%
  as.matrix() %>%
  rcorr()
# produces 2 tables
# Table 1: correlation coefficients (as seen earlier)
# Table 2: corresponding p-values (probability values)

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
