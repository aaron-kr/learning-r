# File:    0403_new_vars.R
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

# AVERAGE VARS ####

df %>%
  mutate(
    socialMedia = (instagram + facebook + retweet) / 3,
    artsCrafts = (museum + scrapbook + modernDance) / 3
  ) %>%
  select(state_code, socialMedia, artsCrafts)

# REVERSE CODING ####

df %>%
  mutate(
    outgoing = (volunteering + (privacy * -1)) / 2
  ) %>%
  select(state_code, volunteering, privacy)

# For 1-n scale, use (n+1) - x
# For 0-n scale, use n - x

# HELPFUL PACKAGES ####

# Packages "psych" and "scale" make this process much easier
browseURL('https://CRAN.R-project.org/package=psych') # author's preferred
browseURL('https://CRAN.R-project.org/package=Scale')

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
