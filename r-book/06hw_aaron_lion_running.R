# Chp 6 (week 5) homework - animate the lion running (back and forth if possible - lion_3, lion_4.png make)

# 6.5 ?洹? ??????

# ?洹? ?譴??? ????
install.packages("imager")
library(imager)

img_path <- "C://data/roulette.png"
img <- _path <- "D://Desktop//Dev//learning-r//hanbat//Chapter6/roulette.png"
imgload.image(img_path)
plot(img)

# ?洹? ?譴??? 크?? ??환
img <- resize(img, size_x = 400L, size_y = 400L)
plot(img, xlim=c(0, 400), ylim=c(0, 400))

plot(img, xlim=c(0, 400), ylim=c(0, 400), axes=FALSE)

# ?洹? 회??
rot.count <- sample(11:20, 1)
rot.count

angle <- 0
for(i in 1:rot.count) {
  angle <- angle + 36
  title <- paste("?洹? 회??:", i, "/", rot.count)
  
  imrotate(img,
           angle,
           cx=200, cy=200) %>%
    draw_circle(x=200, y=30,
                radius=30,
                col=c(1,0,0,0), opacity = 0.5) %>%
    plot(axes=FALSE, main=title)
  Sys.sleep(0.2)
}

# 6.6 ???潔? 킹

# ?譴??? ?閨??? 크?? ????
install.packages("magick")
library(magick)

lion_bg <- image_read("C://D://Desktop//Dev//learning-r//hanbat//Chapter6nbg01")
lion_1 <- image_read("C://D://Desktop//Dev//learning-r//hanbat//Chapter6n_1.png")
lion_2 <- image_read("C://D://Desktop//Dev//learning-r//hanbat//Chapter6n_2.png")

lion_bg <- image_scale(lion_bg,"600x300!")
lion_1 <- image_scale(lion_1,"100x50!")
lion_2 <- image_scale(lion_2,"100x50!")

print(lion_bg)

print(lion_1)

print(lion_2)

# ?譴??? ?欖? ?謬?트
img <- image_composite(lion_bg, lion_1, offset = "+100+200")
print(img)

# ?譴??? ?絹?
moving <- 0
x <- -100
y <- 150
while(TRUE) {
  if (x < 0)
    position <- paste(x, "+", y, sep="")
  else
    position <- paste("+", x, "+", y, sep="")
  if (moving %% 2 == 0) {
    img <- image_composite(lion_bg, lion_1,
                           offset = position)
  } else {
    img <- image_composite(lion_bg, lion_2,
                           offset = position)
  }
  print(img)
  Sys.sleep(0.3)
  if (x > 600)
    break
  moving <- moving + 1
  x <- x + 20
}
