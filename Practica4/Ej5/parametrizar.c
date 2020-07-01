#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#define MAX 10000
#define SALTOS 5
int main(int argc, char** argv){
  FILE* fptr = fopen(argv[1],"r+");
  if(!fptr){
     printf("Error\n");
     return 0;
  }
  char data[MAX],data2[MAX],c;
  int i = 0;
  unsigned len = strlen(argv[2]);
  strncpy(data,argv[2],len);
  data[len] = '\n';
  while(fgetc(fptr) != '\n');
  for(;(data[len+i+1] = fgetc(fptr)) != EOF;i++);
  unsigned ctos = 0;
  for(i=0;ctos < SALTOS;i++)
         if(data[i] == '\n')ctos+=1;

  strncpy(data2,data,i);
  strncpy(data2+i,argv[3],strlen(argv[3]));
  for(;data[i] != '\n';i++);
  fseek(fptr,0,SEEK_SET);
  fprintf(fptr,"%s\n%s",data2,data+i+1);
  fclose(fptr);

}
