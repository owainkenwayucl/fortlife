c     Tool to display the top left corner of a PBM file.
c     Owain Kenway, 2017
      program show
        implicit none

        integer n, l
        integer m

c     Maximum size of picture in bytes (cells).
        parameter (m = 1000000)

        character ar*1024, arr(m)
        integer w, h

        ar = ' '

c     Get args via our platform independent wrapper.
        call countargs(n)
        if (n .ge. 1) then
          call getargat(n, ar, l)
        else
          stop 'Invoke with: show.exe <filename>'
        endif

        call cuarr(arr, m)
        call readpbm(arr, m, w, h, ar)
        call pr2box(arr, m, w, h)

      end

