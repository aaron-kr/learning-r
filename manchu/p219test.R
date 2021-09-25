# p.219
# 연설문의 단어에 대한 워드 클라우드 만들기
Sys.setenv(JAVA_HOME='C:\\Program Files\\Java\\jdk-13.0.2')
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

text <- readLines(file.choose())
text 
noun<-sapply(text,extractNoun,USE.NAMES=F)
noun
noun2<-unlist(noun)
noun2
word_count<-table(noun2)
word_count
head(sort(word_count,decreasing=TRUE),10)
