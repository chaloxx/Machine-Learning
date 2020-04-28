#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>



double square(double x){
  return pow(x,2);
}



// Calcular densidad normal para val
float calcularNormal(float val, float desvEst, float mean){
  double var = pow(desvEst,2);
  return 1/(sqrt(2*M_PI) * desvEst) * exp(-square(val-mean)/(2*var) );

}

//Devuelve 1 si el punto es mal clasificado, sino 0
int bayesianClassifier(double* point,float desvEst, double* mean0, double* mean1,int class){
  double probClass0 = 1, probClass1 = 1;
  int res = 0;

  for(int i = 0;i < 5;i++)
      probClass0 *= calcularNormal(point[i],desvEst,mean0[i]);

  for(int i = 0;i < 5;i++)
      probClass1 *= calcularNormal(point[i],desvEst,mean1[i]);

   if (probClass1 > probClass0) res = 1;


  return res != class;
}




// Clasificador bayesiano para calcular el minimo error
// Que puede cometer un árbol de decisión
int main(int argc, char** argv){
  FILE* fptr;
  double mean0[] = {1,0,0,0,0} ,mean1[] = {-1,0,0,0,0};
  double c = atof(argv[2]), desvEst;
  if (!strcmp(argv[1],"diagonal")){
    desvEst = c*sqrt(5);
    fptr = fopen("Diagonal/diagonal.test","r");
    for(int i = 0; i < 5;i++){
      mean0[i] = 1;
      mean1[i] = -1;
    }
  }
  else if (!strcmp(argv[1],"paralelo")){
    desvEst = c;
    fptr = fopen("Paralelo/paralelo.test","r");
  }
  else{
    printf("Error fatal\n");
    return 0;
  }

  // Clasificación de bayes
  float ctos = 0;
  for(int i = 0; i < 10000;i++){
    char line[100];
    double point [5];
    int class = 0;
    fgets(line,100,fptr);
    point[0] = atof(strtok(line,","));
    for(int j = 1;j < 5;j++)
      point[j] = atof(strtok(NULL,","));

    class = atoi(strtok(NULL,","));
    ctos += bayesianClassifier(point,desvEst,mean0,mean1,class);
  }
  printf("%f\n",ctos/10000 * 100);
}
