# File:     0207_comments.R
# Project:  Learning R

# LEVEL ONE HEADER (ALL CAPS) ##################################################

## Level Two Header (Title Capitalization) =====================================

### Level three header (sentence capitalization) -------------------------------

# Make header comments go ALL the way to the margin to better
# divide up the document (or just use 4 if you're lazy~)

# CTRL+SHIFT+C = turn on/off comment

# CLEAN UP #####################################################################

# Clear environment
rm(list = ls())

# Clear packages
detach("package:datasets", unload = TRUE)  # For base

# Clear plots
dev.off()  # But only if there IS a plot

# Clear console
cat("\014")  # ctrl+L

# Clear mind :)
