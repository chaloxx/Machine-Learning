rm(list=ls())
library(tidyverse)
library(ggplot2)
library(ggpubr)
theme_set(theme_pubr())



setwd("/home/pablo/Desktop/Facultad/5to\ año/Machine-Learning/Practica4/Ej1/espirales/")
datos <- read.table("knn-ruido.predic",header = FALSE,sep= "\t",col.names = c("x0","x1","class"))
myColors <- c("blue","green")
plot <- ggplot(datos,aes(x=x0,y=x1,colour = as.factor(class))) +
  geom_point() +
  labs(y ="x0",x="x1") +
  scale_colour_manual(name= "Clase",values=myColors) +
  theme(legend.position='none') +
  ggtitle("Predicciones con KNN")

datos <- read.table("c4-5-ruido.predic",header = FALSE,sep= "\t",col.names = c("x0","x1","x2","x3","class"))
myColors <- c("blue","green")
plot2 <- ggplot(datos,aes(x=x0,y=x1,colour = as.factor(class))) +
  geom_point() +
  labs(y ="x0",x="x1") +
  scale_colour_manual(name= "Clase",values=myColors) +
  theme(legend.position='none') +
  ggtitle("Predicciones con C4-5")


all <- ggarrange(plot,plot2,ncol=2,nrow=1)
all
