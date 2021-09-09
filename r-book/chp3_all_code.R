# File:     0205_entering_data.R
# Project:  Learning R

# Data Types ####

x <- c(80,85,70) # assignment
x

c(80,85,70) -> x # not the right direction though
x

x <- c(80) # concatenate
x

x <- 80
x

# Math Operators ####

# +, -, *, /, ^ or **, %% modulus, %/% int result of division without remainder

x <- 5+2 # add ?????????
x

x <- 5/3 # divide ?????????
x

x <- 5^2 # power ????????????
x

x <- 5%%3 # remainder 5??? 3?????? ???????????? ?????????
x

x <- 5%/%3 # opposite of remainder (how many times in) 5??? 3?????? ???????????? ???
x

## Vector Math ====

x <- c(1,2,3,4)
y <- c(2,3,4,5)
z <- c(1,2)

w <- x+5
w

w <- y/2
w

w <- x+z # x(1,2,3,4) + z(1,2,1,2)
w

w <- x/z
w

w <- z/x
w

## Different Data Types ====

x <- c(1,2,3)
x

y <- c('A','B','C')
y

y <- c('A',1,2)
y

z <- y+1 # Error

# Comparison Operators ####

# <, <=, >, >=, ==, !=

x <- 5<3
x

y <- c(10,20,30)
z <- y<=10
z # TRUE FALSE FALSE

## Logical operators ====

# | or, & and, ! not, isTRUE(x) opposite of !

x <- TRUE
y <- FALSE
x | y

x & y

x <- 3
!x

isTRUE(y)

z <- c(T,F,F)
z|y # T F F

# Sequences ####

x <- seq(1,10)
x

x <- 1:10 # same as above
x

x <- seq(10,1)
x

y <- 10:1 # same as above
y

x <- seq(1,10,by=3) # count by 3s
x # 1 4 7 10

y <- seq(1,10,length.out=5) # make an even division of 5 numbers (like graph)
y # 1.00 3.25 5.50 7.75 10.00

## Repeating ====

# Package: base, func: rep(x, times|each)

x <- c(1,2,3)
rep(x, times=2) # 1 2 3 1 2 3
rep(x, times=3) # 1 2 3 1 2 3 1 2 3

rep(x, each=2) # 1 1 2 2 3 3
rep(x, each=3) # 1 1 1 2 2 2 3 3 3

# Vectors ####

x <- c(1,2,3,4,5)
x[2] # 2nd one (NOT counting from 0 index)

x[c(1,3,5)] # getting all THREE of these indexes

x[-c(2,4)] # EXCLUDING these indexes

x[x>2] # anything where the value is >2

x[x>=2 & x<=4] # anything where it matches the conditions

x[2] <- 20
x # 1 20 3 4 5

x[c(3,4)] <- 15
x # 1 20 15 15 5

x[x<=15] <- 10
x # 10 20 10 10 10

## Vector Math Functions ====

# sum(x), mean(x), var(x), sd(x), sqrt(x), length(x), abs(x)

x <- seq(1:10)
sum(x) # 55

mean(x) # 5

var(x) # 9.166667 x ????????? ?????? ????????? ??????

sd(x) # 3.02765 x ????????? ?????? ????????? ????????????

sqrt(x) # calcs EACH value's sqrt() - 10 different values

length(x) # 10

x <- c(1,2,-3)
abs(x) # 1 2 3

# NULL Values ####

# NULL, NA (Not available), NaN

x <- NULL
is.null(x) # TRUE

y <- c(1,2,3,NA,5)
y # 1 2 3 NA 5

z <- 10/0
z # Inf

w <- 0/0
w # NaN

# Data Containers ####

## Arrays ====

# Package: base, func: array(data, dim, [dimnames]) ???=row, ???=col

x <- array(1:3, dim=c(3))
x # 1 2 3

x <- array(1:6, dim=c(2,3))
x # 2 rows, 3 cols, data = col1:1,2, col2:3,4, col3:5,6

x <- array(c(2,4,6,8,10,12), dim=c(2,3))
x # similar as above, diff vals

x[1,3] # row 1, col 3 = 10

x[,3] # no row, all of col 3 = 10 12

x[,-3] # no row, everything except col 3 (array)

x[1,2] <- 20 # change row 1, col 2 to 20
x

