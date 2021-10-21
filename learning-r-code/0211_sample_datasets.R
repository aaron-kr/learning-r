# File:     02011_sample_datasets.R
# Project:  Learning R

# INSTALL AND LOAD PACKAGES ####

# Load base packages manually
library(datasets) # for example datasets
?datasets
library(help = 'datasets')

# SOME SAMPLE DATASETS ####

# iris data # good for classification and clustering techniques
?iris
iris

# UCBAdmissions # good for working with tabular data
?UCBAdmissions
UCBAdmissions

# Titanic # machine learning = who survived? (Tabular data)
?Titanic
Titanic

# state.x77 # info about US demographics (old)
?state.x77
state.x77

# swiss # swiss data from 1888 - good for predictive data models
?swiss
swiss

# CLEAN UP #####################################################################

# Clear environment
rm(list = ls())

# Clear packages
p_unload(all) # unload all pacman packages
detach("package:datasets", unload = TRUE)  # For base

# Clear plots
dev.off()  # But only if there IS a plot

# Clear console
cat("\014")  # ctrl+L

# Clear mind :)
