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
jju20_clean <- jju20[c(1:3)] # Only what we want to keep

# Timestamp to Year
jju20_clean$Timestamp <- as.integer(2020)

# Rename columns
jju20_clean <- jju20_clean %>%
  rename(
    year = Timestamp,
    comfort_level = `1. Please indicate your current comfort level with technology.`,
    current_use = `2. How much technology do you use in the classroom currently?`
  )

# Clean or substitute values
jju20_clean$comfort_level <- as.integer(gsub(':.*', '', jju20_clean$comfort_level))
jju20_clean$current_use <- as.integer(gsub(':.*', '', jju20_clean$current_use))

# Add distinguishing column
jju20_clean <- cbind(jju20_clean, group = 'One')

# Rearrange columns
jju20_clean <- jju20_clean[, c(1,4,2,3)]

# Drop NA
jju20_clean <- jju20_clean %>% drop_na()

str(jju20_clean) # Check datatypes

### 2. JBNU 2020 ===============================================================

jbnu20

# Clean up columns
jbnu20_clean <- jbnu20[c(1:3)] # Only what we want to keep

# Timestamp to Year
jbnu20_clean$Timestamp <- as.integer(2020)

# Rename columns
jbnu20_clean <- jbnu20_clean %>%
  rename(
    year = Timestamp,
    comfort_level = `1. Please indicate your current comfort level with technology.`,
    current_use = `2. How much technology do you use in the classroom currently?`
  )

# Clean or substitute values
jbnu20_clean$comfort_level <- as.integer(gsub(':.*', '', jbnu20_clean$comfort_level))
jbnu20_clean$current_use <- as.integer(gsub(':.*', '', jbnu20_clean$current_use))

# Add distinguishing column
jbnu20_clean <- cbind(jbnu20_clean, group = 'Two')

# Rearrange columns
jbnu20_clean <- jbnu20_clean[, c(1,4,2,3)]

# Drop NA
jbnu20_clean <- jbnu20_clean %>% drop_na()

str(jbnu20_clean) # Check datatypes

### 3. JJU 2021:1 ==============================================================

jju21_1

# Clean up columns
jju21_1_clean <- jju21_1[,c(1,10:12)] # only what we want to keep

# Timestamp to Year
jju21_1_clean$Timestamp <- as.integer(2021)

# Add distinguishing group column
jju21_1_clean <- cbind(jju21_1_clean, group = 'Three')

# Rearrange columns
jju21_1_clean <- jju21_1_clean[, c(1,5,3,4,2)]

# Rename columns
jju21_1_clean <- jju21_1_clean %>%
  rename(
    year = Timestamp,
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
jju21_2_clean <- jju21_2[,c(1,11:13)] # only what we want to keep

# Timestamp to Year
jju21_2_clean$Timestamp <- as.integer(2021)

# Add distinguishing group column
jju21_2_clean <- cbind(jju21_2_clean, group = 'Four')

# Rearrange columns
jju21_2_clean <- jju21_2_clean[, c(1,5,3,4,2)]

# Rename columns
jju21_2_clean <- jju21_2_clean %>%
  rename(
    year = Timestamp,
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

## Data Analysis ###############################################################

# Check comfort_level
hist(all$comfort_level)

# Check current_use
hist(all$current_use)

# Check materials
hist(all$materials)