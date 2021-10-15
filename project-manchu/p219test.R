# p.219
# 연설문의 단어에 대한 워드 클라우드 만들기
Sys.setenv(JAVA_HOME='C:\\Program Files\\Java\\jdk-16.0.2')
install.packages("rJava")
install.packages("KoNLP")
#install.packages("KoNLP",lib="C:\\Users\\LCH\\Documents\\R\\win-library\\3.6") 
#install.packages("https://cran.r-project.org/src/contrib/Archive/KoNLP/KoNLP_0.802.tar.gz",repos=NULL,type="source",INSTALL_opts=c('--no-lock')) 
install.packages("RColorBrewer")
install.packages("wordcloud")
library(rJava)
library(KoNLP)
library(RColorBrewer)
library(wordcloud)

useSejongDic()  

pal2 <- brewer.pal(8,"Dark2")   

text <- readLines(file.choose(), encoding = 'UTF-8')
text 
noun<-sapply(text,extractNoun,USE.NAMES=F)
noun
noun2<-unlist(noun)
noun2
word_count<-table(noun2)
word_count
head(sort(word_count,decreasing=TRUE),10)

wordcloud(names(word_count), freq = word_count, scale = c(6, 0.3), min.freq = 3,
          random.order = F, rot.per = .1, colors = pal2)

# Part Two
mergeUserDic(data.frame(c('정치'), c('ncn'))) # 'mergeUserDic' is deprecated. Use 'buildDictionary()' instead.

noun <- sapply(text, extractNoun, USE.NAMES = F)

noun2 <- unlist(noun)
noun2 <- gsub('여러분', '', noun2)
noun2 <- gsub('우리', '', noun2)
noun2 <- gsub('오늘', '', noun2)

noun2 <- Filter(function(x) {nchar(x) >= 2}, noun2)

word_count <- table(noun2)

wordcloud(names(word_count), freq = word_count, scale = c(6,0.3), min.freq = 3,
           random.order = F, rot.per = .1, colors = pal2)

# Save programmatically
setwd('/temp')

png(filename = 'speech.png', width = 480, height = 480)

dev.off()
