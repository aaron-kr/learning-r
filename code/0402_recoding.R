# File:    0402_recoding.R
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

# COMBINE CATEGORIES WITH RECODE ####

df %>%
  mutate(
    relaxed = recode(
      psychRegions,
      "Relaxed and Creative" = "yes",
      "Friendly and Conventional" = "no",
      .default = "no"
      )
    ) %>%
  select(state_code, psychRegions, relaxed)

# CREATE CATEGORIES WITH CASE_WHEN ####

# case_when works differently so save as df2
df2 <- df %>%
  mutate(
    likeArts = case_when(
      museum > 1 | scrapbook > 1 | modernDance > 1 ~ "yes",
      TRUE ~ 'no' # all other values
    )
  )

df2 %>%
  select(state_code, likeArts, museum:modernDance) %>%
  arrange(desc(likeArts)) %>%
  print(n = Inf)

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
