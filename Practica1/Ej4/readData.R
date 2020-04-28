library(tidyverse)
library(ggplot2)
library(ggpubr)
theme_set(theme_pubr())




setwd("/home/pablo/Desktop/Facultad/5to\ año/Machine-Learning/Practica1/Ej4/")
paths <- c("Muestra150/m1.prediction","Muestra600/m2.prediction","Muestra3000/m3.prediction")
plots <- list()
tags <- c("150","600","3000")

myColors <- c("blue","red")

for (i in 1:3){
  datos <- read.table(paths[i],header = FALSE,sep= "\t",col.names = c("x0","x1","class"))
  plots[[i]] <- ggplot(datos,aes(x=x0,y=x1,colour = as.factor(class))) +
                geom_point() +
                labs(y ="",x="") +
                scale_colour_manual(name= "Clase",values=myColors) +
                theme(legend.position='none') +
                ggtitle(paste("Size of training data = ",tags[i],sep = " "))
  }


plots[[1]] <- plots[[1]] + theme(legend.position='left') + labs(x="X0",y="X1")

all <- ggarrange(plots[[1]],plots[[2]],plots[[3]],ncol=3,nrow=1) +
       ggtitle("Clasificación obtenida a partir de cada árbol creado")

print(all)

#IrisPlot <- ggplot(iris, aes(Petal.Length, Sepal.Length, colour = Species)) + geom_point()
#scale_colour_manual(values = c("Blue", "Red", "Green"))

#points(class1[,1],class1[,2],col="blue")
