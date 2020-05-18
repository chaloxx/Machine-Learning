library(tidyverse)
library(ggplot2)
library(ggpubr)
theme_set(theme_pubr())



setwd("/home/pablo/Desktop/Facultad/5to\ año/Machine-Learning/Practica2/espirales/")


myColors <- c("blue","red")
datos <- read.table("2/espirales.predic.d",header = FALSE,sep= "\t",col.names = c("x0","x1","class"))
plot1 <- ggplot(datos,aes(x=x0,y=x1,colour = as.factor(class))) +
        geom_point() +
        labs(y ="",x="") +
        scale_colour_manual(name= "Clase",values=myColors) +
        theme(legend.position='none') 

datos <- read.table("10/espirales.predic.d",header = FALSE,sep= "\t",col.names = c("x0","x1","class"))
plot2 <- ggplot(datos,aes(x=x0,y=x1,colour = as.factor(class))) +
         geom_point() +
        labs(y ="",x="") +
        scale_colour_manual(name= "Clase",values=myColors) +
        theme(legend.position='none') 
datos <- read.table("40/espirales.predic.d",header = FALSE,sep= "\t",col.names = c("x0","x1","class"))
plot3 <- ggplot(datos,aes(x=x0,y=x1,colour = as.factor(class))) +
         geom_point() +
         labs(y ="",x="") +
         scale_colour_manual(name= "Clase",values=myColors) +
         theme(legend.position='none') 


all <- ggarrange(plot1,plot2,plot3,ncol=3,nrow=1)
print(all)
        
        
        
