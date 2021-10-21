# Tidy Data for IETTP Analysis

## Load Packages ###############################################################

if (!require('pacman')) install.packages('pacman')
pacman::p_load(tidyverse, rio)

jju20 <- read_csv(file.choose())
jbnu20 <- read_csv(file.choose())
jju21_1 <- read_csv(file.choose())
jju21_2 <- read_csv(file.choose())

## Tidy Data ###################################################################

### 1. JJU 2020 ================================================================

jju20

# Clean up columns
jju20_clean <- jju20[c(1:4)] # Only what we want to keep

# Timestamp to Year
jju20_clean$Timestamp <- as.integer(2020)

# Rename columns
jju20_clean <- jju20_clean %>%
  rename(
    year = Timestamp,
    grade = Grade,
    comfort_level = `1. Please indicate your current comfort level with technology.`,
    current_use = `2. How much technology do you use in the classroom currently?`
  )

# Clean or substitute values
jju20_clean$comfort_level <- as.integer(gsub(':.*', '', jju20_clean$comfort_level))
jju20_clean$current_use <- as.integer(gsub(':.*', '', jju20_clean$current_use))

# Add distinguishing column
jju20_clean <- cbind(jju20_clean, group = 'One')

# Rearrange columns
jju20_clean <- jju20_clean[, c(1,5,2,3,4)]

# Drop NA
jju20_clean <- jju20_clean %>% drop_na()

str(jju20_clean) # Check datatypes

### 2. JBNU 2020 ===============================================================

jbnu20

# Clean up columns
jbnu20_clean <- jbnu20[c(1:4)] # Only what we want to keep

# Timestamp to Year
jbnu20_clean$Timestamp <- as.integer(2020)

# Rename columns
jbnu20_clean <- jbnu20_clean %>%
  rename(
    year = Timestamp,
    grade = Grade,
    comfort_level = `1. Please indicate your current comfort level with technology.`,
    current_use = `2. How much technology do you use in the classroom currently?`
  )

# Clean or substitute values
jbnu20_clean$comfort_level <- as.integer(gsub(':.*', '', jbnu20_clean$comfort_level))
jbnu20_clean$current_use <- as.integer(gsub(':.*', '', jbnu20_clean$current_use))

# Add distinguishing column
jbnu20_clean <- cbind(jbnu20_clean, group = 'Two')

# Rearrange columns
jbnu20_clean <- jbnu20_clean[, c(1,5,2,3,4)]

# Drop NA
jbnu20_clean <- jbnu20_clean %>% drop_na()

str(jbnu20_clean) # Check datatypes

### 3. JJU 2021:1 ==============================================================

jju21_1

# Clean up columns
jju21_1_clean <- jju21_1[,c(1:2,11:13)] # only what we want to keep

# Timestamp to Year
jju21_1_clean$Timestamp <- as.integer(2021)

# Add distinguishing group column
jju21_1_clean <- cbind(jju21_1_clean, group = 'Three')

# Rearrange columns
jju21_1_clean <- jju21_1_clean[, c(1,2,6,4,5,3)]

# Rename columns
jju21_1_clean <- jju21_1_clean %>%
  rename(
    year = Timestamp,
    grade = Grade,
    comfort_level = `Thinking about technology in class:`,
    current_use = `Amount of technology you currently use in class:`,
    materials = `I'm most comfortable with:`
  )

#### Assign numeric values to our choices --------------------------------------

# comfort_level
jju21_1_clean$comfort_level[jju21_1_clean$comfort_level == 'Please NO!'] <- as.integer(1)
jju21_1_clean$comfort_level[jju21_1_clean$comfort_level == 'Can someone else do it?...'] <- as.integer(2)
jju21_1_clean$comfort_level[jju21_1_clean$comfort_level == 'Step-by-step instructions please...'] <- as.integer(3)
jju21_1_clean$comfort_level[jju21_1_clean$comfort_level == 'I\'m comfortable with tech in class.'] <- as.integer(4)
jju21_1_clean$comfort_level[jju21_1_clean$comfort_level == 'I\'m a pro - it\'s easy to learn and use.'] <- as.integer(5)

# current_use
jju21_1_clean$current_use[jju21_1_clean$current_use == 'ZERO. Books and paper for me.'] <- as.integer(1)
jju21_1_clean$current_use[jju21_1_clean$current_use == 'Sometimes... a video...'] <- as.integer(2)
jju21_1_clean$current_use[jju21_1_clean$current_use == 'PPT lessons, paper handouts'] <- as.integer(3)
jju21_1_clean$current_use[jju21_1_clean$current_use == 'Digital handouts, students use notebooks or smartphones in class'] <- as.integer(4)
jju21_1_clean$current_use[jju21_1_clean$current_use == 'Connected 24/7'] <- as.integer(5)

