# Lifelong Learning Analysis

install.packages('ggthemes')
library('tidyverse')

## KO Data: Attitudes ##########################################################
attitudes <- read.csv(file.choose())
attitudes$Year <- as.factor(attitudes$Year)

summary(attitudes)

### 1. Korean Data =============================================================

# Remove new info
att_ko <- attitudes[c(1:8), c(1:9)] # Rows, Columns

att_ko <- pivot_longer(att_ko, col = !Year, names_to = 'Question', values_to = 'Percent')

custom.col <- c("#FFDB6D", "#C4961A", "#F4EDCA",
                "#D16103", "#C3D7A4", "#52854C", "#4E84C4", "#293352", "#000000", "#555555")

# ggthemes Tableau colors: https://yutannihilation.github.io/allYourFigureAreBelongToUs/ggthemes/tableau_color_pal/
tableau.col <- c("#1F77B4", "#AEC7E8", "#FF7F0E", "#FFBB78", "#2CA02C",
                 "#98DF8A", "#D62728", "#FF9896", "#9467BD", "#C5B0D5",
                 "#8C564B", "#C49C94", "#E377C2", "#F7B6D2", "#7F7F7F",
                 "#C7C7C7", "#BCBD22", "#DBDB8D", "#17BECF", "#9EDAE5")

# Plot
ggplot(data = att_ko, aes(x = Year, fill = Question, y = Percent/100)) +
  geom_bar(stat = "identity", position="dodge") +
  geom_text(aes(label = round(Percent, digits = 2)),
            vjust = 1.5, color = 'white', position = position_dodge(.9), size = 3) +
  # coord_flip() +
  ggtitle("Attitudes toward Lifelong Learning",
          subtitle = "Data Source: KOSIS.kr") +
  theme(legend.position = "bottom",
        axis.title.x = element_blank()) +
  guides(fill=guide_legend(title=NULL,ncol=1)) +
  scale_fill_manual(values = custom.col) +
  scale_y_continuous(name = "", labels = scales::percent, limits = c(0,1))

### 2. NEW Data ================================================================

att_new <- attitudes[c(9:10), c(1:11)]

att_new <- pivot_longer(att_new, cols = !Year, names_to = 'Question', values_to = 'Percent')
att_new

att_new$Percent

ggplot(data = att_new, aes(x = Year, fill = Question, y = Percent/100)) +
  geom_bar(stat = "identity", position="dodge") +
  geom_text(aes(label = round(Percent, digits = 2)),
            vjust = 1.5, color = 'white', position = position_dodge(.9), size = 3) +
  # coord_flip() +
  ggtitle("Attitudes toward Lifelong Learning 2021 Survey",
          subtitle = "Survey conducted online") +
  theme(legend.position = "bottom",
        axis.title.x = element_blank()) +
  guides(fill=guide_legend(title=NULL,ncol=1)) +
  scale_fill_manual(values = custom.col) +
  scale_y_continuous(name = "", labels = scales::percent, limits = c(0,1))

### 3. School Type =============================================================

att_sch <- attitudes[c(12:14), c(1:11)]

att_sch <- pivot_longer(att_sch, cols = !Year, names_to = 'Question', values_to = 'Percent')

ggplot(data = att_sch, aes(x = Year, fill = Question, y = Percent/100)) +
  geom_bar(stat = "identity", position="dodge") +
  geom_text(aes(label = round(Percent, digits = 2)),
            vjust = 1.5, color = 'white', position = position_dodge(.9), size = 3) +
  # coord_flip() +
  ggtitle("Attitudes toward Lifelong Learning 2021 Survey",
          subtitle = "Survey conducted online") +
  theme(legend.position = "bottom",
        axis.title.x = element_blank()) +
  guides(fill=guide_legend(title=NULL,ncol=1)) +
  scale_fill_manual(values = custom.col) +
  scale_y_continuous(name = "", labels = scales::percent, limits = c(0,1))

### 4. Comparison ==============================================================

att_com <- attitudes[c(8,11), c(1:11)]

att_com <- pivot_longer(att_com, cols = !Year, names_to = 'Question', values_to = 'Percent')

# att_com$Question <- factor(att_com$Question, levels = sort(levels(att_com$Question), T))

ggplot(data = att_com, aes(x = Year, fill = Question, order = Question, y = Percent/100)) +
  geom_bar(stat = "identity", position="dodge") +
  geom_text(aes(label = round(Percent, digits = 2)),
            vjust = 1.5, color = 'white', position = position_dodge(.9), size = 3) +
  # coord_flip() +
  ggtitle("Attitudes toward Lifelong Learning 2021 Survey",
          subtitle = "Survey conducted online") +
  theme(legend.position = "bottom",
        axis.title.x = element_blank()) +
  guides(fill=guide_legend(title=NULL,ncol=1)) +
  scale_fill_manual(values = custom.col) +
  scale_y_continuous(name = "", labels = scales::percent, limits = c(0,1))

## KO Data: Participation ######################################################

participation <- read.csv(file.choose())

summary(participation)

part <- pivot_longer(participation, cols = !Year, names_to = 'Type', values_to = 'Percent')
part$Year <- as.factor(part$Year)

ggplot(data = part, aes(x = Year, fill = Type, order = Type, y = Percent/100)) +
  geom_bar(stat = "identity", position="dodge") +
  geom_text(aes(label = round(Percent, digits = 2)),
            vjust = 1.5, color = 'white', position = position_dodge(.9), size = 3) +
  # coord_flip() +
  ggtitle("Participation Rate in Lifelong Learning",
          subtitle = "Data Source: KOSIS.kr") +
  theme(legend.position = "bottom",
        axis.title.x = element_blank()) +
  guides(fill=guide_legend(title=NULL,ncol=1)) +
  scale_fill_manual(values = tableau.col) +
  scale_y_continuous(name = "", labels = scales::percent, limits = c(0,0.5))
