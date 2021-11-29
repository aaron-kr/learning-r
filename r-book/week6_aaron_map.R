# Ch7 HW (week 6) = upload address + Google map of my house

install.packages("ggmap")
install.packages("ggplot2")
library(ggmap)
library(ggplot2)

register_google(key = "AIzaSyAvUNFp0wbTGiyVi4TNSkJWyPB2Pq35kDM")
names <- c("My house", 
           "My church", 
           "My school",
           "Hanok Village")
addr <- c("전라북도 전주시 천마산로31",
          "전북 전주시 덕진구 백제대로 665",
          "전라북도 전주시 완산구 천잠로 303",
          "전라북도 전주시 완산구 기린대로 99")
gc <- geocode(enc2utf8(addr))
gc

df <- data.frame(name=names, lon=gc$lon, lat=gc$lat)
df

cen <- c((max(df$lon)+min(df$lon))/2,
         (max(df$lat)+min(df$lat))/2)
cen

map <- get_googlemap(center=cen,
                     maptype="roadmap",
                     zoom=13,
                     marker=gc)
# ggmap(map)

# 단양 팔경 이름 출력
gmap <- ggmap(map, extent = 'device')
gmap + geom_text(data=df,
                 aes(x=lon, y=lat),
                 size=5,
                 label=df$name)
