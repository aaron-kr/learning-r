# File:    0401_filtering.R
# Project: LearningR

# INSTALL & LOAD PKGS ####

# pacman must already be installed; then load contributed
# packages (including pacman) with pacman
install.packages('pacman')
pacman::p_load(pacman, rio, tidyverse)

# LOAD & PREP DATA ####

# Mac
df <- import('~/Desktop/Dev/learning-r/data/StateData.xlsx') %>%
  as_tibble() %>%
  select(
    state_code,
    region,
    psychRegions,
    instagram:modernDance
  ) %>%
  mutate(psychRegions = as.factor(psychRegions)) %>%
  # rename(y = psychRegions) %>%
  print()

# FILTER BY 1 VAR ####

# 'entrepreneur' is a quantitative var
df %>%
  filter(entrepreneur > 1) %>%
  print()

# 'region' is a char var
df %>%
  filter(region == "South") %>%
  print()

# 'psychRegion' is a factor (enhanced char var)
df %>%
  filter(psychRegions == "Relaxed and Creative") %>%
  print()

# FILTER BY MULT VAR ####

# 'or' is the vertical pipe |
df %>%
  filter(region == "South" | psychRegions == 'Relaxed and Creative') %>%
  print()

# 'and' is the ampersand &
df %>%
  filter(region == "South" & psychRegions == 'Relaxed and Creative') %>%
  print()

# 'not' is the exclamation point !
df %>%
  filter(region == "South" & !psychRegions == 'Relaxed and Creative') %>%
  print()

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
