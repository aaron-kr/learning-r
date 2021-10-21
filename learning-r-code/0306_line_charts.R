# File:    0306_line_charts.R
# Project: LearningR

# INSTALL & LOAD PKGS ####

# pacman must already be installed; then load contributed
# packages (including pacman) with pacman
pacman::p_load(pacman, tidyverse)

# LOAD DATA ####

library(datasets)

# SINGLE TIME SERIES ####

# US population over time
?uspop # Get info about the data
uspop

?ts # Get info about Time Series objects

# Default plot
plot(uspop)

# Plot with options
uspop %>%
  plot(
    main = 'US Population 1790-1970',
    sub  = '(Source: datasets::uspop)',
    xlab = 'Year',
    ylab = 'Population (millions)'
  )
abline(v = 1930, col = 'lightgray')
text(1930, 10, '1930', col = 'red3')
abline(v = 1940, col = 'lightgray')
text(1940, 2, '1940', col = 'red3')

# Plot with ts.plot()
?ts.plot
ts.plot() # Can be used for single time series, but plot() is easier / preferred

# Plot with plot.ts()
?plot.ts
plot.ts(uspop) # More powerful alternative

# MULTIPLE TIME SERIES ####

?EuStockMarkets
EuStockMarkets

# Three different functions
plot(EuStockMarkets)    # stacked windows
plot.ts(EuStockMarkets) # identical
ts.plot(EuStockMarkets) # single window

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
