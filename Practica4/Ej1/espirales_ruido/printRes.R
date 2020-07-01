rm(list=ls())
library(tidyverse)
library(ggplot2)
library(ggpubr)
theme_set(theme_pubr())



setwd("/home/pablo/Desktop/Facultad/5to\ año/Machine-Learning/Practica4/Ej1/espirales_ruido/")
datos <- read.table("c_2.predic",header = FALSE,sep= "\t",col.names = c("x0","x1","x2","x3","class"))
myColors <- c("blue","green")
plot <- ggplot(datos,aes(x=x0,y=x1,colour = as.factor(class))) +
  geom_point() +
  labs(y ="x0",x="x1") +
  scale_colour_manual(name= "Clase",values=myColors) +
  theme(legend.position='none') +
  ggtitle("Predicciones con KNN")

datos <- read.table("c_2.prediction",header = FALSE,sep= "\t",col.names = c("x0","x1","x2","x3","class"))
myColors <- c("blue","green")
plot2 <- ggplot(datos,aes(x=x0,y=x1,colour = as.factor(class))) +
  geom_point() +
  labs(y ="x0",x="x1") +
  scale_colour_manual(name= "Clase",values=myColors) +
  theme(legend.position='none') +
  ggtitle("Predicciones con C4-5")


all <- ggarrange(plot,plot2,ncol=2,nrow=1)
all

datos <- read.table("c_2.data",header = FALSE,sep= ",",col.names = c("x0","x1","x2","x3","class"))
c0 <- datos %>% filter(class == 0)
c1 <- datos %>% filter(class == 1)
plot(c0[,3],c0[,4])




datos <- read.table("c_0.data",header = FALSE,sep= ",",col.names = c("x0","x1","class"))
c0 <- datos %>% filter(class == 0)
c1 <- datos %>% filter(class == 1)
plot(c0[,1],c0[,2])
