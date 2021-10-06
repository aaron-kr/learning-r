# Manchu Word Cloud

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

wordcloud(names(word_count), freq = word_count, scale = c(4, 0.1), min.freq = 3,
          random.order = F, rot.per = .1, colors = pal2)

noun2 <- gsub('be', '', noun2) # particle
noun2 <- gsub('de', '', noun2) # particle
noun2 <- gsub('bi', '', noun2) # pronoun
noun2 <- gsub('si', '', noun2) # pronoun
noun2 <- gsub('udu', '', noun2) # pronoun
noun2 <- gsub('mini', '', noun2) # pronoun


noun2 <- Filter(function(x) {nchar(x) >= 2}, noun2)

word_count <- table(noun2)

wordcloud(names(word_count), freq = word_count, scale = c(3, 0.1), min.freq = 3,
          random.order = F, rot.per = .1, colors = pal2)
