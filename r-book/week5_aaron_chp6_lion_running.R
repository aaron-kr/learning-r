# Chp 6 (week 5) homework - animate the lion running (back and forth if possible - lion_3, lion_4.png make)

# 6.5 ?Ê¥?? ??????

# ?Ê¥?? ?Ë≠???? ????
install.packages("imager")
library(imager)

# img_path <- "C://data/roulette.png"
img_path <- "D://Desktop//Dev//learning-r//hanbat//Chapter6/roulette.png"
img <- load.image(img_path)
plot(img)

# ?Ê¥?? ?Ë≠???? ?Å¨?? ???ôò
img <- resize(img, size_x = 400L, size_y = 400L)
plot(img, xlim=c(0, 400), ylim=c(0, 400))

plot(img, xlim=c(0, 400), ylim=c(0, 400), axes=FALSE)

# ?Ê¥?? ?öå??
rot.count <- sample(11:20, 1)
rot.count

angle <- 0
for(i in 1:rot.count) {
  angle <- angle + 36
  title <- paste("?Ê¥?? ?öå??:", i, "/", rot.count)
  
  imrotate(img,
           angle,
           cx=200, cy=200) %>%
    draw_circle(x=200, y=30,
                radius=30,
                col=c(1,0,0,0), opacity = 0.5) %>%
    plot(axes=FALSE, main=title)
  Sys.sleep(0.2)
}

# 6.6 ???ÊΩ?? ?Çπ

# ?Ë≠???? ??ñ®??? ?Å¨?? ????
install.packages("magick")
library(magick)

install.packages('OpenImageR')
library(OpenImageR)

lion_bg <- image_read("D://Desktop//Dev//learning-r//hanbat//Chapter6//bg11.jpg")
lion_1 <- image_read("D://Desktop//Dev//learning-r//hanbat//Chapter6//lion_1.png")
lion_2 <- image_read("D://Desktop//Dev//learning-r//hanbat//Chapter6//lion_2.png")
lion_3 <- image_read("D://Desktop//Dev//learning-r//hanbat//Chapter6//lion_3.png")
lion_4 <- image_read("D://Desktop//Dev//learning-r//hanbat//Chapter6//lion_4.png")

lion_bg <- image_scale(lion_bg,"600x300!")
lion_1 <- image_scale(lion_1,"100x50!")
lion_2 <- image_scale(lion_2,"100x50!")
lion_3 <- image_scale(lion_3,"100x50!")
lion_4 <- image_scale(lion_4,"100x50!")

print(lion_bg)
print(lion_3)
print(lion_4)

# ?Ë≠???? ?Ê¨?? ?Ë¨???ä∏
img <- image_composite(lion_bg, lion_1, offset = "+100+200")
print(img)

# ?Ë≠???? ?Áµ??
moving <- 0
x <- -300
y <- 150
while(TRUE) {
  
  # Moving in x direction
  if (x < 0) {
    # moving LEFT
    position <- paste(x, "+", y, sep="")
    print(position)
    
    if (moving %% 2 == 0) {
      img <- image_composite(lion_bg, lion_3,
                             offset = position)
    } else {
      img <- image_composite(lion_bg, lion_4,
                             offset = position)
    }
  }
  else {
    # moving RIGHT
    position <- paste("+", x, "+", y, sep="")
    print(position)
    
    if (moving %% 2 == 0) {
      img <- image_composite(lion_bg, lion_1,
                             offset = position)
    } else {
      img <- image_composite(lion_bg, lion_2,
                             offset = position)
    }
  }
  
  print(img)
  Sys.sleep(0.3)
  if (x > 600) 
    break
  moving <- moving + 1
  x <- x + 20
}
