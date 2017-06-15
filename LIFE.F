c     Conway's game of life
c     This implementation is mostly targetted at FreeDOS but also builds
c     (with more basic ASCII graphics) on GFortran on Linux.
c
c     Owain Kenway, 2017
      program life
        implicit none

        integer n, l
        integer m

c     Maximum size of simulation in bytes (cells).
        parameter (m = 1000000)

        character ar*1024, arr(m), instr
        integer w, h, i, p 

        ar = ' '

c     Get args via our platform independent wrapper.
        call countargs(n)
        if (n .ge. 1) then
          call getargat(1, ar, l)
        else
          stop 'Invoke with: life.exe <filename>'
        endif

c     Initialise our simulation, load file, draw it.
        call cuarr(arr, m)
        call readpbm(arr, m, w, h, ar)
        call pr2box(arr, m, w, h)

c     Our main loop - continue at return press until ^C.
        i = 0
        do 
          call pop(arr, m, w, h, p)
          call wrgen(i, p)
          read(*,'(A)') instr
          call update(arr, m, w, h)
          call pr2box(arr, m, w, h)
          i=i+1
        enddo

      end

c     Take a state in arr, size m,w,h and do one update.
      subroutine update(arr, m, w, h)
        implicit none

        integer m, w, h
        character arr(m), tmp(1000000)
        integer i, j, k, s9, n, o

        do j = 1, h
          do i = 1, w
            call get(arr, m, w, h, i, j, o)
            call sum9w(arr, m, w, h, i, j, s9)
            if (s9 .eq. 3) then
              n = 1
            else if (s9 .eq. 4) then
              n = o
            else 
              n = 0
            endif
            call set(tmp, m, w, h, i, j, n)
          enddo
        enddo
        do k = 1, m
          arr(k) = tmp(k)
        enddo
         
      end

