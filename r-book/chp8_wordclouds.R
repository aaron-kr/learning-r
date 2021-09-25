# File:     08_wordclouds.R
# Project:  Learning R

# Wordcloud ####

# Packages we want: KoNLP, RColorBrewer, rJava, wordcloud
# Public data: https://kostat.go.kr

install.packages('wordcloud')
library(wordcloud)

word <- c('Aaron', 'Sarah', 'Isaac', 'Jenna')
age <- c(40, 38, 10, 8)

wordcloud(word, age, colors='blue')
# wordcloud(words, freq, scale=c(4,.5), min.freq=3, max.words=Ing, random.order=TRUE, random.color=FALSE, rot.per=.1, colors='black', ...)

wordcloud(word, age, random.order=F, random.color=F, colors=rainbow(length(word)))

install.packages('RColorBrewer')
library(RColorBrewer)

pal2 <- brewer.pal(5, 'Dark2')
# brewer.pal(n, name)
# display.brewer.all(type='all') # or 'div' Diverging, 'qual' Qualitative, 'seq' Sequential
# display.brewer.pal(n, name)

word <- c('Gojoseon', 'Joseon', 'Goguryeo', 'Silla', 'Baekje')

freqency <- c(600,400,500,300,200)

wordcloud(word, frequency, colors=pal2)

# Public Data Wordcloud ####

# More public data
# https://kostat.go.kr
# https://kosis.kr

library(wordcloud)
library(RColorBrewer)
pal2 <- brewer.pal(8, 'Dark2')

## Data ====

data <- read.csv(file.choose(), header=T)
head(data)

## Data 2 ====

# 전국 지역 제외
data2 <- data[data$행정구역.시군구.별!='전국',]
head(data2)

## Data 3 ====

# 구 단위 지역 제외
x <- grep('구$', data$행정구역.시군구.별)
data3 <- data2[-c(x),] # without 구
head(data3)

# grep('^가', 항목명) # starts with 가
# grep('$가나', 항목명) # ends with 가나
# grep('가나다', 항목명) # is 가나다

## Data 4 ====

data4 <- data3[data3$순이동.명 > 0,]

word <- data4$행정구역.시군구.별

frequency <- data4$순이동.명

wordcloud(word, frequency, colors=pal2)

## Data 5 ====

data5 <- data3[data3$순이동.명 < 0,]

word <- data5$행정구역.시군구.별

frequency <- abs(data5$순이동.명)

wordcloud(word, frequency, colors=pal2)

# Speech Wordcloud ####

# https://pa.go.kr/index.jsp
# 김영삼 대통령 page, '제14대 대통령 취임사' speech

install.packages('KoNLP')
install.packages('RColorBrewer')
install.packages('wordcloud')

library(KoNLP)
library(RColorBrewer)
library(wordcloud)

useSejongDic()

pal2 <- brewer.pal(8, 'Dark2')

text <- readLines(file.choose()) # speech.txt
text

noun <- sapply(text, extractNoun, USE.NAMES=F)
noun

noun2 <- unlist(noun)
noun2

word_count <- table(noun2)
word_count

head(sort(word_count, decreasing=TRUE), 10)

wordcloud(names(word_count), freq=word_count, scale=c(6,0.3), min.freq=3, random.order=F, rot.per=.1, colors=pal2)

mergeUserDic(data.frame(c('정치'), c('ncn')))

noun <- sapply(text, extractNoun, USE.NAMES=F)
noun2 <- unlist(noun)

noun2 <- gsub('여러분', '', noun2)
noun2 <- gsub('우리', '', noun2)
noun2 <- gsub('오늘', '', noun2)

noun2 <- Filter(function(x) {nchar(x) >= 2}, noun2)

word_count <- table(noun2)

wordcloud(names(word_count), freq=word_count, scale=c(6,0.3), min.freq=3, random.order=F, rot.per=.1, colors=pal2)

setwd('/temp')

png(filename='speech.png', width=480, height=480) # maybe not working

dev.off()

## Speech 2 ====

# Find '김대중 대통령'

text <- readLines(file.choose())

noun <- sapply(text, extractNoun, USE.NAMES=F)

noun2 <- unlist(noun)

word_count <- table(noun2)

wordcloud(names(word_count), freq=word_count, scale=c(6,0.3), min.freq=3, random.order=F, rot.per=.1, colors=pal2)

noun2 <- gsub('오늘세','',noun2)
noun2 <- gsub('여러분','',noun2)
noun2 <- gsub('우리','',noun2)

noun2 <- Filter(function(x) {nchar(x) >= 2}, noun2)

word_count <- table(noun2)

wordcloud(names(word_count), freq=word_count, scale=c(6,0.3), min.freq=3, random.order=F, rot.per=.1, colors=pal2)

# Homework: Manchu Wordcloud I guess

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