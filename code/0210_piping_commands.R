# File:     0210_piping_commands.R
# Project:  Learning R

# The piping command %>% is included in the Tidyverse

# Rewrite the following difficult to read code with piping commands %>%
round(prop.table(margin.table(UCBAdmissions, 3)), 2) * 100

# With Piping
UCBAdmissions %>%     # goes to
  margin.table(3) %>% # which then goes to
  prop.table %>%      # and then goes to
  round(2) %>%        # and lastly
  multiply_by(100)

# General principle

# function(data) # we apply a function to some data
# data %>% function # with piping, send data to the function

# function(data, arg)
# data %>% function(arg)

# three(two(one(data, a), b), c)
# data %>%
#   one(a) %>%
#   two(b) %>%
#   three(c)
