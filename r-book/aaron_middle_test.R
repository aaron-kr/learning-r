# File:     aaron_big_data_midterm.R
# Project:  Learning R (Book)

# Chp 5 : Charts ###############################################################

## 3D Pie Chart ================================================================

grades <- c('A+', 'A', 'B+', 'B', 'C+', 'C')
dist <- c(12.5, 17.5, 35.5, 24.5, 15.5, 14.5)
labels <- paste(grades, dist, '%')

library(plotrix)

pie3D(dist,
      col = rainbow(length(dist)),
      labels = labels,
      explode = 0.05,
      border = 'black',
      theta = 1,
      labelcex = 1,
      # start = 90,
      height = 0.1,
      shade = 0.7,
      main = "Distribution of Grades")

# Chp 7 : Maps #################################################################

## Jeonju Restaurants ==========================================================

install.packages("ggmap")
install.packages("ggplot2")
library(ggmap)
library(ggplot2)

register_google(key = "AIzaSyAvUNFp0wbTGiyVi4TNSkJWyPB2Pq35kDM")

# Source: https://keytokorean.com/fun/travel/top-twelve-eats-in-jeonju/

meal <- c('Breakfast 1', 'Lunch 1', 'Dessert 1', 'Dinner 1', 'Drinks 1',
          'Breakfast 2', 'Lunch 2', 'Dessert 2', 'Dinner 2', 'Drinks 2',
          'Breakfast 3', 'Lunch 3', 'Dinner & Dessert 3')
food <- c('콩국수', '비빔밥', '초코파이', '백반', '맥주',
          '콩나물국밥', '칼국수', '팥빙수', '고기', '막걸리',
          '순대국밥', '설렁탕', '순두부찌개 & 도너츠')
names <- c('진미집 (한옥마을점)', '고궁 (전주본점)', '풍년제과 (본점)', '농부며느리', '매드헝그리',
           '왱이집', '베테랑분식', '외할머니 솜씨', '고기장터', '옛촌막걸리',
           '조점례 남문 피순대', '족보설렁탕', '화심순두부 (중화산동점)')
new_addr <- c('전라북도 전주시 완산구 전주천동로 94',
              '전라북도 전주시 덕진구 송천중앙로 33',
              '전라북도 전주시 완산구 팔달로 180 풍년제과',
              '전라북도 전주시 덕진구 아중3길 20',
              '전라북도 전주시 완산구 홍산중앙로 42',
              '전라북도 전주시 완산구 동문길 88 왱이집',
              '전라북도 전주시 완산구 경기전길 135 베테랑분식',
              '전라북도 전주시 완산구 은행로 87',
              '전라북도 전주시 덕진구 명주6길 9',
              '전라북도 전주시 완산구 팔달로 144-4',
              '전라북도 전주시 완산구 전동3가 2-198',
              '전라북도 전주시 덕진구 송천중앙로 25',
              '전라북도 전주시 완산구 서원로 339 화심순두부')
old_addr <- c('전라북도 전주시 완산구 전동 237',
              '전라북도 전주시 덕진구 덕진동2가 168-9',
              '전라북도 전주시 완산구 경원동1가 40-5',
              '전라북도 전주시 덕진구 우아동2가 913-6',
              '전라북도 전주시 완산구 효자동3가 1536-1 암빌딩 6층',
              '전라북도 전주시 완산구 경원동2가 12-1',
              '전라북도 전주시 완산구 교동 85-1',
              '전라북도 전주시 완산구 교동 113-4',
              '전라북도 전주시 덕진구 인후동2가 1577-27',
              '전라북도 전주시 완산구 전동 52-2',
              '전라북도 전주시 완산구 전동3가 2-198',
              '전라북도 전주시 덕진구 덕진동2가 168-15',
              '전라북도 전주시 완산구 중화산동1가 321-10')
phone <- c('063-288-4020', '063-251-3211', '063-285-6666', '063-242-6811', '063-237-3618',
           '063-287-6980', '063-285-9898', '063-232-5804', '063-246-4992', '063-232-9991',
           '063-232-5006', '063-277-0004', '063-231-6500')

# All 12 above are clustered, and hard to visualize.
# So, only map the downtown restaurants near Hanok Village.

downtown_names <- c('진미집 (한옥마을점)', '풍년제과 (본점)',
                    '왱이집', '베테랑분식', '외할머니 솜씨', '옛촌막걸리',
                    '조점례 남문 피순대')
downtown_addr <- c('전라북도 전주시 완산구 전동 237',
                   '전라북도 전주시 완산구 경원동1가 40-5',
                   '전라북도 전주시 완산구 경원동2가 12-1',
                   '전라북도 전주시 완산구 교동 85-1',
                   '전라북도 전주시 완산구 교동 113-4',
                   '전라북도 전주시 완산구 전동 52-2',
                   '전라북도 전주시 완산구 전동3가 2-198')
downtown_phone <- c('063-288-4020', '063-285-6666', '063-287-6980', '063-285-9898', '063-232-5804', '063-232-9991', '063-232-5006')

gc <- geocode(enc2utf8(downtown_addr))
gc

df <- data.frame(name = downtown_names, lon = gc$lon, lat = gc$lat, phone = downtown_phone)
df

cen <- c((max(df$lon)+min(df$lon))/2,
         (max(df$lat)+min(df$lat))/2)
cen

map <- get_googlemap(center=cen,
                     maptype="roadmap",
                     zoom=16,
                     marker=gc)
ggmap(map, extent = 'device')

# 단양 팔경 이름 출력
gmap <- ggmap(map, extent = 'device')
gmap + geom_text(data=df,
                 aes(x=lon, y=lat),
                 size=4,
                 label=paste('\n\n', df$name, '\n', df$phone))
                 
                 