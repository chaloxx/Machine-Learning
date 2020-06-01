library(tidyverse)
library(ggplot2)
library(ggpubr)
theme_set(theme_pubr())



setwd("/home/pablo/Desktop/Facultad/5to\ año/Machine-Learning/Practica3/Ej6/dos_elipses/")


myColors <- c("green","black")
datos <- read.table("nn.predic",header = FALSE,sep= "\t",col.names = c("x0","x1","class"))
plot1 <- ggplot(datos,aes(x=x0,y=x1,colour = as.factor(class))) +
        geom_point() +
        labs(y ="x0",x="x1") +
        scale_colour_manual(name= "Clase",values=myColors) +
        theme(legend.position='none') +
        ggtitle("Neural Network")
        

datos <- read.table("nb.predic",header = FALSE,sep= "\t",col.names = c("x0","x1","class"))
plot2 <- ggplot(datos,aes(x=x0,y=x1,colour = as.factor(class))) +
         geom_point() +
        labs(y ="",x="") +
        scale_colour_manual(name= "Clase",values=myColors) +
        theme(legend.position='none') +
        ggtitle("Bayes No Ingenuo Con Discretización Recursiva")

plot2

all <- ggarrange(plot1,plot2,ncol=2,nrow=1)
print(all)


prob = "dos_elipses"
datos <- read.table(paste(prob,".error",sep=""),header=FALSE,sep=",",col.names=c("bins","trainError","validError","testError"))
attach(datos)



labels <- c("Train","Validación","Test")
n <- nrow(datos)
colors <- c("Train" = "blue","Validación" = "yellow", "Test" = "green")
df <- data.frame(bins=c(datos[,1],datos[,1],datos[,1]),
                 errores=c(datos[,2]*100,datos[,3]*100,datos[,4]*100),
                 class=c(rep(labels[1],n),rep(labels[2],n),rep(labels[3],n)))

plot <-  ggplot(df,aes(x=bins,y=errores,colour=as.factor(class))) +
        geom_line() +
        labs(x = "Cantidad de bins",y = "Error %",color = "Legend") +
        scale_colour_manual(name= "",values=colors) +
        theme(legend.position='top') +
        theme(plot.title = element_text(hjust = 0.5)) + 
        ggtitle("Errores de Naive Bayes Discreto")
plot

        
        
