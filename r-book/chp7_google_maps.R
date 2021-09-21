# File:     07_google_maps.R
# Project:  Learning R

# I suppose most of this chapter needs to be figured out / rewritten due to the API issue

# First Map ####

install.packages('ggmap') # new one direct from GitHub needed
library(ggmap)

gc <- geocode(enc2utf8('Seoul')) # Geocode API, enc2utf8 for Hangul if necessary
# geocode(location, ...)

cen <- as.numeric(gc) # numeric geocode

map <- get_googlemap(center=cen) # get data
# get_googlemap(center, zoom, size, maptype, ...)
# zoom 3 = continent, 21 = building, 10 = city (default)
# size = default = c(640,640)
# maptype = 'terrain', 'satellite', 'roadmap', 'hybrid'

ggmap(map) # draw / plot map
# ggmap(ggmap, extent='panel', ...)
# extent = 'normal', 'device', 'panel' (how much full screen do you want?)

## More Exercises ====

gc <- geocode(enc2utf8('충청북도 단양군'))
cen <- as.numeric(gc)
map <- get_googlemap(center=cen, maptype='terrain')
ggmap(map)

map <- get_googlemap(center=cen, maptype='roadmap')
ggmap(map, extent='device')

gc <- geocode(enc2utf8('충청북도 단양군'))
cen <- as.numeric(gc)
map <- get_googlemap(center=cen, maptype='roadmap', marker=gc)
ggmap(map, extent='device')

## Multiple Locations ====

install.packages('ggplot2')
library(ggplot2)

names <- c('1. Hanok Village', '2. Gaeksa', '3. Gamyeong', '4. Poongnam Mun')

addr <- c('전주시', '전주시', '전주시', '전주시')

gc <- geocode(enc2utf8(addr))
gc

df <- data.frame(name=names, lon=gc$lon, lat=gc$lat)
df

cen <- c(mean(df$lon), mean(df$lat))
cen

map <- get_googlemap(center=cen, maptype='roadmap', zoom=11, marker=gc)
ggmap(map)

# Add Text
gmap + geom_text(data=df, aes(x=lon, y=lat), size=5, label=df$name)
# geom_text(data=NULL, aes, size, label, ...)

# Add Legend
map <- get_googlemap(center=cen, maptype='roadmap', zoom=11)
gmap <- ggmap(map, extent='device', legend='topright')

gmap + geom_text(data=df, aes(lon, lat, color=factor(name)), size=10, label=seq_along(df$name))

# Mapping Earthquakes ####

library(ggmap)

df <- head(quakes, 100)
df

cen <- c(mean(df$long), mean(df$lat))
cen

gc <- data.frame(lon=df$long, lat=df$lat)

gc$lon <- ifelse(gc$lon > 180, -(360-gc$lon), gc$lon)
gc

map <- get_googlemap(center=cen, scale=1, maptype='roadmap', zoom=4, marker=gc)

ggmap(map, extent='device')

# Show Magnitude
map <- get_googlemap(center=cen, scale=1, maptype='roadmap', zoom=5)

ggmap(map, extent='device') + geom_point(data=df, aes(x=long, y=lat, size=mag), alpha=0.5)
# geom_point(data=NULL, aes, alpha, ...)

# Homework: Show Ediya locations? I guess.

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