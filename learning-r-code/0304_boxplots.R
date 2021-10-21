# File:    0304_boxplots.R
# Project: LearningR

# INSTALL & LOAD PKGS ####

# pacman must already be installed; then load contributed
# packages (including pacman) with pacman
pacman::p_load(pacman, tidyverse)

# LOAD DATA ####

# Using the diamonds dataset from ggplot2
?diamonds # info
diamonds  # show beginning of data

# BOXPLOTS ####

?plot    # info on "Generic XY Plotting"
?boxplot # info on "Bar Plots"

# Boxplot with defaults
boxplot(diamonds$price)

# Using pipes
diamonds %>%
  select(price) %>%
  boxplot()

# With options

diamonds %>%
  select(price) %>%
  boxplot(
    horizontal = T, # horiz
    notch      = T, # confidence interval for median
    main       = 'Boxplot of Diamond Price',
    sub        = '(Source: ggplot2::diamonds)',
    xlab       = 'Diamond Price',
    col        = heat.colors(3)
  )

# BOXPLOTS BY GROUP ####

# Boxplots by group using plot()
diamonds %>%
  select(color, price) %>%
  plot()

# With options
diamonds %>%
  select(color, price) %>%
  boxplot(
    price ~ color, # Tilde = formula
    data  = .,     # Dot is placeholder for pipe
    col   = heat.colors(10)
  )

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
