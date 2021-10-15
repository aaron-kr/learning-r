install.packages("rJava")
install.packages("multilinguer")
#install_jdk()
install.packages(c('stringr','hash','tau','Sejong','RSQLite',
                   'devtools'), type="binary")
#install.packages("remotes")
remotes::install_github('haven-jeon/KoNLP',upgrade="never",
                        INSTALL_opts=c("--no-multiarch"))
install.packages("RColorBrewer")
install.packages("wordcloud")

# This R shell doesn't contain any Hangul encoding.
# For fully use, any of 'UTF-8', 'CP949', 'EUC-KR' needs to be used for R shell encoding.
# https://ko-kr.facebook.com/groups/krstudy/permalink/709372189237056/
Sys.setlocale("LC_ALL", "ko_KR.UTF-8")

library('rJava')
library(KoNLP)
library(RColorBrewer)
library(wordcloud)

useSystemDic()
useSejongDic()
useNIADic()

pal2 <- brewer.pal(8,"Dark2")   

text <- readLines(file.choose(), encoding = "UTF-8")
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
# ������ �ܾ� �߰� �� ����� ������ ����
mergeUserDic(data.frame(c("��ġ"), c("ncn")))
noun <- sapply(text, extractNoun, USE.NAMES=F)
noun2 <- unlist(noun) 

noun2 <- gsub("������", "", noun2)
noun2 <- gsub("�츮", "", noun2)
noun2 <- gsub("����", "", noun2)

noun2 <- Filter(function(x){nchar(x) >= 2}, noun2)

# p.223
word_count <- table(noun2)
wordcloud(names(word_count),freq=word_count,scale=c(6,0.3),min.freq=3, random.order=F,rot.per=.1,colors=pal2)

# ��� ����� �̹��� ����
setwd("/temp")  
png(filename = "speech.png", width = 480, height = 480)
# ���� ����̽� ���� 
dev.off()

# p.226
# �������� �ܾ ���� ���� Ŭ���� �����
text <- readLines(file.choose())
noun <- sapply(text, extractNoun, USE.NAMES=F)
noun2 <- unlist(noun) 
word_count <- table(noun2) 
wordcloud(names(word_count),freq=word_count,scale=c(6,0.3),min.freq=3, random.order=F,rot.per=.1,colors=pal2)

# ����� �ܾ��� ���� 
noun2 <- gsub("���ü�", "", noun2)
noun2 <- gsub("������", "", noun2)
noun2 <- gsub("�츮", "", noun2)

noun2 <- Filter(function(x){nchar(x) >= 2}, noun2)

word_count <- table(noun2)
wordcloud(names(word_count),freq=word_count,scale=c(6,0.3),min.freq=3, random.order=F,rot.per=.1,colors=pal2)

#######################
