all: MD_SEQ

MD_SEQ : *.c
	gcc -O3 -pg -o MD_SEQ MD.c Particle.c Random.c main.c -lm -Wall

.PHONY: clean

clean:
	rm MD_SEQ
