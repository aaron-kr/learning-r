# File:     0206_data_types.R
# Project:  Learning R

# DATA TYPES ####

## Numeric ====
n1 <- 15        # Double by default
n1
typeof(n1)

n2 <- 1.5
n2
typeof(n2)

## Characters ====

c1 <- "c"
c1
typeof(c1)

c2 <- "simple string"
c2
typeof(c2)      # type is also "character"

## Logical ====

l1 <- TRUE
l1
typeof(l1)

l2 <- F
l2
typeof(l2)

# DATA STRUCTURES ####

## Vectors ====

# even if a single value, still a vector
v1 <- c(1,2,3,4,5)
v1
typeof(v1)
is.vector(v1)

v2 <- c('a', 'b', 'c')
v2
typeof(v2)
is.vector(v2)

v3 <- c(F,T,FALSE,TRUE)
v3
typeof(v3)
is.vector(v3)

## Matrices ====

# matrices only work if ALL the same data types
m1 <- matrix(c(T,T,F,F,T,F), nrow = 2)
m1

m2 <- matrix(c('a','b',
               'c','d'),
             nrow = 2,
             byrow = 1)
m2

## Arrays ====

# more flexibility with arrays than matrices
# give DATA, then DIMENSIONS (rows, columns, tables)
a1 = array(c(1:24), c(4, 3, 2))
a1

## Data Frame ====

# these are more common than matrices or arrays
# allows collections of different data types
vNum <- c(1,2,3)
vChar <- c('a','b','c')
vLog <- c(T,F,T)

df1 <- cbind(vNum, vChar, vLog) # coerces all to simplest data type (Char)
df1

df2 <- as.data.frame(cbind(vNum, vChar, vLog)) # TRUE data frame (diff types)
df2

## List ====

# loosest kind of data type (sometimes good for XML or JSON, but hard to work w)
o1 <- c(5, 6, 7, 8, 9)
o2 <- c('a','e','i','o','u','y')
o3 <- c(T,F,F,T)

list1 <- list(o1,o2,o3)
list1

list2 <- list(o1,o2,o3,list1) # nested lists
list2

# COERCING TYPES ####

## Automatic Coersion ====

# Goes to least restrictive data type by default
(coerce1 <- c(1,'b',T))
typeof(coerce1)

## Numeric to Int ====

coerce2 <- 5
typeof(coerce2)

coerce3 <- as.integer(5)
typeof(coerce3)

## Char to Numeric ====

co4 <- c('1','2','3')
typeof(co4)

co5 <- as.numeric(c('1'))
typeof(co5)

## Matrix to Data Frame ====

(co6 <- matrix(c(1:9), nrow = 3))
is.matrix(co6)

(co7 <- as.data.frame(matrix(c(1:9), nrow = 3)))
is.data.frame(co7)

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
