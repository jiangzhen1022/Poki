#For Data Incubator application: Section 1
#Date: April 30, 2020
#Author: Zhen Jiang

#read in dataset:   
library("tidyverse")
require(tidyverse)  
 
library("ggplot2")  
require(ggplot2)

Poki <- read_csv(file="/Users/zjiang/Dropbox (Gladstone)/Zh-10-Personal/jobs/Data Incubator Bootcamp Application/2, Section 1/Data_sets/PoKi-Poems-by-Kids-master/poki-analysis.csv")

#count mean total words for each grade (combine genders)
PokiTotalGr <- Poki %>% group_by(grade) %>% summarise(avgTotalGr = mean(total_words, na.rm=TRUE))

#Figure 1, graph for total words in poem vs grade (combine genders).
#count mean total words for each grade & gender
PokiTotal <- Poki %>% group_by(grade, gender) %>% summarise(avgTotal = mean(total_words, na.rm=TRUE))


grades <- c(1:12)
grades<-as.character(grades)

g <- ggplot(data = PokiTotalGr, aes(x = grade, y=avgTotalGr))
g+geom_bar(stat = "identity", fill = "skyblue")+
  labs(x="Grade", title="Average Total Words in Poem Created by Grade 1-12")+
  ylab("Average Total Words")

#Figure 2, graph for total words in poem vs grade, separate genders.
grades <- c(1:12)
grades<-as.character(grades)

g <- ggplot(data = PokiTotal, aes(fill=gender, x = grade, y=avgTotal))
g+geom_bar(position="dodge", stat = "identity")+
  scale_fill_discrete(name = "Gender")+
  labs(x="Grade", title="Average Total Words in Poem Created by Grade 1-12 (Genders)")+
  ylab("Average Total Words")

#Figure 3, graph for total poem been created vs grade, separate gender for each bar.
g <- ggplot(data = Poki, aes(x = grade))
g+geom_bar(aes(fill=gender))+
  scale_fill_discrete(name = "Gender")+
  labs(x="Grade", title="Total Number of Poem Submitted by Grade 1-12")+
  ylab("Total Poem Created")

#figure 4, graph for emotion intensity for different grades.
#find avg for each emotion per grade
PokiEmotion <- Poki %>% group_by(grade) %>% summarise(Valence = mean(valence, na.rm=TRUE), Arousal = mean(arousal, na.rm=TRUE), Dominance = mean(dominance, na.rm=TRUE), Anger = mean(anger, na.rm=TRUE), Fear = mean(fear, na.rm=TRUE), Sadness=mean(sadness, na.rm=TRUE), Joy=mean(joy, na.rm=TRUE))

#transpose for plot lines
PokiEmotionT <- PokiEmotion %>% gather(key=emotion, value=Intensity, 2:8)

#plot lines:
g <- ggplot(data = PokiEmotionT, aes(x=grade, y=Intensity, color=emotion))
g+geom_line()+
  geom_point()+
  labs(x="Grade", title="Words' emotion intensity from poems submitted by childern ")+
  ylab("Average intensity of emotions")