# materials
jju21_1_clean$materials[jju21_1_clean$materials == 'Books and paper (hand-outs)'] <- as.integer(1)
jju21_1_clean$materials[jju21_1_clean$materials == 'Desktop applications'] <- as.integer(2)
jju21_1_clean$materials[jju21_1_clean$materials == 'Mobile applications'] <- as.integer(3)
jju21_1_clean$materials[jju21_1_clean$materials == 'Web-based applications'] <- as.integer(4)

# Filter NA (only drop where ALL are NA, not just one)
jju21_1_clean <- jju21_1_clean %>% filter_at(vars(comfort_level, current_use, materials), any_vars(!is.na(.)))

# Change datatypes of columns
jju21_1_clean$comfort_level <- as.integer(jju21_1_clean$comfort_level)
jju21_1_clean$current_use <- as.integer(jju21_1_clean$current_use)
jju21_1_clean$materials <- as.integer(jju21_1_clean$materials)

str(jju21_1_clean)

### 4. JJU 2021:2 ==============================================================

jju21_2

# Clean up columns
jju21_2_clean <- jju21_2[,c(1:2,11:13)] # only what we want to keep

# Timestamp to Year
jju21_2_clean$Timestamp <- as.integer(2021)

# Add distinguishing group column
jju21_2_clean <- cbind(jju21_2_clean, group = 'Four')

# Rearrange columns
jju21_2_clean <- jju21_2_clean[, c(1,2,6,4,5,3)]

# Rename columns
jju21_2_clean <- jju21_2_clean %>%
  rename(
    year = Timestamp,
    grade = `What grade level do you teach?`,
    comfort_level = `Thinking about technology in class:`,
    current_use = `Amount of technology you currently use in class:`,
    materials = `I'm most comfortable with:`
  )

#### Assign numeric values to our choices --------------------------------------

# comfort_level
jju21_2_clean$comfort_level[jju21_2_clean$comfort_level == 'Please NO!'] <- as.integer(1)
jju21_2_clean$comfort_level[jju21_2_clean$comfort_level == 'Can someone else do it?...'] <- as.integer(2)
jju21_2_clean$comfort_level[jju21_2_clean$comfort_level == 'Step-by-step instructions please...'] <- as.integer(3)
jju21_2_clean$comfort_level[jju21_2_clean$comfort_level == 'I\'m comfortable with tech in class.'] <- as.integer(4)
jju21_2_clean$comfort_level[jju21_2_clean$comfort_level == 'I\'m a pro - it\'s easy to learn and use.'] <- as.integer(5)

# current_use
jju21_2_clean$current_use[jju21_2_clean$current_use == 'ZERO. Books and paper for me.'] <- as.integer(1)
jju21_2_clean$current_use[jju21_2_clean$current_use == 'Sometimes... a video...'] <- as.integer(2)
jju21_2_clean$current_use[jju21_2_clean$current_use == 'PPT lessons, paper handouts'] <- as.integer(3)
jju21_2_clean$current_use[jju21_2_clean$current_use == 'Digital handouts, students use notebooks or smartphones in class'] <- as.integer(4)
jju21_2_clean$current_use[jju21_2_clean$current_use == 'Connected 24/7'] <- as.integer(5)

# materials
jju21_2_clean$materials[jju21_2_clean$materials == 'Books and paper (hand-outs)'] <- as.integer(1)
jju21_2_clean$materials[jju21_2_clean$materials == 'Desktop applications'] <- as.integer(2)
jju21_2_clean$materials[jju21_2_clean$materials == 'Mobile applications'] <- as.integer(3)
jju21_2_clean$materials[jju21_2_clean$materials == 'Web-based applications'] <- as.integer(4)

str(jju21_2_clean)

# Filter NA (only drop where ALL are NA, not just one)
jju21_2_clean <- jju21_2_clean %>% filter_at(vars(comfort_level, current_use, materials), any_vars(!is.na(.)))

# Change datatypes of columns
jju21_2_clean$comfort_level <- as.integer(jju21_2_clean$comfort_level)
jju21_2_clean$current_use <- as.integer(jju21_2_clean$current_use)
jju21_2_clean$materials <- as.integer(jju21_2_clean$materials)

str(jju21_2_clean)

## Join Dataframes #############################################################

