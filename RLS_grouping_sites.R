# TASK: group the sites into more manageble sites

rm(list=ls())
list.files()

list.of.packages <- c("tidyverse", "dplyr", "ggplot2")
new.packages     <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)
lapply(list.of.packages, require, character.only = TRUE)


d <- read.csv("siteData.csv")
head(d)

d2 <- d %>% select(SiteCode, Mean.lattitude, Mean.longitude, Wave.exposure, 
                   No.vertebrate.sp, Min.depth, Mean.visibility, nutrients, 
                   chlomean, sstmean, sstrange) 
d2 <- d2[!duplicated(d2), ]
head(d2)
plot(d2$Wave.exposure) #almost categorical
plot(d2)

d3 <- na.omit(d2)
set.seed(20)
clus <- kmeans(d3[,-1], 3, nstart = 20)
d2$cluster <- clus$cluster
d3[match(d3$SiteCode, d2$SiteCode),]$cluster <- clus$cluster
length(unique(d2$SiteCode))
which(table(d2$SiteCode) ==2)
d %>% filter(SiteCode=="1617")
nrow(d2[match(na.omit(d2)$SiteCode, d2$SiteCode),]$cluster)