names <- list(c('Row 1','Row 2'), c('Col 1','Col 2','Col 3')) # name them
x <- array(c(2,4,6,8,10,12), dim=c(2,3), dimnames=names)
x

x['Row 1'] # 2 6 10

x <- array(1:24, dim=(2,3,4)) # 2 rows, 3 cols, 4 tables
x

## Matrices ====

# Package: base, func: matrix(data, nrow, ncol|byrow, [dimnames])

x <- matrix(1:6, nrow=2) # same as array(1:6, dim=c(2,3))
x

x <- matrix(1:6, nrow=2, byrow=TRUE) # change the data order, now it goes horz
x

x[1,3] # row 1, col 3 = 3

names <- list(c('Row 1','Row 2'), c('Col 1','Col 2','Col 3'))
matrix

v1 <- c(1,2,3,4)
v2 <- c(5,6,7,8)
v3 <- c(9,10,11,12)
x <- cbind(v1,v2,v3) # column bind = give col the vector names v1,v2,v3
x

rownames(x) <- c('Row 1', 'Row 2', 'Row 3', 'Row 4')
x

colnames(x) <- c('Col 1', 'Col 2', 'Col 3')
x

rbind(v1,v2,v3) # row bind = now give rows the vectors, it changes the shape

## Lists ====

# Package: base, func: list(...)

x <- list('?????????','2016001',20,c('IT??????','????????? ??????'))
x

y <- list('name'='?????????','num'='2016001','age'=20,'classes'=c('IT??????','????????? ??????'))
y

y['name']
y[['name']]
y$name

## Data Frames ====

# Package: base, func: data.frame(..., row.names=NULL)

x <- data.frame(name=c('Aaron','Sarah'), age=c(30,20), address=c('Jeonju','Gosan'))
x

x <- cbind(x, dept=c('IT','Art')) # add new column
x

x <- rbind(x,data.frame(name='Isaac', age=10, address='US', dept='4th')) # add row
x

x[3,2] # row 3, col 2 = 10

x[3,] # row 3 = all Isaac's info

x[,2] # col 2 = all age info

x[-2,] # NOT row 2 = NOT Sarah's info

x['dept'] # all dept info in a table

x$dept # all dept info in a vector

x$dept[2] # only 2nd dept info = 'Art'

x[1,2] <- 21 # change row 1 (Aaron), col 2 (age) to 21
x

x[1, 'age'] <- 22 # same as above, but by col name, not num
x

str(x) # shows data type - all data = Factor w / X levels, except 'age'

x[3] <- lapply(x[3], as.character) # change address col to char (not Factor)
str(x)

x[3,3] <- 'Korea'
x

# Reading Data Files ####

library(help=datasets)
data()

quakes # quakes dataset

head(quakes, n=10) # read beginning of dataset to 10 rows

tail(quakes, n=6) # read in end of dataset to 6 rows

names(quakes) # get the column names

str(quakes) # find the data types in each column of the data.frame

dim(quakes) # 1000 5 (rows, cols)

summary(quakes) # Min., 1st Qu., Median, Mean, 3rd Qu., Max.,

summary(quakes$mag) # only find above values for specified col

## Data File Resources ====

# Datasets in R packages:
# http://www.public.iastate.edu/~hofmann/data_in_r_sortable.html
# https://vincentarelbundock.github.io/Rdatasets/datasets.html

# Free Datasets in R directory:
# https://r-dir.com/reference/datasets.html

# Resources on R and Data Mining: Free Datasets
# http://www.rdatamining.com/resources/data

## Reading From files or GitHub ====
write.table(quakes, 'c:/temp/quakes.txt', sep=',') # Write a CSV to disk from data

x <- read.csv('c:/temp/quakes.txt', header=T) # header = TRUE
x

# also, above, sep='\r' for returns as sep, or read.table('...', sep=',')

x <- read.csv(file.choose(), header=T) # allow ability to CHOOSE the file to open

url <- 'https://vincentarelbundock.github.io/Rdatasets/csv/datasets/Titanic.csv'
x <- read.csv(url)
x

# Making Functions ####

getCircleArea <- function(r)
  area = 3.14 * r^2
  return(area)
}

getCircleArea(3) # 28.26

# Clean Up ####

# Clear environment
rm(list = ls())

# Clear packages
detach("package:datasets", unload = TRUE)  # For base

# Clear plots
dev.off()  # But only if there IS a plot

# Clear console
cat("\014")  # ctrl+L

# Clear mind :)
