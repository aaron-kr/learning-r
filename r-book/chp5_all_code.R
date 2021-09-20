# File:     05_chart_programming.R
# Project:  Learning R (Book)

# CHARTS ####

## Pie Chart ====

### Normal ----

x <- c(9,15,20,6)

label <- c('Team 1', 'Team 2', 'Team 3', 'Team 4')

pie(x, labels=label, main='Workplace')
# pie(x, labels, clockwise=FALSE, init.angle=if(clockwise) 90 else 0, col=NULL, main=NULL, ...)

### Change Angle ----

pie(x, init.angle=90, labels=label, main="Workplace Angle")

### Add %, Change Color ----
pct <- round(x/sum(x)*100) # calc percentages

label <- paste(label, pct) # attach to labels

label <- paste(label,"%",sep="")

pie(x, labels=label, init.angle=90, col=rainbow(length(x)), main="Workplace Rainbow")
# col=rainbow(12), heat.colors(12), terrain.colors(12), topo.colors(12), cm.colors(12)

pie(x, labels=label, init.angle=90, col=heat.colors(length(x)), main="Workplace Heat")
pie(x, labels=label, init.angle=90, col=terrain.colors(length(x)), main="Workplace Terrain")
pie(x, labels=label, init.angle=90, col=topo.colors(length(x)), main="Workplace Topo")
pie(x, labels=label, init.angle=90, col=cm.colors(length(x)), main="Workplace CM")

### 3D ----

install.packages('plotrix')
library(plotrix)

pie3D(x, labels=label, explode=0.1, labelcex=0.8, main="Workplace 3D")

## Bar Chart ====

height <- c(9,15,20,6)

name <- c('Team 1', 'Team 2', 'Team 3', 'Team 4')

barplot(height, names.arg=name, main="Workplace Bar")
# barplot(height, width=1, names.arg=NULL, horiz=FALSE, col=NULL, main=NULL, sub=NULL, xlab=NULL, ylab=NULL, xlim=NULL, ylim=NULL, ...)

barplot(height, names.arg=name, main="Workplace Rainbow", col=rainbow(length(height)))

barplot(height, names.arg=name, main="Workplace Rainbow", col=rainbow(length(height)), xlab="Dept", ylab="USD (mil)")

barplot(height, names.arg=name, main="Workplace Rainbow", col=rainbow(length(height)), xlab="Dept", ylab="USD (mil)", ylim=c(0,25))

### With Text ----

bp <- barplot(height, names.arg=name, main="Workplace Rainbow", col=rainbow(length(height)), xlab="Dept", ylab="USD (mil)", ylim=c(0,25))
text(x=bp, y=height, labels=round(height, 0), pos=3)

text(x=bp, y=height, labels=round(height, 0), pos=1)

### Horizontal ----

barplot(height, names.arg=name, main="Workplace Horiz", col=rainbow(length(height)), xlab="USD (mil)", ylab="Dept", horiz=TRUE, width=50)

## Stacked / Grouped Bar Chart ====

height1 <- c(4,18,5,8)
height2 <- c(9,15,20,6)

height <- rbind(height1,height2)
height

name <- c('Team 1', 'Team 2', 'Team 3', 'Team 4')
legend_lbl <- c('2014', '2015')

### Stacked ----
barplot(height, main='Workplace Stacked', names.arg=name, xlab='Dept', ylab='USD (mil)', col=c('darkblue','darkgreen'), legend.text=legend_lbl, ylim=c(0,35))

### Grouped ----
barplot(height, main='Workplace Stacked', names.arg=name, xlab='Dept', ylab='USD (mil)', col=c('darkblue','darkgreen'), legend.text=legend_lbl, ylim=c(0,35), beside=TRUE, args.legend=list(x='top'))

## XY Plotting ====

weight <- women$weight
height <- women$height

plot(weight)

plot(height, weight, xlab='Height (cm)', ylab='Weight (kg)')

