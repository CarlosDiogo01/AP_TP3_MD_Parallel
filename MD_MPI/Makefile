all: MD_OMP

MD_OMP : *.c
	mpicc -O3 -fopenmp -o MD_MPI MD.c Particle.c Random.c main.c -lm -Wall

.PHONY: clean

clean:
	rm MD_MPI
	rm MD_MPI.e*
	rm MD_MPI.o*
