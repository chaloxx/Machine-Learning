setwd("/home/pablo/Desktop/Facultad/5to\ año/Machine-Learning/Practica3/Ej3/dos_elipses/")
datos <- read.table("vals",sep = " ",header = FALSE)
cat(median(datos[,1]),median(datos[,2]))
