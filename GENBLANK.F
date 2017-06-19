c     Utility to generate blank PBMs
c
c     Owain Kenway, 2017
      program genblank
        implicit none

        integer n, l
        integer m

c     Maximum size of simulation in bytes (cells).
        parameter (m = 1000000)

        character opt*1024, ar*1024, arr(m)
        integer w, h

        ar = ' '
c     Get args via our platform independent wrapper.
        call countargs(n)
        if (n .ge. 3) then
          call getargat(3, ar, l)
          call getargat(1, opt, l)
          read(opt,*) w
          call getargat(2, opt, l)
          read(opt,*) h 
        else
          stop 'Invoke with: genblank.exe <w> <h> <filename>'

        endif

c     Initialise our simulation, load file, draw it.
        call cuarr(arr, m)
        write(*,*) 'Writing...'
        call writepbm(arr, m, w, h, ar)

      end

