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

        character opt*1024, ar*1024, arr(m), instr, t*8, ofn*1024
        integer w, h, i, p, it, fnw, nfnw, realln, ltln, rofnl
        logical inter, running, wrt

        ar = ' '
        inter = .TRUE.
        wrt = .FALSE.
c     Get args via our platform independent wrapper.
        call countargs(n)
        if (n .ge. 1) then
          call getargat(1, ar, l)
        else
          stop 'Invoke with: life.exe <filename> [<n> [<prefix>]]'
        endif
        if (n .ge. 2) then
          call getargat(2, opt, l)
          read(opt, *) it
          inter = .FALSE.
        endif
        if (n .ge. 3) then
          call getargat(3, opt, l)
          wrt = .TRUE.
          write(t, '(1I8)') it
          nfnw = ltln(t)
          fnw = 9-nfnw 
        endif

c     Initialise our simulation, load file, draw it.
        call cuarr(arr, m)
        call readpbm(arr, m, w, h, ar)
        call pr2box(arr, m, w, h)

c     Our main loop - continue at return press until ^C.
        i = 0
        call pop(arr, m, w, h, p)
        call wrgen(i, p)
        running = .TRUE.
        do while (running)
          i=i+1
          if (inter) then
            read(*,'(A)') instr
          else
            write(*,*) ' '
            if (i .ge. it) then
              running = .FALSE.
            endif
            if (wrt .eqv. .FALSE.) then
              call sleep(1)
            endif
          endif
          call update(arr, m, w, h)
          if (wrt) then
            call genname(opt, fnw, i, ofn)
            rofnl = realln(ofn)
            write(*,*) ' '
            write(*,*) ' Writing: ', ofn(:rofnl)
            call writepbm(arr, m, w, h, ofn)

          else
            call pr2box(arr, m, w, h)
          endif
          call wrgen(i, p)
          call pop(arr, m, w, h, p)
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

c     File name generation.
      subroutine genname(prefix, w, n, nm)
        implicit none

        integer w, n, realln, rl
        character prefix*1024, nm*1024, F*20

        rl =  realln(prefix)
        write(F, 202) '(A,1I', w, '.', w , ',A)'
202     format(A,I1,A,I1,A,$)
        write(nm, F) prefix(:rl), n, '.pbm'

      end 

c     Calculate the real length of a string.
      function realln(arg)
        implicit none
 
        character arg*1024
        integer realln, i
        logical nfound

        i = 1024
        nfound = .TRUE.
        do while (nfound)
          if (arg(i:i) .ne. ' ') then
            nfound = .FALSE.
            realln = i
          endif
          i = i - 1
          if (i .eq. 0) then
            realln = 0
            nfound = .FALSE.
          endif
        enddo
      end

c     Work out how many spaces at start of string
      function ltln(arg)
        implicit none
 
        character arg*8
        integer ltln, i
        logical nfound

        i = 1
        nfound = .TRUE.
        do while (nfound)
          if (arg(i:i) .ne. ' ') then
            nfound = .FALSE.
            ltln = i
          endif
          i = i + 1
          if (i .gt. 8) then
            ltln = 8
            nfound = .FALSE.
          endif
        enddo

      end


