setwd("/home/pablo/Desktop/Facultad/5to\ año/Machine-Learning/Practica2/faces_lr/")

datos <- read.table("faces_lr.mse",sep = "\t",header = FALSE)

epocas <- 1:nrow(datos)
plot(epocas,datos[,5],col="red",type="o",xlab="Épocas",ylab="Error de clasificación",ylim=c(0,1))
points(epocas,datos[,7],col="yellow",type="o")



