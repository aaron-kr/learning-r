# File:    0501_frequencies.R
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
    state_code,
    region,
    psychRegions
  ) %>%
  mutate(psychRegions = as.factor(psychRegions)) %>%
  # rename(y = psychRegions) %>%
  print()

# SUMMARIZE DF ####
summary(df) # frequencies for factors only

# SUMMARIZE CAT VAR ####

# 'region' is char var
df %>%
  select(region) %>%
  summary() # so summary() is not very useful

df %>%
  select(region) %>%
  table() # table() is better

# SUMMARIZE FACTOR ####

# 'psychRegions' is factor
df %>%
  select(psychRegions) %>%
  summary() # so summary() is fine

df %>%
  select(psychRegions) %>%
  table() # table() = labels are long, so looks weird

# Summarize Multiple Factors ====

df <- df %>%
  mutate(region = as.factor(region)) %>%
  mutate(psychRegions = as.factor(psychRegions)) %>%
  print()

summary(df)

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
