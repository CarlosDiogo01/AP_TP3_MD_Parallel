all: MD_OMP

MD_OMP : *.c
	gcc -O3 -fopenmp -o MD_OMP MD.c Particle.c Random.c main.c -lm -Wall

.PHONY: clean

clean:
	rm MD_OMP
	rm MD_OMP.e*
	rm MD_OMP.o*
