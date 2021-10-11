# File:    0502_descriptives.R
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
    psychRegions,
    instagram:modernDance
  ) %>%
  mutate(psychRegions = as.factor(psychRegions)) %>%
  # rename(y = psychRegions) %>%
  print()

# SUMMARY ####

df %>% summary() # whole table (long)

df %>% # one var
  select(entrepreneur) %>%
  summary()

# QUARTILES ####

# John Tukey's five-number summary: min, lower, median, upper, max. No labels.
fivenum(df$entrepreneur) # 1st and 3rd are a bit different from summary(), others are the same

# Boxplot stats: hinges, n, CI for median, outliers
boxplot(df$entrepreneur, notch = T, horizontal = T)
boxplot.stats(df$entrepreneur)
# Output from this function:
# $stats = same as fivenum()
# $n = number of values
# $conf = confidence interval (defining the notch)
# $out = outliers

# ALTERNATIVE DESCRIPTIVES ####

p_load(psych)         # psych package (good for descriptive statistics and scaling)
p_help(psych, web = F) # Load help info in R Studio (not web)
# help() is a function from pacman

describe(df$entrepreneur) # single var
describe(df)              # whole table

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
