# Technology Gap, Attitudes, Lifelong Learning

## Load Packages ###############################################################
install.packages('tidytext')
install.packages('R.utils')
install.packages('viridis')

library(tidyverse)
library(RColorBrewer)
library(tidytext)
library(R.utils)
library(wordcloud)
library(viridis)

# Skip the first line, read EVERYTHING in as a Factor
results <- read.csv(file.choose(), encoding = 'utf-8', skip = 1, colClasses = c(rep('factor', 54)))

# Update these factors to deal with NAs
results$nation   <- factor(results$nation, levels = c('Korean', 'Non-Korean'))
results$job      <- factor(results$job, levels = c('Academy (hagwon)', 'Company or Other location', 'Kindergarten or elementary school', 'Middle or high school', 'University'))
results$location <- factor(results$location, levels = c('A medium or small city', 'A rural area', 'Seoul or a metropolitan city'))
summary(results)

### 1. Group by Nation =========================================================

# Separate out Koreans
results_kr <- results[results$nation == 'Korean',]
summary(results_kr)

# Separate out Non-Koreans
results_non <- results[results$nation != 'Korean',]
summary(results_non)

### 2. Group by Job ============================================================

# Separate out University Teachers
results_uni <- results[results$job == 'University',]
results_co <- results[results$job == 'Company or Other location',]
results_uni <- rbind(results_uni, results_co)
summary(results_uni)

# Separate out Other Schools
results_edu <- results[results$job != 'University',]
results_edu <- results_edu[results_edu$job != 'Company or Other location',]
summary(results_edu)

### 3. Group by Location =======================================================

# Separate out Seoul / big cities
results_city <- results[results$location == 'Seoul or a metropolitan city',]
summary(results_city)

# Separate out Medium / small cities
results_town <- results[results$location != 'Seoul or a metropolitan city',]
summary(results_town)

## LIKERT PLOTTING #############################################################

install.packages('devtools')
library('devtools')

install_github('m-dev-/likert')
install.packages('likert')
library('likert')

install.packages('reshape')
library('reshape')

### 1. Attitudes ===============================================================

func_likert_att <- function(df) {
  att <- df[, substr(names(df), 1,4) == 'att_']
  head(att)
  ncol(att)
  summary(att)

  # Change Likert scores to factor and specify levels
  att$att_learning   <- factor(att$att_learning, levels = c(1, 2, 3, 4, 5), ordered = T)
  att$att_work       <- factor(att$att_work, levels = c(1, 2, 3, 4, 5), ordered = T)
  att$att_employers  <- factor(att$att_employers, levels = c(1, 2, 3, 4, 5), ordered = T)
  att$att_me         <- factor(att$att_me, levels = c(1, 2, 3, 4, 5), ordered = T)
  att$att_school     <- factor(att$att_school, levels = c(1, 2, 3, 4, 5), ordered = T)
  att$att_life       <- factor(att$att_life, levels = c(1, 2, 3, 4, 5), ordered = T)
  att$att_enjoyable  <- factor(att$att_enjoyable, levels = c(1, 2, 3, 4, 5), ordered = T)
  att$att_confidence <- factor(att$att_confidence, levels = c(1, 2, 3, 4, 5), ordered = T)
  att$att_pay        <- factor(att$att_pay, levels = c(1, 2, 3, 4, 5), ordered = T)
  att$att_covid      <- factor(att$att_covid, levels = c(1, 2, 3, 4, 5), ordered = T)
  summary(att)

  names(att) <- c('People who continue to learn into adulthood are less likely to lose their jobs.',
                  'To be successful at work, you must constantly improve your knowledge and skills.',
                  'Employers are responsible for the training of their employees.',
                  'It is my responsibility to take a personal role in my own continuing education (by reading books, taking online courses, attending trainings and conferences, etc.)',
                  'You cannot learn the skills you need at work in school.',
                  'Education and training help you lead a better daily life.',
                  'Learning new things is very enjoyable.',
                  'You can gain confidence through learning.',
                  'Adult learners must be prepared to pay something for their learning.',
                  'My attitude toward lifelong learning has changed as a result of the COVID-19 pandemic.'
                  )

  att_likert <- likert(att)
  str(att_likert)

  # Create a likert object from the results rather than the data
  att_likert <- likert(summary = att_likert$results)
  str(att_likert)

  plot(att_likert) +
    ggtitle('Attitudes Toward Lifelong Learning (평생학습에 대한 태도)', subtitle = 'Survey Results (74 respondents)')
}

