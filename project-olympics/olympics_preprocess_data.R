# File:    olympics.R
# Project: Olympics2020
# ==============================================================================

# INSTALL & LOAD PKGS ##########################################################

# pacman must already be installed; then load contributed
# packages (including pacman) with pacman
install.packages('pacman')
pacman::p_load(pacman, rio, tidyverse)

# LOAD & PREP ATHLETE DATA #####################################################

 df <- read.csv(file = '~/Desktop/Dev/learning-r/data/athletes_Tokyo_2020.csv')
head(df)

# Convert name, short_name, birth_place to Sentence Case
library(stringr)
df$name = str_to_title(df$name)
df$short_name = str_to_title(df$short_name)
df$birth_place = str_to_title(df$birth_place)
head(df)

# Remove unnecessary columns
df = subset(df, select = -c(short_name, birth_place, birth_country, discipline_code, residence_place, residence_country, url))
head(df)

# Change column names
colnames(df) <- c('Name', 'Sex', 'Age', 'Team', 'NOC', 'Sport', 'Height')
head(df)

# Fix height
p_load(magrittr) # to get arithmetic aliases

df$Height = str_extract(df$Height, '^.*(?=(/))')
df$Height = as.numeric(df$Height) * 100
head(df)

# Add appropriate columns (Games, Year, Season, City)
library(tibble)
df <- add_column(df, 'Games' = '2020 Summer', .after = 'NOC')
df <- add_column(df, 'Year' = '2020', .before = 'Sport')
df <- add_column(df, 'Season' = 'Summer', .before = 'Sport')
df <- add_column(df, 'City' = 'Tokyo', .before = 'Sport')

# Move height
df <- subset(df, select = c(Name:Age, Height, Team:Sport))
head(df)

# Calculate athlete age
# Ref: https://datacornering.com/how-to-calculate-age-in-r/
require(lubridate)
olympics_date <- as.Date('2021-07-23')
df$Age <- trunc((df$Age %--% olympics_date) / years(1))
head(df)

# Add ID column
# Ref: https://www.statology.org/add-index-column-to-data-frame-r/
df$ID <- 1:nrow(df) + 135571
df <- subset(df, select = c(ID, Name:Sport))
head(df)

# Add Weight column
df$Weight <- ''
df <- subset(df, select = c(ID:Height, Weight, Team:Sport))
head(df)

# Fix Sex column (only one letter, not the whole word)
df$Sex = substr(df$Sex,1,1)
head(df)

# LOAD & PREP MEDAL DATA #######################################################

df2 <- read.csv(file = '~/Desktop/Dev/learning-r/data/medals_Tokyo_2020.csv')
head(df2)

# Remove unnecessary columns
df2 = subset(df2, select = c(medal_type, medal_code, athlete_name, athlete_sex, country_code, event, discipline))
head(df2)

# Change column names
colnames(df2) <- c('Medal', 'Medal_code', 'Name', 'Sex', 'NOC', 'Event', 'Sport')
head(df2)

# Sentence case the names
df2$Name = str_to_title(df2$Name)
head(df2)

# Rearrange columns
df2 = subset(df2, select = c(Name, Sex, NOC, Sport, Event, Medal, Medal_code))
head(df2)

# COMPARE AND MERGE ############################################################

# Find number of duplicate IDs in Medals table
# This means these athletes won more than one medal

summary(df2) # 2401 total medals awarded
table(df2$Name)
print(anyDuplicated(df2$Name)) # 42 athletes are duplicated (winning more than once)

# Example: Dressel Caeleb (last name first) won THE MOST medals (5), let's find him
df2 %>%
  filter(Name == 'Dressel Caeleb') %>%
  print()

# ATTEMPT a merge
merge1 <- merge(df, df2, all = T, by = 'Name')
head(merge1)
summary(merge1)

# Find Abe Uta again
merge1 %>%
  filter(Name == 'Dressel Caeleb') %>%
  print()

# We have duplicate columns after the merge:
# Sex.x, Sex.y, NOC.x, NOC.y, Sport.x, Sport.y

# We assume that x (athletes) is the single source of truth
# For Caeleb Dressel (who won the MOST medals, 5):
# Sex.x is the same as Sex.y
# NOC.x is the same as NOC.y
# Sport.x is the same as Sport.y
# So, we can safely remove all the .y columns, and rename all the .x columns, reordering as we need

# Remove all .y columns
merge1 = subset(merge1, select = c(ID, Name, Sex.x, Age, Height, Weight, Team, NOC.x, Games:City, Sport.x, Event, Medal, Medal_code))
head(merge1)

# Rename .x columns
colnames(merge1) <- c('ID', 'Name', 'Sex', 'Age', 'Height', 'Weight', 'Team', 'NOC', 'Games', 'Year', 'Season', 'City', 'Sport', 'Event', 'Medal', 'Medal_code')
head(merge1)

# Change Medal column to lose the "medal" at the end
merge1$Medal = sub(" .*", "", merge1$Medal)

# Attempt to pull out the last name
merge1$LastName = word(merge1$Name, 1)
merge1$FirstName = word(merge1$Name, 2, -1)

# Find someone with a long name
merge1 %>%
  filter(LastName == 'Dohmen') %>%
  print()

# Find Dressel Caeleb again
merge1 %>%
  filter(Name == 'Dressel Caeleb') %>%
  print()

head(merge1)

# LOAD & PREP ORIGINAL DATA ####################################################

# Load original Olympics data (1896-2016)

df3 <- read.csv(file = '~/Desktop/Dev/learning-r/data/athletes_events_1896_2016.csv')
head(df3)

# Extract First and Last Names
df3$LastName = word(df3$Name, -1)
df3$FirstName = word(df3$Name, 1, -2)
head(df3)

# Add codes for medals
df3$Medal_code <- ifelse(df3$Medal == 'Gold', 1, ifelse(df3$Medal == 'Silver', 2, ifelse(df3$Medal == 'Bronze', 3, '')))
head(df3)

# Check by finding a Silver and Bronze medalist
# Silver
df3 %>%
  filter(Name == 'Bla Zulawszky') %>%
  print()

# Bronze
df3 %>%
  filter(Name == 'Fritz Zulauf') %>%
  print()

df3 = subset(df3, select = c(ID:Medal, Medal_code, LastName, FirstName))
head(df3)

# Check that the IDs at the end of original Olympics data match the beginning of Tokyo data
tail(df3)
head(merge1)

# Concatenate the two dataframes with rbind()
all <- rbind(df3, merge1)
head(all)
tail(all)

# EXPORT ALL TO CSV ############################################################

write.csv(df3, '~/Desktop/Dev/learning-r/data/olympics_1896_2016.csv', row.names = F)
write.csv(merge1, '~/Desktop/Dev/learning-r/data/olympics_2020_Tokyo.csv', row.names = F)
write.csv(all, '~/Desktop/Dev/learning-r/data/olympics_1896_2020.csv', row.names = F)
