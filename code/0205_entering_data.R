# File:     0205_entering_data.R
# Project:  Learning R

# Basic Commands ####

2 + 2       # simple math: press CTRL+ENTER to run

1:100       # sequence (use colon)

print('Hello world') # print text

# Assigning Values ####

a <- 1      # use <- not = (= is for arguments) "a gets 1"
2 -> b      # but it's bad form the other way
c <- d <- e <- 3 # multiple variables is OK

x <- c(1, 2, 5, 9)  # multiple VALUES OK too "c" = concat
x           # print x in the console (4 values)

# Sequences ####

0:10        # 0 to 10
10:0        # 10 to 0
seq(10)     # 1 to 10
seq(30, 0, by = -3) # start, end, iter: countdown by 3

# Basic Math ####

(y <- c(5, 10, 15, 19)) # surround with () to also print
x + y       # add every value of x to every value of y
x * 2       # multiple every value in x by 2
2^6         # exponents
sqrt(64)    # sqrt
log(100)    # natural log (base e = 2.71828...)
log10(100)  # base 10 log

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
