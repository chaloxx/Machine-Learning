rm(list=ls())
library(tidyverse)
library(ggplot2)
library(ggpubr)
theme_set(theme_pubr())



setwd("/home/pablo/Desktop/Facultad/5to\ año/Machine-Learning/Practica2/dos_elipses/")
datos <-read.table("dos_elipses.mse",sep = "\t",header = FALSE)
n <- nrow(datos)
labels <- c("Train","Validación","Test")
colors <- c("Train" = "blue","Validación" = "red", "Test" = "yellow")
df <- data.frame(epoca=c(1:n,1:n,1:n),
                 errores=c(datos[,2],datos[,3],datos[,4]),
                 class=c(rep(labels[1],n),rep(labels[2],n),rep(labels[3],n)) )

plot <-  ggplot(df,aes(x=epoca,y=errores,colour=as.factor(class))) +
         geom_line() +
         labs(x = "NERROR (x*200 = número de épocas)",y = "MSE",color = "Legend") +
         scale_colour_manual(name= "",values=colors) +
         theme(legend.position='top') +
         theme(plot.title = element_text(hjust = 0.5)) + 
         ggtitle("Momentum: 0.5, Learning-rate: 0.01")

plot

