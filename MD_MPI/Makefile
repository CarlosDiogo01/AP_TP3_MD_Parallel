all: MD_MPI

MD_MPI : *.c
	mpicc -O3 -o MD_MPI MD.c Particle.c Random.c main.c -lm -Wall

.PHONY: clean

clean:
	rm MD_MPI
	rm MD_MPI.e*
	rm MD_MPI.o*
