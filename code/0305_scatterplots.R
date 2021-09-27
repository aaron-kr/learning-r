# File:    0305_scatterplots.R
# Project: LearningR

# INSTALL & LOAD PKGS ####

# pacman must already be installed; then load contributed
# packages (including pacman) with pacman
pacman::p_load(pacman, rio, tidyverse)

# LOAD & PREPARE DATA ####

df <- import('D:/Desktop/Dev/learning-r/data/StateData.xlsx') %>%
  as_tibble() %>%
  select(
    state_code,
    psychRegions,
    instagram:modernDance
  ) %>%
  mutate(psychRegions = as.factor(psychRegions)) %>%
  print()

# SCATTERPLOTS ####

df %>%
  select(instagram:modernDance) %>%
  plot() # Plot ALL associations

# Bivariate
df %>%
  select(scrapbook:modernDance) %>%
  plot() # with defaults

# Bivariate with options
df %>%
  select(scrapbook:modernDance) %>%
  plot(
    main = 'Scatterplot of Google Searches by State',
    xlab = 'Searches for \'scrapbook\'',
    ylab = 'Searches for \'modern dance\'',
    col  = rainbow(1),
    pch  = 20 # 'Plotting character" i.e. small circle
  )

?pch # see plotting character options

# Add fit linear regression line (y ~ x)
df %>%
  lm(modernDance ~ scrapbook, data = .) %>%
  abline()

# REMOVE OUTLIER ####

# Identify outlier

df %>%
  select(state_code, scrapbook) %>%
  filter(scrapbook > 4) %>% # Select outlier
  print()

df %>%
  select(scrapbook:modernDance) %>%
  filter(scrapbook < 4) %>% # Filter OUT outlier
  plot(
    main = 'Scatterplot of Google Searches by State',
    xlab = 'Searches for \'scrapbook\'',
    ylab = 'Searches for \'modern dance\'',
    col  = rainbow(1),
    pch  = 20 # 'Plotting character" i.e. small circle
  )

# Add fit linear regression line (y ~ x)
df %>%
  filter(scrapbook < 4) %>% # filter OUT outlier (again)
  lm(modernDance ~ scrapbook, data = .) %>%
  abline()

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
