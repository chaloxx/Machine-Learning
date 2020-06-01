rm(list=ls())
library(tidyverse)
library(ggplot2)
library(ggpubr)
theme_set(theme_pubr())



setwd("/home/pablo/Desktop/Facultad/5to\ año/Machine-Learning/Practica3/Ej3/espirales/")


myColors <- c("green","black")
datos <- read.table("espirales.data",header = FALSE,sep= ",",col.names = c("x0","x1","class"))


plot1 <- ggplot(datos,aes(x=x0,y=x1,colour = as.factor(class))) +
        geom_point() +
        labs(y ="x0",x="x1") +
        scale_colour_manual(name= "Clase",values=myColors) +
        theme(legend.position='none') +
        ggtitle("Datos de entrenamiento")

plot1   

clase0 <- datos %>% filter(class==0)
clase1 <- datos %>% filter(class==1)

datos <- read.table("nb.predic",header = FALSE,sep= "\t",col.names = c("x0","x1","class"))
plot2 <- ggplot(datos,aes(x=x0,y=x1,colour = as.factor(class))) +
         geom_point() +
        labs(y ="",x="") +
        scale_colour_manual(name= "Clase",values=myColors) +
        theme(legend.position='none') +
        ggtitle("Naive Bayes")

all <- ggarrange(plot1,plot2,ncol=2,nrow=1)
print(all)
        
        

