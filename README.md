# Conway's Game of Life in Fortran for FreeDOS

This is a fairly simple implementation of Conway's Game of Life, written in Fortran 77 for the Open Watcom compiler on FreeDOS, but which also compiles on GFortran on Linux.

![Photo of fortlife running on FreeDOS](https://pbs.twimg.com/media/DBexs7TW0AIRzaK.jpg:large)

## Compilation

On FreeDOS, install the Open Watcom Fortran compiler, download the repository and then compile the code by running `wmake`.  Optionally, you can also compile a tool for displaying PBM files by running `wmake show.exe`.

On Linux, you can compile the code with gfortran by running `make -f Makefile.gnu`.  You can also build the show utility, but you are better of using basically any other image viewer.

(Testing has shown that the Linux version of `life.exe` compiles successfully under Cygwin, the only downside being font support in MinTTY).

There is a special Linux version if your font has braille characters, which can be run by running `life.braille`.

## Running

To run the code, run `life.exe <inputfile>` for some input PBM file.  Some examples can be found in the `input` directory.

The program will draw the file into the terminal, move forward a generation with each press of the `Enter` key. Press `ctrl-c`, `Enter` to quit (the last `Enter` is not necessary on Linux).

Here is the output when run on Linux (note, you need a Unicode supporting terminal):

```none
$ ./life.exe input/eater.pbm 
╭──────────────────────────────────────────────────╮
│                         ▄                        │
│             ▄▄      ▄▄▀ ▀         ▄▄             │
│ ▄▄        ▄▀   ▀▄   ██            ▀▀             │
│ ▀▀        █   ▀ █▀    ▀ █                        │
│            ▀▄▄ ▀                                 │
│                                                  │
│                                                  │
│                                                  │
│                                                  │
│                                 ▄▄               │
│                                 ▀ █              │
│                                   ▀▀             │
│                                                  │
│                                                  │
│                                                  │
╰──────────────────────────────────────────────────╯
 ↑ Generation:       0   Population:      43
```

On github the text above looks pretty terrible (this shows the importance of font choice when running the code).

In `gnome-terminal`, this is what the code looks like:

![Screenshot of fortlife running on Linux](https://pbs.twimg.com/media/DB-eaAaWsAAHDLy.png:large)

Here is the output of the braille version (again this looks awful on Github):

```none
./life.braille input/eater.pbm 
╭─────────────────────────╮
│⠀⠀⠀⠀⠀⠀⢀⡀⠀⠀⢀⡠⠰⠀⠀⠀⠀⢀⡀⠀⠀⠀⠀⠀⠀│
│⠰⠆⠀⠀⠀⢰⠁⠠⢱⠄⠘⠣⢠⠀⠀⠀⠀⠈⠁⠀⠀⠀⠀⠀⠀│
│⠀⠀⠀⠀⠀⠀⠑⠂⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀│
│⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀│
│⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡀⠀⠀⠀⠀⠀⠀⠀│
│⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠸⠄⠀⠀⠀⠀⠀⠀│
│⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀│
│⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀│
╰─────────────────────────╯
 ↑ Generation:       0   Population:      43
╭─────────────────────────╮
│⠀⠀⠀⠀⠀⠀⢀⠀⠀⠀⢀⢄⠆⠀⠀⠀⠀⢀⡀⠀⠀⠀⠀⠀⠀│
│⠰⠆⠀⠀⠀⢴⡏⠀⢰⡆⠑⠜⡄⠀⠀⠀⠀⠈⠁⠀⠀⠀⠀⠀⠀│
│⠀⠀⠀⠀⠀⠀⠙⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀│
│⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀│
│⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡀⠀⠀⠀⠀⠀⠀⠀│
│⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠸⠄⠀⠀⠀⠀⠀⠀│
│⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀│
│⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀│
╰─────────────────────────╯
 ↑ Generation:       1   Population:      46
╭─────────────────────────╮
│⠀⠀⠀⠀⠀⠀⣀⠀⠀⠀⢀⢔⡄⠀⠀⠀⠀⢀⡀⠀⠀⠀⠀⠀⠀│
│⠰⠆⠀⠀⠀⡎⠨⠀⢔⡲⠙⢜⠇⠀⠀⠀⠀⠈⠁⠀⠀⠀⠀⠀⠀│
│⠀⠀⠀⠀⠀⠈⠚⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀│
│⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀│
│⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡀⠀⠀⠀⠀⠀⠀⠀│
│⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠸⠄⠀⠀⠀⠀⠀⠀│
│⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀│
│⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀│
╰─────────────────────────╯
 ↑ Generation:       2   Population:      50^C
$ 
```

And, as before, a screenshot:

![Screenshot of fortlife running on Linux](https://pbs.twimg.com/media/DCX0haOXgAE2H-E.png:large)

