<<<<<<< HEAD
##### Delta Life Cycle Grid #####

# loading libraries
library(dplyr)
library(reshape2)
library(ggplot2)
library(lubridate)

set.seed(10)
# creating orders data sample
orders <- data.frame(clientId = sample(c(1:1500), 5000, replace = TRUE),
                     orderdate = sample((1:500), 5000, replace = TRUE))
orders$orderdate <- as.Date(orders$orderdate, origin = "2012-01-01")

# specifying reporting dates for monthly analysis
rep.dates <- seq(as.Date('2012-11-01', format = '%Y-%m-%d'),
                 as.Date('2013-05-01', format = '%Y-%m-%d'), "month")

# creating empty data frames
lcg.cache <- data.frame()
lcg <- data.frame()

# creating LCG for each reporting date
for (i in c(1:length(rep.dates))) {
  
  customers <- orders %>%
    filter(orderdate < rep.dates[i]) %>%
    group_by(clientId) %>%
    summarise(frequency = n(),
              recency = as.numeric(rep.dates[i] - max(orderdate))) %>%
    # adding segments
    mutate(segm.freq = ifelse(between(frequency, 1, 1), '1',
                              ifelse(between(frequency, 2, 2), '2',
                                     ifelse(between(frequency, 3, 3), '3',
                                            ifelse(between(frequency, 4, 5), '4-5', '>5'))))) %>%
    mutate(segm.rec = ifelse(between(recency, 0, 30), '0-30 days',
                             ifelse(between(recency, 31, 90), '31-90 days',
                                    ifelse(between(recency, 91, 180), '91-180 days', '>180 days')))) %>%
    ungroup()
  
  # defining order of boundaries
  customers$segm.freq <- factor(customers$segm.freq, levels = c('>5', '4-5', '3', '2', '1'))
  customers$segm.rec <- factor(customers$segm.rec, levels = c('>180 days', '91-180 days', '31-90 days', '0-30 days'))
  
  # creating LCG as of reporting date
  lcg.cache <- customers %>%
    group_by(segm.freq, segm.rec) %>%
    summarise(quantity = n()) %>%
    ungroup() %>%
    mutate(repdate = format(rep.dates[i], format = '%Y-%m'))
  
  # binding all LCGs
  lcg <- rbind(lcg, lcg.cache)
}

# calculating Delta LCG
delta.lcg <- lcg %>%
  group_by(segm.freq, segm.rec) %>%
  arrange(repdate) %>%
  mutate(prev = lag(quantity),
         delta = quantity - prev) %>%
  # removing base reporting period
  na.omit() %>%
  ungroup()

# plotting results
ggplot(delta.lcg, aes(x = repdate, y = delta, fill = repdate)) +
  theme_bw() +
  theme(panel.grid = element_blank(),
        axis.text.x = element_text(size = 8, angle = 90, hjust = 0.5, vjust = 0.5, face = "plain"),
        legend.title = element_blank()) +
  geom_bar(stat = 'identity', alpha = 0.6) +
  geom_text(aes(y = 0, label = delta), color = 'darkred', vjust = 0, size = 5, fontface = "bold") +
  facet_grid(segm.freq ~ segm.rec) +
  xlab("Reporting Date") +
  ylab("Delta Value") +
  ggtitle("Delta LifeCycle Grids")

ggplot(delta.lcg, aes(x = repdate, y = delta, fill = repdate)) +
  theme_bw() +
  theme(panel.grid = element_blank(),
        axis.text.x = element_text(size = 8, angle = 90, hjust = 0.5, vjust = 0.5, face = "plain"),
        legend.title = element_blank()) +
  geom_bar(stat = 'identity', alpha = 0.6) +
  geom_bar(aes(y = quantity, color=repdate), stat = 'identity', alpha=0) +
  geom_text(aes(y = 0, label = delta), color = 'darkred', vjust = 0, size = 5, fontface = "bold") +
  geom_text(aes(y = quantity, label = quantity), vjust = 0, size = 4) +
  facet_grid(segm.freq ~ segm.rec) +
  xlab("Reporting Date") +
  ylab("Delta Value") +
  ggtitle("Delta LifeCycle Grids")
