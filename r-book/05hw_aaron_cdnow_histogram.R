# File:     05hw_cdnow_histogram.R
# Project:  Learning R

# CDNow data source
url <- "https://raw.githubusercontent.com/cran/BTYD/master/data/cdnowElog.csv"

# Read data
data <- read.csv(url, header = T)

# Preview data
head(data)

# Create table from quantity
quantity <- data$cds
table(quantity)

# Create histogram
?hist

hist(
  quantity,
  main = 'CD Sales Volume',
  xlab = 'Volume',
  ylab = 'Frequency',
  col = rainbow(8)
)