all_2020 <- rbind(jju20_clean, jbnu20_clean)
all_2020$materials <- NA
str(all_2020)

all_2021 <- rbind(jju21_1_clean, jju21_2_clean)
str(all_2021)

all <- rbind(all_2020, all_2021)
all

str(all)

summary(all)

# Change some to factors for better grouping
all <- all %>%
  mutate(year = as.factor(year), group = as.factor(group), grade = as.factor(grade))

## Data Analysis ###############################################################

# ggplot()

### 1. Scatterplot =============================================================

ggplot(data = all) + 
  geom_point(mapping = aes(x = comfort_level, y = current_use, shape = grade, color = grade), alpha = 0.6, size = 2)
# geom_point aesthetics (x, y req'd)
# x, y, shape, color, size, alpha

### 2. Lines and smoothers =====================================================

# geom_line() connects points in a dataset
# geom_smooth() fits a line to points
# aesthetics are mostly the same as geom_point()

# Basic, but each geometry contains data aesthetics
ggplot(data = all) + 
  geom_line(mapping = aes(x = comfort_level, y = current_use, color = grade), alpha = 0.6, size = 2) +
  geom_point(mapping = aes(x = comfort_level, y = current_use, shape = grade, color = grade, alpha = 0.6, size = 2))

# Better, data aesthetics in ggplot, then add geometries
ggplot(data = all, mapping = aes(x = comfort_level, y = current_use, color = grade)) +
  geom_line() + geom_point()

# Fit a line
ggplot(data = all, mapping = aes(x = comfort_level, y = current_use, color = grade)) + 
  geom_smooth() + geom_point(alpha = 0.3)
# geom_smooth(se = FALSE) # don't show the gray line that shows "Standard Error"

### 3. Bars and columns ========================================================

# geom_bar() # creates a bar graph, specify x, count rows for y
# geom_col() # creates a column graph, specify x, can also specify y

ggplot(data = all) +
  geom_bar(mapping = aes(x = comfort_level, fill = grade)) # Comfort Level

ggplot(data = all) +
  geom_bar(mapping = aes(x = current_use, fill = grade)) # Comfort Level

# Find average comfort_level by group
all %>%
  group_by(group) %>%
  summarize(average_comfort = mean(comfort_level)) %>%
  ggplot() +
  geom_col(mapping = aes(x = group, y = average_comfort))

### 4. Histograms ==============================================================

# Check comfort_level
hist(all$comfort_level)

# ggplot()
ggplot(data = all) +
  geom_histogram(mapping = aes(x = comfort_level), bins = 5) # specify bins to get fuller graph

# Check current_use
hist(all$current_use)

# ggplot()
ggplot(data = all) +
  geom_histogram(mapping = aes(x = current_use), bins = 5, binwidth = 2) # specify binwidth for groups of x

# Check materials
hist(all$materials)

# ggplot()
ggplot(data = all) +
  geom_histogram(mapping = aes(x = materials), bins = 4, origin = 0) # specify origin to starting point

### 5. Box plots ===============================================================

# Scatterplot
ggplot(data = all) +
  geom_point(mapping = aes(x = grade, y = comfort_level))

# Jitter plot
ggplot(data = all) +
  geom_jitter(mapping = aes(x = grade, y = comfort_level))

# Box plot
ggplot(data = all) +
  geom_boxplot(mapping = aes(x = grade, y = current_use)) # not really enough data it looks like, but current_use is better

## Beautify Visualizations #####################################################

### 1. Background ==============================================================

# plot.background (behind everything)
# panel.background (chart bg)
# panel.grid.major, panel.grid.minor
# modify color, thickness, presence, etc

ggplot(data = all) +
  geom_bar(mapping = aes(x = comfort_level, fill = grade)) + # Comfort Level
  theme(
    plot.background = element_rect(fill = 'white'),
    panel.background = element_blank(),
    panel.grid.major.y = element_line(color = 'gray'),
    panel.grid.minor.x = element_line(color = 'lightgray')
  )

### 2. Axes ====================================================================

ggplot(data = all) +
  geom_bar(mapping = aes(x = comfort_level, fill = grade)) + # Comfort Level
  theme(
    plot.background = element_rect(fill = 'white'),
    panel.background = element_blank(),
    panel.grid.major.y = element_line(color = 'gray'),
    panel.grid.minor.x = element_line(color = 'lightgray')
  ) +
  ylab('Number of respondents') + 
  xlab('Comfort Level with Technology in School') +
  ylim(0,60)

