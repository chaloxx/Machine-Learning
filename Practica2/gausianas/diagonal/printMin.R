setwd("/home/pablo/Desktop/Facultad/5to\ año/Machine-Learning/Practica2/gausianas/diagonal/")

datos <- read.table("diagonal.mse",sep = "\t",header = FALSE)
epocas <- 1:nrow(datos)
#plot(epocas,datos[,5],col="red",type="l",xlab="Épocas",ylab="Error %",ylim=c(0,1))
#points(epocas,datos[,6],col="blue",type="l")
#points(epocas,datos[,7],col="yellow",type="l")
i <- which.min(datos[,6])
cat(datos[i,5],datos[i,7])