### Multiple graphs ------------------------------------------------------------
func_likert_att(results)
func_likert_att(results_kr)
func_likert_att(results_non)

# Try to display side by side, BUT it sorts ranking, so out of order...
# install.packages('cowplot')
# cowplot::plot_grid(kr, non) # assign graphs (above to variables)

#### Grouping ------------------------------------------------------------------

att_g <- likert(att, grouping = results$job)
str(att_g)

att_g_likert <- likert(summary = att_g$results, grouping = att_g$results[,1])
str(att_g_likert)

# knitr::opts_chunk$set(fig.height = knitr::opts_chunk$get('fig.height')*2)

plot(att_g_likert) +
  ggtitle('Attitudes Toward Lifelong Learning (평생학습에 대한 태도)', subtitle = 'Survey Results (74 respondents)')

### 2. Competence ==============================================================

func_likert_pdc <- function(df) {
  pdc <- df[, substr(names(df), 1,4) == 'pdc_']
  head(pdc)
  ncol(pdc)
  summary(pdc)

  # Change Likert scores to factor and specify levels
  pdc$pdc_diverse     <- factor(pdc$pdc_diverse, levels = c(1, 2, 3, 4, 5), ordered = T)
  pdc$pdc_confidence  <- factor(pdc$pdc_confidence, levels = c(1, 2, 3, 4, 5), ordered = T)
  pdc$pdc_familiarity <- factor(pdc$pdc_familiarity, levels = c(1, 2, 3, 4, 5), ordered = T)
  pdc$pdc_appropriate <- factor(pdc$pdc_appropriate, levels = c(1, 2, 3, 4, 5), ordered = T)
  pdc$pdc_difficult   <- factor(pdc$pdc_difficult, levels = c(1, 2, 3, 4, 5), ordered = T)
  pdc$pdc_adjust      <- factor(pdc$pdc_adjust, levels = c(1, 2, 3, 4, 5), ordered = T)
  pdc$pdc_outcome     <- factor(pdc$pdc_outcome, levels = c(1, 2, 3, 4, 5), ordered = T)
  pdc$pdc_feedback    <- factor(pdc$pdc_feedback, levels = c(1, 2, 3, 4, 5), ordered = T)
  pdc$pdc_students    <- factor(pdc$pdc_students, levels = c(1, 2, 3, 4, 5), ordered = T)
  pdc$pdc_covid       <- factor(pdc$pdc_covid, levels = c(1, 2, 3, 4, 5), ordered = T)
  summary(pdc)

  names(pdc) <- c('I am familiar with digital tools that can help diversify teaching.',
                  'I am, in general, confident when using digital tools.',
                  'I find it easy to become familiar with new digital tools.',
                  'I can use digital tools that are appropriate for the aspects of the subjects I am teaching.',
                  'It is difficult to use digital tools as an educational resource within my subject. REV.',
                  'When I am using digital tools, it is difficult to adjust the content to the individual student’s needs. REV.',
                  'I have no clear idea of the learning outcome when using digital tools in my teaching. REV.',
                  'I use digital tools when giving feedback to students.',
                  'My students are more knowledgeable about digital tools for education than I am.',
                  'The COVID-19 pandemic has caused me to learn more about digital tools for education.'
  )
  comp <- likert(pdc)
  str(comp)

  # Create a likert object from the results rather than the data
  comp <- likert(summary = comp$results)
  str(comp)

  plot(comp) +
    ggtitle('Professional Digital Competence (전문 디지털 역량)', subtitle = 'Survey Results (74 respondents)')
}

#### Multiple Graphs -----------------------------------------------------------

func_likert_pdc(results)

#### Grouping ------------------------------------------------------------------

pdc <- results[, substr(names(results), 1,4) == 'pdc_']

pdc_g <- likert(pdc, grouping = results$nation)
str(pdc_g)

pdc_g_likert <- likert(summary = pdc_g$results, grouping = pdc_g$results[,1])
str(pdc_g_likert)

# knitr::opts_chunk$set(fig.height = knitr::opts_chunk$get('fig.height')*2)

plot(pdc_g_likert) +
  ggtitle('Professional Digital Competence (전문 디지털 역량)', subtitle = 'Survey Results (74 respondents)')


### 3. Professionalism =========================================================