### 3. Scales ==================================================================

# scale_name_datatype, examples below
# scale_x_discrete
# scale_y_continuous

ggplot(data = all) +
  geom_bar(mapping = aes(x = comfort_level, fill = grade)) + # Comfort Level
  theme(
    plot.background = element_rect(fill = 'white'),
    panel.background = element_blank(),
    panel.grid.major.y = element_line(color = 'gray'),
    panel.grid.minor.x = element_line(color = 'lightgray')
  ) +
  scale_x_discrete(name = 'Current comfort level') +
  scale_y_continuous(name = 'Number of teachers', limits = c(0,60)) +
  scale_fill_manual(values = c('red', 'green'))

### 4. Legends & Titles ========================================================

ggplot(data = all) +
  geom_bar(mapping = aes(x = comfort_level, fill = grade)) + # Comfort Level
  theme(
    plot.background = element_rect(fill = 'white'),
    panel.background = element_blank(),
    panel.grid.major.y = element_line(color = 'gray'),
    panel.grid.minor.x = element_line(color = 'lightgray')
  ) +
  ylab('Number of respondents') + 
  xlab('Comfort Level with Technology in School') +
  ylim(0,60) +
  scale_fill_manual(values = c('purple', 'green'),
                    guide = guide_legend(title = 'School Type',
                                         nrow = 1,
                                         label.position = 'bottom',
                                         keywidth = 2)) +
  theme(legend.position = 'bottom') +
  ggtitle('Comfort level with Technology in School',
          subtitle = 'Source: Surveys conducted 2020, 2021')

### 5. Annotations =============================================================

# annotate() # adds text and shpes
# geom_hline() # adds horizontal lines
# geom_vline() # adds vertical lines

ggplot(data = all) + 
  geom_point(mapping = aes(x = comfort_level, y = current_use, shape = grade, color = grade, alpha = 0.6, size = 2)) +
  annotate('text', label = 'Majority rules', x = 3, y = 4.5) +
  geom_hline(yintercept = mean(all$current_use)) +
  annotate('text', label = 'Mean Comfort Level', x = 3, y = mean(all$current_use) - 0.125) +
  geom_vline(xintercept = mean(all$comfort_level)) +
  annotate('text', label = 'Mean Comfort Level', x = mean(all$comfort_level) - 0.125, y = 3) +
  theme(panel.background = element_blank(), legend.key = element_blank()) +
  scale_color_discrete(name = 'School') + 
  scale_size_continuous(name = 'Grade') +
  scale_x_discrete(name = 'Comfort') +
  scale_y_discrete(name = 'Use')

### 6. Predefined Themes =======================================================

# theme_bw(), theme_minimal(), theme_void(), theme_dark(), 

install.packages('ggthemes')
# theme_solarized(), theme_excel(), theme_wsj(), theme_economist(), theme_fivethirtyeight()

ggplot(data = all) +
  geom_bar(mapping = aes(x = comfort_level, fill = grade)) + # Comfort Level
  theme_bw() +
  ylab('Number of respondents') + 
  xlab('Comfort Level with Technology in School') +
  ylim(0,60) +
  scale_fill_manual(values = c('purple', 'green'),
                    guide = guide_legend(title = 'School Type',
                                         nrow = 1,
                                         label.position = 'bottom',
                                         keywidth = 2)) +
  theme(legend.position = 'bottom') +
  ggtitle('Comfort level with Technology in School',
          subtitle = 'Source: Surveys conducted 2020, 2021')

## SAVE Data ###################################################################

### 1. Rdata files =============================================================

iettp <- all
save(iettp, file = 'learning-r/project-edu/data/iettp_data.rdata')

rm(list = ls()) # remove all objects from environment

load('learning-r/project-edu/data/iettp_data.rdata') # reload data
iettp # check state of data

# Or, using rio, can set it to a DIFFERENT DataFrame name (not iettp)
new_iettp <- import('learning-r/project-edu/data/iettp_data.rdata') %>%
  print()

### 2. RDS files ===============================================================

# RDS = serialized data file

iettp %>% saveRDS('learning-r/project-edu/data/iettp_data.rds')

# Or use write_rds() from tidyverse which is NOT compressed (but may be a time saver)
# iettp %>% write_rds('learning-r/project-edu/data/iettp_data2.rds')

# Three options for READING RDS data
# 1. Base R's readRDS()
# 2. readr's read_rds()
# 3. rio's import() - shows data in the console by itself

rds_iettp <- import('learning-r/project-edu/data/iettp_data.rds') %>%
  print()

