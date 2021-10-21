if (!require('pacman')) install.packages('pacman')

pacman::p_load(datasets, pacman, tidyverse, tsibble, lubridate, XML, rio)

learning <- as_tibble(read.csv(file.choose(), stringsAsFactors = F))
learning

learning2 <- learning %>%
  pivot_longer(
    X2007:X2020.3,
    names_to = 'year',
    values_to = 'value',
    values_drop_na = T
  )
learning2

learning3 <- learning2 %>%
  mutate(year = as.integer(gsub('X', '', year))) %>%
  select(year, By.Classification.1., By.Classification.2., value)
learning3

learning4 <- learning3 %>%
  pivot_wider(names_from = value, values_from = value)
