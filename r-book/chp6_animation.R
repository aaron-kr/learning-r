# File:     06_animation.R
# Project:  Learning R

# Countdown ####

install.packages('animation') # investigate imager and magick
library(animation)

ani.options(interval = 1)

plot.new()

for(i in 10:0) {
  rect(0,0,1,1,col='magenta')
  size = 11 - i
  text(0.5,0.5,i,cex=size,col=rgb(0,0,0,1))
  ani.pause() # 1s pause
}

# ani.options(...)
# ani.pause(interval=ani.options('interval'))

# Logical Control Flow ####

## for ====

sum <- 0
x <- c(1,3,5,7,9)
for(i in x) {
  sum <- sum + i
}
print(sum)

## while ====

sum <- 0
while(i < 10) {
  sum <- sum + i
  i <- i+2
}
print(sum)

## break ====

sum <- 0
x <- seq(1,10)
for(i in x) {
  sum <- sum + i
  if(sum > 10)
    break
}
print(sum)

## next ====

sum <- 0
x <- seq(1,10)
for(i in x) {
  if (i %% 2 == 0) # if even
    next
  sum <- sum + i
}
print(sum)

## repeat ====

sum <- 0
x <- seq(1,10)
repeat {
  sum <- sum + i
  i <- i + 1
  if(i > 10)
    break
}
print(sum)

# Animated Chart ####

library(animation)

ani.options(interval = 1)

while(TRUE) { # Wait for ESC
  y <- runif(5,0,1)
  
  barplot(y, ylim=c(0,1), col=rainbow(5))
  
  ani.pause()
}

## Coin toss bar graph ====

plot.new()

count <- c(0,0,0)
for (n in 1:500) {
  coin <- sample(c(0,1), 2, replace = T)
  
  index <- sum(coin) + 1
  count[index] <- count[index] + 1
  
  probability <- count / n
  
  title <- paste('Repetition: ', n, "/500")
  
  barplot(probability,
          names.arg = c(0,1,2),
          xlab = 'Number on the front',
          ylab = 'Rate',
          col = rainbow(3),
          main = title)
  
  Sys.sleep(0.05)
}

# Animated Picture ####

library(animation)
library(png)

ani.options(interval = 0.01)

plot.new()

rect(0,0,1,1,col='white')

for(i in 1:4) {
  
  img <- paste('D:/Desktop/Dev/learning-r/img/sonic',i,'.png',sep='')
  
  img <- readPNG(img)
  
  rasterImage(img,0,0,1,1)
  # rasterImage(image, xleft, ybottom, xright, ytop)
  
  ani.pause()
}

dev.off() # device off (PNG I guess?)

# Homework = 

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