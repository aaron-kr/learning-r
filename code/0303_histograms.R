# File:    0303_histograms.R
# Project: LearningR

# INSTALL & LOAD PKGS ####

# pacman must already be installed; then load contributed
# packages (including pacman) with pacman
pacman::p_load(pacman, tidyverse)

# LOAD DATA ####

# Using the diamonds dataset from ggplot2
?diamonds # info
diamonds  # show beginning of data

# HISTOGRAMS ####

?hist

# Histogram with defaults
hist(diamonds$price)

# Histogram with options

hist(
  diamonds$price,
  breaks  = 7, # suggest number of breaks
  main   = 'Histogram of Diamond Price',
  sub    = '(Source: ggplot2::diamonds)',
  ylab   = 'Frequency',
  xlab   = 'Price',
  border = NA,
  col    = cm.colors(10)
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
