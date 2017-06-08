# Conway's Game of Life in Fortran for FreeDOS

This is a fairly simple implementation of Conway's Game of Life, written in Fortran 77 for the Open Watcom compiler on FreeDOS, but which also compiles on GFortran on Linux (with somewhat worse graphics).

![Photo of fortlife running on FreeDOS](https://pbs.twimg.com/media/DBexs7TW0AIRzaK.jpg:large)

## Compilation

On FreeDOS, install the Open Watcom Fortran compiler, download the repository and then compile the code by running `wmake`.  Optionally, you can also compile a tool for displaying PBM files by runnig `wmake show.exe`.

on linux, you can compile the code with gfortran by running `make -f makefile.gnu`.  You can also build the show utility, but you are better of using basically any other image viewer.

## Running

To run the code, run `life.exe <inputfile>` for some input PBM file.  Some examples can be found in the `input` directory.

The program will draw the file into the terminal, move forward a generation with each press of the `Enter` key. Press `ctrl-c`, `Enter` to quit (the last `Enter` is not necessary on Linux).
