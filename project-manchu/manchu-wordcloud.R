# Manchu Word Cloud

Sys.setenv(JAVA_HOME='C:\\Program Files\\Java\\jdk-16.0.2')
install.packages("rJava")
install.packages("KoNLP")
#install.packages("KoNLP",lib="C:\\Users\\LCH\\Documents\\R\\win-library\\3.6")
#install.packages("https://cran.r-project.org/src/contrib/Archive/KoNLP/KoNLP_0.802.tar.gz",repos=NULL,type="source",INSTALL_opts=c('--no-lock'))
install.packages("RColorBrewer")
install.packages("wordcloud")
install.packages("wordcloud2")
library(rJava)
library(KoNLP)
library(RColorBrewer)
library(wordcloud)
library(wordcloud2)


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

noun2 <- gsub('A', '', noun2) # particle
noun2 <- gsub('B', '', noun2) # particle

noun2 <- Filter(function(x) {nchar(x) >= 2}, noun2)
word_count <- table(noun2)

wordcloud(names(word_count), freq = word_count, scale = c(4, 0.1), min.freq = 3,
          random.order = F, rot.per = .1, colors = pal2)

noun2 <- gsub('be', '', noun2) # particle
noun2 <- gsub('de', '', noun2) # particle
noun2 <- gsub('bi', '', noun2) # pronoun
noun2 <- gsub('si', '', noun2) # pronoun
noun2 <- gsub('udu', '', noun2) # pronoun
noun2 <- gsub('mini', '', noun2) # pronoun


noun2 <- Filter(function(x) {nchar(x) >= 2}, noun2)

word_count <- sort(table(noun2), decreasing = T)

# purple, b.yellow, blue, d.yellow, green, pink
mycolors <- c('#f5c73b', '#c71fe9', '#ffdc00', '#64f5d3', '#05b5ff', '#ff65ff')

pptcolors <- c('#7c836b', '#d48c72', '#f19072', '#f8cdc1', '#9a5c47', '#99c8a7', '#97b2a4')
pptcolors2 <- c('#99c8a7', '#97b2a4', '#f19072', '#d48c72', '#9a5c47', '#7c836b', '#f8cdc1', '#f0e5d0', '#f7faf2')


wordcloud(names(word_count), freq = word_count, scale = c(3, 0.1), min.freq = 2,
          random.order = F, rot.per = .1, colors = pptcolors, bg = '#461859')

# takes longer, slightly more interesting
wordcloud2(data = word_count)

# "#461859" for dark in mask PPT
wordcloud2(data = word_count, size = 1, color=rep_len(pptcolors2, nrow(word_count)), backgroundColor = "#232322")

