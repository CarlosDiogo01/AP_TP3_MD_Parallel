
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "Particle.h"
#include "MD.h"
#include "main.h"
#include "timer.h"
 void JGFvalidate(MD md){
	if(md.size<2){
	    double refval[]={1731.4306625334357, 7397.392307839352};
	    double dev=abs(md.ek-refval[md.size]);
	    if(dev>1.0e-12)
	    {
	      printf("Validation failed");
	      printf("Kinetic Energy = %f %f %d",md.ek,dev,md.size);
	    } /* else printf("Validado\n"); */
	}else printf("Tamanho nao reconhecido"); 
  }

int main(int argc, char  *argv[]){
    int size = 1;
    int datasizes[7] = {8,13,11,17,6,30,35};
    MD md;
    Particles particulas;
    
    if(argc > 1) size = atoi(argv[1]);          // If user set data from Input
    
    initialiseMD(&md,size,datasizes);           // Inicializar a estrutura MD
    createParticules(&particulas,md.mdsize);    // Criar Particulas
    initialiseParticles(&md,&particulas);       // Inicializar as particulas 
    runiters(&md,&particulas);                   // Run the algorithm
    JGFvalidate(md);                            // Validate the values obtained
    
    return 0;   
}
