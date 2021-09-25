# File:     chp4_all_code.R
# Project:  Learning R (Book)

# CHARTS ####

## Pie Chart ====

x <- c(9,15,20,6)

label <- c('Team 1', 'Team 2', 'Team 3', 'Team 4')

pie(x, labels=label, main='First Pie Chart') # @TODO: Check func

## Bar Chart ====

height <- c(9,15,20,6)

name <- c('Team 1', 'Team 2', 'Team 3', 'Team 4')

barplot(height, names.arg=name, main='First Bar Chart', col=rainbow(length(height)), xlab='Team', ylab='USD (mil)')

# ANIMATION ####

install.packages('animation')

library(animation)

ani.options(interval = 1)

plot.new()

for(i in 10:0) {
  rect(0,0,1,1,col='orange')
  text(0.5,0.5,i,cex=5,col=rgb(.9,.2,.2,.7))
  ani.pause()
}

# GOOGLE MAPS ####

install.packages('ggplot2')
install.packages('RgoogleMaps')
# install.packages('ggmap')
if(!requireNamespace("devtools")) install.packages("devtools")
devtools::install_github("dkahle/ggmap")

library(ggplot2)
library(RgoogleMaps)
library(ggmap)

register_google(key='AIzaSyD4XKkpfbLgTs-Kir7PNVrV84e8KxTlpPI', write=T)

names <- c('My house', 'Burstad\'s')

addr <- c('1907 Kennedy Ave. Rock Springs, WY', '1901 Kennedy Ave. Rock Springs, WY')

gc <- geocode(enc2utf8(addr)) # If addr are in Korean, use enc2utf8()
gc

df <- data.frame(name=names, lon=gc$lon, lat=gc$lat)
df

cen <- c(mean(df$lon), mean(df$lat))
cen

map <- get_googlemap(center=cen, maptype='roadmap', zoom=11, marker=gc)

ggmap(map, fullpage=TRUE)

# WORD CLOUD ####

install.packages('wordcloud')
install.packages('RColorBrewer')
library(wordcloud)
library(RColorBrewer)

pal2 <- brewer.pal(8, 'Dark2')

x <- c('Aaron', 'Sarah', 'Isaac', 'Jenna')
y <- c(41, 40, 11, 9)

wordcloud(x,y,colors=pal2)

# COIN FLIP SIMULATION ####

iteration <- 5000

plot(0,0,xlab='# Coin flip', ylab='Heads or Tails', xlim=c(0,iteration), ylim=c(0,1))

abline(a=0.5, b=0, col='red')

sum <- 0

for(x in 1:iteration) {
  y <- sample(c('Heads', 'Tails'),1,replace=T)

  if(y == 'Heads')
    sum = sum + 1

  prob <- sum / x

  points(x,prob)
}

# Clear packages
detach("package:ggmap", unload = TRUE)  # For base

# Clear plots
dev.off()  # But only if there IS a plot

# Clear console
cat("\014")  # ctrl+L

# Clear mind :)
