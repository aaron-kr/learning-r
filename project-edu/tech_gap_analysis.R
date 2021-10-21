# Technology Gap, Attitudes, Lifelong Learning

## Load Packages ###############################################################
install.packages('tidytext')
install.packages('R.utils')
install.packages('viridis')

library(tidyverse)
library(RColorBrewer)
library(tidytext)
library(R.utils)
library(wordcloud)
library(viridis)

# Skip the first line, read EVERYTHING in as a Factor
results <- read.csv(file.choose(), encoding = 'utf-8', skip = 1, colClasses = c(rep('factor', 54)))

### 1. Group by Nation =========================================================

### 2. Group by Job ============================================================

### 3. Totals ==================================================================

results %>%
  group_by(nation) %>%
  summarize(n = n())
