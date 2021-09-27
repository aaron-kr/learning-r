# File:    0302_barcharts.R
# Project: LearningR

# INSTALL & LOAD PKGS ####

# pacman must already be installed; then load contributed
# packages (including pacman) with pacman
pacman::p_load(pacman, tidyverse)

# LOAD DATA ####

# Using the diamonds dataset from ggplot2
?diamonds # info
diamonds  # show beginning of data

# BARPLOT FREQ ####

?plot    # info on "Generic XY Plotting"
?barplot # info on "Bar Plots"

# Shortest method to make a barplot
plot(diamonds$cut)

# Similar process using pipes
diamonds %>%
  select(color) %>%
  plot()

# But barplot() with pipes doesn't work
diamonds %>%
  select(clarity) %>%
  barplot() # Error: height must be vector or matrix

# Create frequency vector with table()

?table

diamonds %>%
  select(clarity) %>%
  table() %>% # put data in appropriate format (table)
  barplot()

# Sort bars by decreasing values (not for ordinal X)

diamonds %>%
  select(clarity) %>%
  table() %>%
  sort(decreasing = T) %>%
  barplot()

# Add options to plot
diamonds %>%
  select(clarity) %>%
  table() %>%
  barplot(
    main   = 'Clarity of diamonds',         # top
    sub    = '(Source: ggplot2::diamonds)', # bottom
    horiz  = T,                             # draw horizontal bars
    ylab   = 'Clarity',                     # Flip axis labels
    xlab   = 'Frequency',
    xlim   = c(0,15000),                    # limit for x-axis
    border = NA,                            # No borders on the bars
    col    = cm.colors(8)
  )

# SIDE-BY-SIDE BARPLOT ####

# 100% stacked bar

diamonds %>%
  select(color, clarity) %>%
  plot()

# Stacked bars
# Step ONE: Create table

df <- diamonds %>%
  select(color, clarity) %>%
  table() %>%
  print()

# Step TWO: Create graph

df %>%
  barplot(legend = rownames(.)) # Draw plot w/legend

# Step THREE: side-by-side

df %>%
  barplot(
    legend = rownames(.), # Dot is placeholder for pipe
    beside = T # side-by-side
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
