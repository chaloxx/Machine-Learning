#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#define MAX 10000
int main(int argc, char** argv){
  FILE* fptr = fopen(argv[1],"r+");
  if(!fptr){
     printf("Error\n");
     return 0;
  }
  char data[MAX];
  int i = 0;
  for(;(data[i] = fgetc(fptr)) != EOF;i++);
  data[i] = '\0';
  for(i=0;data[i] != '\n';i++);
  fseek(fptr,0,SEEK_SET);
  fprintf(fptr,"%s\n%s",argv[2],data+i+1);
  fclose(fptr);
}
