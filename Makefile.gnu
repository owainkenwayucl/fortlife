FC=gfortran

all: life.braille life.exe show.exe genblank.exe genrand.exe show.braille tidy

life.braille: LIFE.o PERIOD2D.o PBMTOOLS.o OUCHGNU.o DRAWBRAI.o 
	$(FC) -o life.braille LIFE.o PERIOD2D.o PBMTOOLS.o OUCHGNU.o DRAWBRAI.o

show.braille: SHOW.o PERIOD2D.o PBMTOOLS.o OUCHGNU.o DRAWBRAI.o
	$(FC) -o show.braille SHOW.o PERIOD2D.o PBMTOOLS.o OUCHGNU.o DRAWBRAI.o

life.exe: LIFE.o PERIOD2D.o PBMTOOLS.o OUCHGNU.o DRAWGNU.o
	$(FC) -o life.exe LIFE.o PERIOD2D.o PBMTOOLS.o OUCHGNU.o DRAWGNU.o

show.exe: SHOW.o PERIOD2D.o PBMTOOLS.o OUCHGNU.o DRAWGNU.o
	$(FC) -o show.exe SHOW.o PERIOD2D.o PBMTOOLS.o OUCHGNU.o DRAWGNU.o

genblank.exe: GENBLANK.o PERIOD2D.o PBMTOOLS.o OUCHGNU.o DRAWGNU.o
	$(FC) -o genblank.exe GENBLANK.o PERIOD2D.o PBMTOOLS.o OUCHGNU.o DRAWGNU.o

genrand.exe: GENRAND.o PERIOD2D.o PBMTOOLS.o OUCHGNU.o DRAWGNU.o
	$(FC) -o genrand.exe GENRAND.o PERIOD2D.o PBMTOOLS.o OUCHGNU.o DRAWGNU.o

LIFE.o: LIFE.F Makefile.gnu
	$(FC) -c LIFE.F

SHOW.o: SHOW.F Makefile.gnu
	$(FC) -c SHOW.F

GENBLANK.o: GENBLANK.F Makefile.gnu
	$(FC) -c GENBLANK.F

GENRAND.o: GENRAND.F Makefile.gnu
	$(FC) -c GENRAND.F

DRAWBRAI.o: DRAWBRAI.F Makefile.gnu
	$(FC) -c DRAWBRAI.F

DRAWGNU.o: DRAWGNU.F Makefile.gnu
	$(FC) -c DRAWGNU.F

OUCHGNU.o: OUCHGNU.F90 Makefile.gnu
	$(FC) -c OUCHGNU.F90

PERIOD2D.o: PERIOD2D.F Makefile.gnu
	$(FC) -c PERIOD2D.F

PBMTOOLS.o: PBMTOOLS.F Makefile.gnu
	$(FC) -c PBMTOOLS.F

tidy: 
	rm -f *.o

clean: 
	rm -f *.exe *.braille *.o 
