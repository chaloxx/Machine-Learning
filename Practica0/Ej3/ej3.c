 #include <stdio.h>
#include <math.h>
#include <time.h>
#include <stdlib.h>
#include <stdbool.h>
#define  COTA  8*M_PI
double aux(int pot){
   return (float) (rand() % 10) / pow(10,pot);
}

// Generar número "real" aleatorio en el intervalo [leftLim,rightLim]
double floatRanGen(double leftLim, double rightLim){
  double diff = rightLim-leftLim;
  double res = 0, dec = 0, cent = 0, mil = 0, partEnt = 0;
  do{
  partEnt = rand() % ((int)floor(diff)+1);
  dec = aux(1);
  cent = dec + aux(2);
  mil = cent + aux(3);
  res = partEnt + mil;
  } while(res > diff);
  return leftLim + res;
}



double func1(double r){
  return floatRanGen(r*4*M_PI-M_PI,r*4*M_PI);
}

double func2(double r){
  return floatRanGen(r*4*M_PI,r*4*M_PI+M_PI);
}


void genCoord(double xOrigen,double yOrigen,double* vals,double (*func) (double), double class){
  double r = 0, theta = 0,x = 0,y = 0;
  r =  sqrt(floatRanGen(0,1));
  theta = func(r) ; // Generamos un ángulo en términos de radianes
  vals[0] = xOrigen + r*cos(theta); // Coordenada x
  vals[1] = yOrigen + r*sin(theta); // Coordenada y
  vals[2] = class;
}



void showRes(int n, int d, double vals[n][d+1]){
  FILE* fptr = fopen("ej3.R","w");
  if (fptr ==  NULL) {
    printf("Error\n");
    return;
  }
  for(int i = 0; i < d;i++){
    fprintf(fptr,"col_%d <- c(",i);
    for(int j = 0; j < n;j++){
      fprintf(fptr,"%f",vals[j][i]);
      if (j+1 < n) fprintf(fptr,",");
    }
    fprintf(fptr,")\n");
  }
  fprintf(fptr, "r <- seq(from = 0, to = 1, by = 0.01)\n" \
                 "g <- r*4*pi - pi\n" \
                 "x <- r*cos(g)\n" \
                 "y <- r*sin(g)\n" \
                "plot(x,y,type = \"l\", col = \"red\")\n" \
                "g <- r*4*pi\n" \
                "x <- r*cos(g)\n" \
                "y <- r*sin(g)\n" \
                "points(x,y,type = \"l\", col = \"blue\")\n" \
                "points(col_0,col_1)");
  fclose(fptr);
}




int writeEntries(int n, int d, double entries[n][d+1]){
  FILE *fptr = fopen("ej3.data","w");
  if (fptr == NULL){
    printf("Error\n");
    return 1;
  }

  for(int i = 0; i < n;i++)

    for(int j = 0; j < d+1; j++){
      if(j < d)fprintf(fptr,"%f,",entries[i][j]);
      else fprintf(fptr, "%d\n",(int)entries[i][j]);
    }

  fclose(fptr);
  return 0;
}



int writeNames(int d){
  FILE *fptr = fopen("ej3.names","w");
  if (fptr == NULL){
    printf("Error\n");
    return 1;
  }

  fprintf(fptr, "0,1.\n");
  for(int i = 0; i < d;i++)
    fprintf(fptr, "x%d:continuous.\n",i);
  fclose(fptr);
  return 0;
}

int main(int argc, char** argv){
  if (argc != 4){
    printf("Error en la cantidad de argumentos\n");
    return 1;
  }
  time_t t;
  srand(time(&t));
  // Cantidad de samples
  int n = atoi(argv[1]);
  // Coordenadas de referencia
  double xOrigen = atof(argv[2]), yOrigen = atof(argv[3]);
  // Matriz para llenar con datos
  double vals[n][3];
  int i = 0;
  writeNames(2);
  for(; i < n/2;i++)
      genCoord(xOrigen,yOrigen,vals[i],func1,0);
  for(; i < n ;i++)
      genCoord(xOrigen,yOrigen,vals[i],func2,1);
  writeEntries(n,2,vals);
}
