# File:     aaron_big_data_midterm.R
# Project:  Learning R (Book)

# Chp 5 : Charts ###############################################################

## 3D Pie Chart ================================================================

grades <- c('A+', 'A', 'B+', 'B', 'C+', 'C')
dist <- c(12.5, 17.5, 35.5, 24.5, 15.5, 14.5)
labels <- paste(grades, dist, '%')

library(plotrix)

pie3D(dist,
      col = rainbow(length(dist)),
      labels = labels,
      explode = 0.05,
      border = 'black',
      theta = 1,
      labelcex = 1,
      # start = 90,
      height = 0.1,
      shade = 0.7,
      main = "Distribution of Grades")

# Chp 7 : Maps #################################################################

## Jeonju Restaurants ==========================================================

names <- c('1. Hanok Village', '2. Gaeksa', '3. Gamyeong', '4. Poongnam Mun')
addr <- c('전주시', '전주시', '전주시', '전주시')