func_likert_pro <- function(df) {
  pro <- df[, substr(names(df), 1,4) == 'pro_']
  head(pro)
  ncol(pro)
  summary(pro)

  # Change Likert scores to factor and specify levels
  pro$pro_teaching     <- factor(pro$pro_teaching, levels = c(1, 2, 3, 4, 5), ordered = T)
  pro$pro_essential    <- factor(pro$pro_essential, levels = c(1, 2, 3, 4, 5), ordered = T)
  pro$pro_society      <- factor(pro$pro_society, levels = c(1, 2, 3, 4, 5), ordered = T)
  pro$pro_expectations <- factor(pro$pro_expectations, levels = c(1, 2, 3, 4, 5), ordered = T)
  pro$pro_organization <- factor(pro$pro_organization, levels = c(1, 2, 3, 4, 5), ordered = T)
  pro$pro_disruptive   <- factor(pro$pro_disruptive, levels = c(1, 2, 3, 4, 5), ordered = T)
  pro$pro_interest     <- factor(pro$pro_interest, levels = c(1, 2, 3, 4, 5), ordered = T)
  pro$pro_testing      <- factor(pro$pro_testing, levels = c(1, 2, 3, 4, 5), ordered = T)
  pro$pro_struggling   <- factor(pro$pro_struggling, levels = c(1, 2, 3, 4, 5), ordered = T)
  pro$pro_education    <- factor(pro$pro_education, levels = c(1, 2, 3, 4, 5), ordered = T)
  summary(pro)

  names(pro) <- c('When I use digital tools in my teaching, I find it adds value.',
                  'The use of digital tools is essential for good teaching.',
                  'Society’s expectations of the impact of digital tools are exaggerated. REV.',
                  'Expectations related to the use of digital tools in education frustrate me. REV.',
                  'In professional debates at our organization, the expectations of the impact of digital tools are exaggerated. REV.',
                  'The use of digital tools is disruptive for the relationship between student and teacher. REV.',
                  'Digital tools can make the students more interested in the subject I am teaching.',
                  'I like testing new digital tools in my teaching.',
                  'I feel like I am constantly struggling with learning or using new digital tools for education.',
                  'Teachers need continuing education about technology.'
  )
  pro_att <- likert(pro)
  str(pro_att)

  # Create a likert object from the results rather than the data
  pro_att <- likert(summary = pro_att$results)
  str(pro_att)

  plot(pro_att) +
    ggtitle('Professional Attitude (전문적인 태도)', subtitle = 'Survey Results (74 respondents)')
}

#### Multiple Graphs -----------------------------------------------------------

func_likert_pro(results)

#### Grouping ------------------------------------------------------------------

pro <- results[, substr(names(results), 1,4) == 'pro_']

pro_g <- likert(pro, grouping = results$nation)
str(pro_g)

pro_g_likert <- likert(summary = pro_g$results, grouping = pro_g$results[,1])
str(pro_g_likert)

# knitr::opts_chunk$set(fig.height = knitr::opts_chunk$get('fig.height')*2)

plot(pro_g_likert) +
  ggtitle('Professional Attitude (전문적인 태도)', subtitle = 'Survey Results (74 respondents)')


### 4. Tools ===================================================================

tools <- results[, substr(names(results), 1,6) == 'tools_']

# Separate out "time spent" from "tools used"
time <- tools[,19:20]
tools <- tools[,1:18]

head(time)
ncol(tools)
summary(tools)

# Change Likert scores to factor and specify levels
tools$tools_testing     <- factor(tools$tools_testing, levels = c(1, 2, 3, 4, 5), ordered = T)
tools$tools_lms         <- factor(tools$tools_lms, levels = c(1, 2, 3, 4, 5), ordered = T)
tools$tools_ppt         <- factor(tools$tools_ppt, levels = c(1, 2, 3, 4, 5), ordered = T)
tools$tools_doc         <- factor(tools$tools_doc, levels = c(1, 2, 3, 4, 5), ordered = T)
tools$tools_xls         <- factor(tools$tools_xls, levels = c(1, 2, 3, 4, 5), ordered = T)
tools$tools_video       <- factor(tools$tools_video, levels = c(1, 2, 3, 4, 5), ordered = T)
tools$tools_youtube     <- factor(tools$tools_youtube, levels = c(1, 2, 3, 4, 5), ordered = T)
tools$tools_discussions <- factor(tools$tools_discussions, levels = c(1, 2, 3, 4, 5), ordered = T)
tools$tools_zoom        <- factor(tools$tools_zoom, levels = c(1, 2, 3, 4, 5), ordered = T)
tools$tools_wiki        <- factor(tools$tools_wiki, levels = c(1, 2, 3, 4, 5), ordered = T)
tools$tools_obs         <- factor(tools$tools_obs, levels = c(1, 2, 3, 4, 5), ordered = T)
tools$tools_science     <- factor(tools$tools_science, levels = c(1, 2, 3, 4, 5), ordered = T)
tools$tools_responses   <- factor(tools$tools_responses, levels = c(1, 2, 3, 4, 5), ordered = T)
tools$tools_collab      <- factor(tools$tools_collab, levels = c(1, 2, 3, 4, 5), ordered = T)
tools$tools_sns         <- factor(tools$tools_sns, levels = c(1, 2, 3, 4, 5), ordered = T)
tools$tools_internet    <- factor(tools$tools_internet, levels = c(1, 2, 3, 4, 5), ordered = T)
tools$tools_audio       <- factor(tools$tools_audio, levels = c(1, 2, 3, 4, 5), ordered = T)
tools$tools_blog        <- factor(tools$tools_blog, levels = c(1, 2, 3, 4, 5), ordered = T)
summary(tools)

