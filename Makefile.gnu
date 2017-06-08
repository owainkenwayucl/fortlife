FC=gfortran

life.exe: LIFE.o PERIOD2D.o PBMTOOLS.o OUCHGNU.o DRAWGNU.o
	$(FC) -o life.exe LIFE.o PERIOD2D.o PBMTOOLS.o OUCHGNU.o DRAWGNU.o

show.exe: SHOW.o PERIOD2D.o PBMTOOLS.o OUCHGNU.o DRAWGNU.o
	$(FC) -o show.exe SHOW.o PERIOD2D.o PBMTOOLS.o OUCHGNU.o DRAWGNU.o

LIFE.o: LIFE.F Makefile.gnu
	$(FC) -c LIFE.F

SHOW.o: SHOW.F Makefile.gnu
	$(FC) -c SHOW.F

DRAWGNU.o: DRAWGNU.F Makefile.gnu
	$(FC) -c DRAWGNU.F

OUCHGNU.o: OUCHGNU.F90 Makefile.gnu
	$(FC) -c OUCHGNU.F90

PERIOD2D.o: PERIOD2D.F Makefile.gnu
	$(FC) -c PERIOD2D.F

PBMTOOLS.o: PBMTOOLS.F Makefile.gnu
	$(FC) -c PBMTOOLS.F

clean: 
	rm -f test life.exe show.exe *.o out.pbm
