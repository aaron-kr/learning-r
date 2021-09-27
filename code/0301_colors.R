# File:    0301_colors.R
# Project: LearningR

# LOAD DATA ####

x = c(24, 13, 7, 5, 3, 2) # sample data
barplot(x)                # default barplot

# COLORS ####

# Color names R has 657 color names for 502 unique colors,
# arranged alphabetically except white, which is first
# Multi-names: due to British + American spellings, white, etc

?colors
colors()

# Web page with R colors swatches, color names, hex codes,
# RGB codes (in 0-255 and 0.00-1.00), R index numbers;
# Browsable table on the page or in Google Sheets;
# download as XLSX or PDF
browseURL('https://datalab.cc/rcolors')

# USE COLORS ####

# Color names

barplot(x, col = 'red3')
barplot(x, col = 'slategray3')

# RGB triplets (0.00-1.00)
barplot(x, col = rgb(.80, 0, 0)) # red3
barplot(x, col = rgb(.63, .71, .8)) # slategray3

# RGB triplets (0-255)
barplot(x, col = rgb(205, 0, 0, max = 255)) # red3 (specify max for 0-255)
barplot(x, col = rgb(159, 182, 205, max = 255)) # slategray3

# RGB hexcodes
barplot(x, col = '#cd0000') # red3
barplot(x, col = '#9fb6cd') # slategray3

# Index numbers in R's alphabetical list
barplot(x, col = colors()[555]) # red3
barplot(x, col = colors()[602]) # slategray3

# MULTIPLE COLORS ####

# Specify colors in a vector which cycles through them
barplot(x, col = c('red3', 'slategray3'))

# USING COLOR PALETTES ####

?palette  # info on palettes
palette() # see current palette

barplot(x, col = 1:6)               # use current palette
barplot(x, col = rainbow(6))        # rainbow palette
barplot(x, col = heat.colors(6))    # yellow through red
barplot(x, col = terrain.colors(6)) # gray through green
barplot(x, col = topo.colors(6))    # purple through tan
barplot(x, col = cm.colors(6))      # pinks and blues

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
