c     Utility to generate random PBMs
c
c     Owain Kenway, 2017
      program genrand
        implicit none

        integer n, l
        integer m

c     Maximum size of simulation in bytes (cells).
        parameter (m = 1000000)

        character opt*1024, ar*1024, arr(m)
        integer w, h, seed
        real p

        ar = ' '
c     Get args via our platform independent wrapper.
        call countargs(n)
        if (n .ge. 5) then
          call getargat(5, ar, l)
          call getargat(1, opt, l)
          read(opt,*) w
          call getargat(2, opt, l)
          read(opt,*) h 
          call getargat(3, opt, l)
          read(opt,*) p 
          call getargat(4, opt, l)
          read(opt,*) seed 
        else
          stop 'Invoke with: genrand.exe <w> <h> <p> <seed> <filename>'

        endif

c     Initialise our simulation, load file, draw it.
        call cuarr(arr, m)
        call randarr(arr, m, w, h, p, seed)
        write(*,*) 'Writing...'
        call writepbm(arr, m, w, h, ar)

      end

c     Fill an array with random 1/0s with a probability of being 1 of p.
      subroutine randarr(arr, m, w, h, p, seed)
        implicit none

        integer m
        character arr(m)
        integer i, w, h, s, seed
        real p, r, getrand

        s = w * h
        call initrand(seed)
        do i = 1, s 
          r = getrand(seed)
          if (r .gt. p) then
            arr(i) = '0'
          else
            arr(i) = '1'
          endif
        end do
      end