=======
##### Delta Life Cycle Grid #####

## This is the test of the git hub.


# loading libraries
library(dplyr)
library(reshape2)
library(ggplot2)
library(lubridate)

set.seed(10)
# creating orders data sample
orders <- data.frame(clientId = sample(c(1:1500), 5000, replace = TRUE),
                     orderdate = sample((1:500), 5000, replace = TRUE))
orders$orderdate <- as.Date(orders$orderdate, origin = "2012-01-01")

# specifying reporting dates for monthly analysis
rep.dates <- seq(as.Date('2012-11-01', format = '%Y-%m-%d'),
                 as.Date('2013-05-01', format = '%Y-%m-%d'), "month")

# creating empty data frames
lcg.cache <- data.frame()
lcg <- data.frame()

# creating LCG for each reporting date
for (i in c(1:length(rep.dates))) {
  
  customers <- orders %>%
    filter(orderdate < rep.dates[i]) %>%
    group_by(clientId) %>%
    summarise(frequency = n(),
              recency = as.numeric(rep.dates[i] - max(orderdate))) %>%
    # adding segments
    mutate(segm.freq = ifelse(between(frequency, 1, 1), '1',
                              ifelse(between(frequency, 2, 2), '2',
                                     ifelse(between(frequency, 3, 3), '3',
                                            ifelse(between(frequency, 4, 5), '4-5', '>5'))))) %>%
    mutate(segm.rec = ifelse(between(recency, 0, 30), '0-30 days',
                             ifelse(between(recency, 31, 90), '31-90 days',
                                    ifelse(between(recency, 91, 180), '91-180 days', '>180 days')))) %>%
    ungroup()
  
  # defining order of boundaries
  customers$segm.freq <- factor(customers$segm.freq, levels = c('>5', '4-5', '3', '2', '1'))
  customers$segm.rec <- factor(customers$segm.rec, levels = c('>180 days', '91-180 days', '31-90 days', '0-30 days'))
  
  # creating LCG as of reporting date
  lcg.cache <- customers %>%
    group_by(segm.freq, segm.rec) %>%
    summarise(quantity = n()) %>%
    ungroup() %>%
    mutate(repdate = format(rep.dates[i], format = '%Y-%m'))
  
  # binding all LCGs
  lcg <- rbind(lcg, lcg.cache)
}

# calculating Delta LCG
delta.lcg <- lcg %>%
  group_by(segm.freq, segm.rec) %>%
  arrange(repdate) %>%
  mutate(prev = lag(quantity),
         delta = quantity - prev) %>%
  # removing base reporting period
  na.omit() %>%
  ungroup()

# plotting results
ggplot(delta.lcg, aes(x = repdate, y = delta, fill = repdate)) +
  theme_bw() +
  theme(panel.grid = element_blank(),
        axis.text.x = element_text(size = 8, angle = 90, hjust = 0.5, vjust = 0.5, face = "plain"),
        legend.title = element_blank()) +
  geom_bar(stat = 'identity', alpha = 0.6) +
  geom_text(aes(y = 0, label = delta), color = 'darkred', vjust = 0, size = 5, fontface = "bold") +
  facet_grid(segm.freq ~ segm.rec) +
  xlab("Reporting Date") +
  ylab("Delta Value") +
  ggtitle("Delta LifeCycle Grids")

ggplot(delta.lcg, aes(x = repdate, y = delta, fill = repdate)) +
  theme_bw() +
  theme(panel.grid = element_blank(),
        axis.text.x = element_text(size = 8, angle = 90, hjust = 0.5, vjust = 0.5, face = "plain"),
        legend.title = element_blank()) +
  geom_bar(stat = 'identity', alpha = 0.6) +
  geom_bar(aes(y = quantity, color=repdate), stat = 'identity', alpha=0) +
  geom_text(aes(y = 0, label = delta), color = 'darkred', vjust = 0, size = 5, fontface = "bold") +
  geom_text(aes(y = quantity, label = quantity), vjust = 0, size = 4) +
  facet_grid(segm.freq ~ segm.rec) +
  xlab("Reporting Date") +
  ylab("Delta Value") +
  ggtitle("Delta LifeCycle Grids")
>>>>>>> This is the test commit
