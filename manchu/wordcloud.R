install.packages("rJava")
install.packages("multilinguer")
#install_jdk()
install.packages(c('stringr','hash','tau','Sejong','RSQLite',
                   'devtools'), type="binary")
install.packages("remotes")
remotes::install_github('haven-jeon/KoNLP',upgrade="never",
                        INSTALL_opts=c("--no-multiarch"))
install.packages("RColorBrewer")
install.packages("wordcloud")

library('rJava')
library(KoNLP)
library(RColorBrewer)
library(wordcloud)

useSystemDic()
useSejongDic()
useNIADic()

pal2 <- brewer.pal(8,"Dark2")   

text <- readLines(file.choose())
text 
noun<-sapply(text,extractNoun,USE.NAMES=F)
noun
noun2<-unlist(noun)
noun2
word_count<-table(noun2)
word_count
head(sort(word_count,decreasing=TRUE),10)
wordcloud(names(word_count),freq=word_count,scale=c(6,0.3),min.freq=3, random.order=F,rot.per=.1,colors=pal2)

# p.222
# 사전에 단어 추가 및 추출된 명사의 삭제
mergeUserDic(data.frame(c("정치"), c("ncn")))
noun <- sapply(text, extractNoun, USE.NAMES=F)
noun2 <- unlist(noun) 

noun2 <- gsub("여러분", "", noun2)
noun2 <- gsub("우리", "", noun2)
noun2 <- gsub("오늘", "", noun2)

noun2 <- Filter(function(x){nchar(x) >= 2}, noun2)

# p.223
word_count <- table(noun2)
wordcloud(names(word_count),freq=word_count,scale=c(6,0.3),min.freq=3, random.order=F,rot.per=.1,colors=pal2)

# 출력 결과의 이미지 저장
setwd("/temp")  
png(filename = "speech.png", width = 480, height = 480)
# 저장 디바이스 종료 
dev.off()

# p.226
# 연설문의 단어에 대한 워드 클라우드 만들기
text <- readLines(file.choose())
noun <- sapply(text, extractNoun, USE.NAMES=F)
noun2 <- unlist(noun) 
word_count <- table(noun2) 
wordcloud(names(word_count),freq=word_count,scale=c(6,0.3),min.freq=3, random.order=F,rot.per=.1,colors=pal2)

# 추출된 단어의 삭제 
noun2 <- gsub("오늘세", "", noun2)
noun2 <- gsub("여러분", "", noun2)
noun2 <- gsub("우리", "", noun2)

noun2 <- Filter(function(x){nchar(x) >= 2}, noun2)

word_count <- table(noun2)
wordcloud(names(word_count),freq=word_count,scale=c(6,0.3),min.freq=3, random.order=F,rot.per=.1,colors=pal2)

#######################