names(tools) <- c('Digital tools for testing with multiple choice questions',
                'Moodle, Canvas, Fronter, Google Classroom, or your own schools’s LMS (learning management system)',
                'Digital tools for presentation (like PowerPoint or Prezi)',
                'Word processor (like Hangul or Word)',
                'Spreadsheets (like Excel)',
                'Use of video in class or assignments',
                'Creating a film/video/animation',
                'Online discussions for class',
                'Online meetings (like Zoom, Webex, Google Meet, Lync, Adobe Connect, or Skype)',
                'Production of a Wiki (website that allows collaborative modification)',
                'Video screen capture (like Camtasia, OBS, or Mediasite)',
                'Programs for scientific analyses',
                'Student response systems (online questions answered by phone or computers, like Kahoot! or Socrative)',
                'Tools for collaborative writing (like Google Docs or Google Slides)',
                'Social media (like Facebook, Twitter, or KakaoTalk) for class',
                'The Internet as a source of knowledge',
                'Audio recording or editing programs (like Audacity, GarageBand, or Adobe Audition)',
                'Production of a class website or blog (like Google Sites, WordPress, Medium, or Naver cafe)'
)
tools_likert <- likert(tools)
str(tools_likert)

# Create a likert object from the results rather than the data
tools_likert <- likert(summary = tools_likert$results)
str(tools_likert)

plot(tools_likert) +
  ggtitle('Professional Application of Tools (도구의 전문적인 응용)', subtitle = 'Survey Results (74 respondents)')

#### Grouping ------------------------------------------------------------------

tools_g <- likert(tools, grouping = results$nation)
str(tools_g)

tools_g_likert <- likert(summary = tools_g$results, grouping = tools_g$results[,1])
str(tools_g_likert)

# knitr::opts_chunk$set(fig.height = knitr::opts_chunk$get('fig.height')*2)

# This works, but not much space for showing it.
plot(tools_g_likert) +
  ggtitle('Professional Application of Tools (도구의 전문적인 응용)', subtitle = 'Survey Results (74 respondents)')

### 5. Time Spent ==============================================================

head(time)

time$tools_before      <- factor(time$tools_before, levels = c(1, 2, 3, 4, 5), ordered = T)
time$tools_after       <- factor(time$tools_after, levels = c(1, 2, 3, 4, 5), ordered = T)

names(time) <- c('Amount of time, effort, or digital tools I used BEFORE the COVID-19 pandemic.',
                 'Amount of time, effort, or digital tools I NOW use or will continue to use during and after the COVID-19 pandemic.'
)
time_likert <- likert(time)
str(time_likert)

# Create a likert object from the results rather than the data
time_likert <- likert(summary = time_likert$results)
str(time_likert)

plot(time_likert) +
  ggtitle('Time, Effort, Tools (시간, 능력, 도구)', subtitle = 'Survey Results (74 respondents)')

#### Grouping ------------------------------------------------------------------

time_g <- likert(time, grouping = results$nation)
str(time_g)

time_g_likert <- likert(summary = time_g$results, grouping = time_g$results[,1])
str(time_g_likert)

# knitr::opts_chunk$set(fig.height = knitr::opts_chunk$get('fig.height')*2)

plot(time_g_likert) +
  ggtitle('Time, Effort, Tools (시간, 능력, 도구)', subtitle = 'Survey Results (74 respondents)')
