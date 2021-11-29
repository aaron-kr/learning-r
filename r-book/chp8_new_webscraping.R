# File:     chp8_new_webscraping.R
# Project:  Learning R (New Book)

# Chp 8 : Webscraping ##########################################################

install.packages('rvest')
library(rvest)

## Data OPEN API Website =======================================================
url <- "https://www.data.go.kr/tcs/dss/selectDataSetList.do?dType=API&keyword=&detailKeyword=&publicDataPk=&recmSe=&detailText=&relatedKeyword=&commaNotInData=&commaAndData=&commaOrData=&must_not=&tabId=&dataSetCoreTf=&coreDataNm=&sort=updtDt&relRadio=&orgFullName=&orgFilter=&org=&orgSearch=&currentPage=1&perPage=10&brm=&instt=&svcType=&kwrdArray=&extsn=&coreDataNmArray=&pblonsipScopeCode="

html <- read_html(url)
html

# Title
title <- html_nodes(html, '#apiDataList .title') %>%
  html_text()
title

# Description
desc <- html_nodes(html, '#apiDataList .ellipsis') %>%
  html_text()
desc

# Clean up titles
ttitle <- gsub('\r\n\t', '', title)
ttitle <- trimws(title, 'both')
ttitle

# Clean up descriptions
tdesc <- gsub('\r\n\t', '', desc)
tdesc <- trimws(desc, 'both')
tdesc

# Build dataframe
api <- data.frame(ttitle, tdesc)
api

## Multi-page scraping =========================================================
url.api <- 'https://www.data.go.kr/tcs/dss/selectDataSetList.do?dType=API&keyword=&detailKeyword=&publicDataPk=&recmSe=&detailText=&relatedKeyword=&commaNotInData=&commaAndData=&commaOrData=&must_not=&tabId=&dataSetCoreTf=&coreDataNm=&sort=updtDt&relRadio=&orgFullName=&orgFilter=&org=&orgSearch=&perPage=10&brm=&instt=&svcType=&kwrdArray=&extsn=&coreDataNmArray=&pblonsipScopeCode=&currentPage='
titles <- NULL
descs <- NULL

for(page in 1:10) {
  url <- paste(url.api, page, sep='')
  html <- read_html(url)

  # Title
  title <- html_nodes(html, '#apiDataList .title') %>%
    html_text()
  title

  title <- gsub('\r\n\t', '', title)
  title <- trimws(title, 'both')

  titles <- c(titles, title)

  # Description
  desc <- html_nodes(html, '#apiDataList .ellipsis') %>%
    html_text()
  desc

  desc <- gsub('\r\n\t', '', desc)
  desc <- trimws(desc, 'both')

  descs <- c(descs, desc)
}

titles
descs

## Naver Webscraping ===========================================================
# 8.4 Exercises

# Install Packages (if not already)
#install.packages("rvest")
library(rvest)

# Read web document (Naver Movies)
url <- "https://movie.naver.com/movie/point/af/list.nhn"
html <- read_html(url)
html

# Get Review Nodes
review_cell <- html_nodes(html, "#old_content table tr .title")
review_cell

# Get scores
score <- html_nodes(review_cell, "em") %>%
  html_text()
score

# Review text
review <- review_cell %>%
  html_text()
review

# Review Data
# (1) Part before the Review
index.start <- regexpr("\t별점 -", review)
index.start

# (1) Part after the Review
index.end   <- regexpr("\t신고", review)
index.end

# (2) Extract Review
review <- substring(review, index.start, index.end)
review
review <- substring(review, 16)
review

# (3) Remove control spaces
review <- gsub("[|\n|\t\r]", "", review)
review

# (4) Trim whitespace
review <- trimws(review, "both")
review

## Multiple Naver pages ========================================================

url.page <- "https://movie.naver.com/movie/point/af/list.nhn?&page="

# Start and End page
page.start <- 1
page.end   <- 5

# Set as NULL for default
review.page <- NULL

# Repeat from first to last page
for(p in page.start:page.end) {

  # Add page number to page URL
  url <- paste(url.page, p, sep="")

  ## Begin 8.4 exercise code ##

  # Read the page
  html <- read_html(url)
  html

  # Get Review Nodes
  review_cell <- html_nodes(html, "#old_content table tr .title")
  review_cell

  # Get scores
  score <- html_nodes(review_cell, "em") %>%
    html_text()
  score

  # Review text
  review <- review_cell %>%
    html_text()
  review

  # Review Data
  # (1) Part before the Review
  index.start <- regexpr("\t별점 -", review)
  index.start

  # (1) Part after the Review
  index.end   <- regexpr("\t신고", review)
  index.end

  # (2) Extract Review
  review <- substring(review, index.start, index.end)
  review
  review <- substring(review, 16)
  review

  # (3) Remove control spaces
  review <- gsub("[|\n|\t\r]", "", review)
  review

  # (4) Trim whitespace
  review <- trimws(review, "both")
  review

  ## End 8.4 exercise code ##

  # Add Review to collection of Reviews
  review.page <- c(review.page, review)
}

# Print ALL the reviews
review.page