### Different Types ----

plot(height, weight, xlab='Height (cm)', ylab='Weight (kg)', type='p') # point (default)
plot(height, weight, xlab='Height (cm)', ylab='Weight (kg)', type='l') # line
plot(height, weight, xlab='Height (cm)', ylab='Weight (kg)', type='b') # both
plot(height, weight, xlab='Height (cm)', ylab='Weight (kg)', type='c') # both minus points
plot(height, weight, xlab='Height (cm)', ylab='Weight (kg)', type='o') # line ON points
plot(height, weight, xlab='Height (cm)', ylab='Weight (kg)', type='h') # bar chart lines
plot(height, weight, xlab='Height (cm)', ylab='Weight (kg)', type='s') # steps (horz first)
plot(height, weight, xlab='Height (cm)', ylab='Weight (kg)', type='S') # steps (vert first)
plot(height, weight, xlab='Height (cm)', ylab='Weight (kg)', type='n') # none

### Line Types ----
plot(height, weight, xlab='Height (cm)', ylab='Weight (kg)', type='l', lty=6, lwd=2) # lty = line type, lwd = line width, possible type = c(1:6)

plot(height, weight, xlab='Height (cm)', ylab='Weight (kg)', pch=23, col='blue', bg='yellow', cex=1.5)
# pch = Plotting Character
# cex = Character expansion
# 0: square, 1: circle, 2: triangle, 3: cross, 4: x, 5: diamond, 6: upside-down triangle, 7: box with x, 8: asterisk, 9: kite
# 10: circle with x, 11: star of David, 12: window, 13: circle with x out, 14: envelope
# 15: filled square, 16: filled sm circle, 17: filled triangle, 18: filled diamond, 19: filled big circle
# 20: filled dot, 21: filled circle (red?), 22: filled box (red?), 23: filled diamond (red?), 24: filled triangle (red?), 25: filled upside-down triangle (red?)
# @, +, %, #, A, a, B, b, S, `, ., ,, ?, *

## Histogram ====

mag <- quakes$mag
head(quakes)

mag

hist(mag, main='Earthquakes', xlab='Magnitude', ylab='Frequency')
# hist(x, breaks="Sturges", freq=NULL, probability=!freq, col=NULL, main=NULL, xlim=NULL, ylim=NULL, ...)

colors <- c('red', 'orange', 'yellow', 'green', 'blue', 'navy', 'violet')

hist(mag, main='Earthquakes', xlab='Magnitude', ylab='Frequency', col=colors, breaks=seq(4,6.5,by=0.5))

hist(mag, main='Earthquakes', xlab='Magnitude', ylab='Frequency', col=colors, breaks=seq(4,6.5,by=0.5), freq=FALSE)

lines(density(mag))

### Printing Differently ----

h <- hist(mag, breaks=seq(4,6.5,by=0.5))
h

h$density = h$counts / sum(h$counts)

plot(h,,freq=FALSE, main='Earthquakes', xlab='Magnitude', ylab='Frequency', col=colors)

hist(mag, main='Earthquakes', xlab='Magnitude', ylab='Frequency', col=colors, breaks='Sturges', freq=FALSE)

## Box Plot ====

mag <- quakes$mag

min(mag)

max(mag)

median(mag)

quantile(mag, c(0.25, 0.5, 0.75))

boxplot(mag, main='Earthquake', xlab='Earthquake', ylab='Frequency', col='red')
# This divides the data / graph into fourths (upper / lower fourth, etc)

## Homework? ====

# CDNow data source: https://raw.githubusercontent.com/cran/BTYD/master/data/cdnowElog.csv

url <- 'https://raw.githubusercontent.com/cran/BTYD/master/data/cdnowElog.csv'

data <- read.csv(url, header=T)

head(data)

quantity <- data$cds

table(quantity)

# NOW, print a histogram OR boxplot I guess?

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