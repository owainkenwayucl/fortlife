c     This module contains routines for manipulating 1D arrays like 2D 
c     periodic boundary contructs.  
c
c     Arrays are of character  This is because the byte is the smallest data
c     type in F77.
c     
c     F77 doesn't have allocatable arrays, so create arrays of a max size.
c
c     1 = alive
c     0 = dead

c     Create an uninitialised array.
      subroutine cuarr(arr, m)
        implicit none
        integer m
        character arr(m)
        integer i

        do i = 1, m
          arr(i) = '0'
        end do
      end

c     Calc array loc
c     Note: x, y co-ords start at zero, 1D array at 1.
      function locate(w, h, x, y)
        implicit none
        integer s, w, h, x, y, remain, locate
        s = w * h
        locate = remain((((y*w) + x)+1), s)
      end

c     Fortran 77 doesn't have the modulo intrinsic.  Woe!
c     This calculates the similar for +ve p, but where 0 => max val due to 
c     Fortran arrays starting at 1! 
      function remain(a, p)
        implicit none
        integer a, p, remain
        
        remain =  a - ((a/p) * p)
        if (remain .le. 0) then
          remain = remain + p
        endif
      end

c     Get value at x,y
      subroutine get(arr, m, w, h, x, y, v)
        implicit none
        integer m, w, h
        character arr(m), t
        integer x, y, v, l, locate

        t = '1'
        v = 0
        l = locate(w, h, x, y)

        if (arr(l) .eq. t) then
          v = 1
        endif

      end
        
c     Set value at x,y
      subroutine set(arr, m, w, h, x, y, v)
        implicit none
        integer m, w, h
        character arr(m)
        integer x, y, v, l, locate

        l = locate(w, h, x, y)

        if (v .eq. 1) then
          arr(l) = '1'
        else
          arr(l) = '0'
        endif
      end

c     Get 9way sum
      subroutine sum9w(arr, m, w, h, x, y, v)
        implicit none
        integer m, w, h
        character arr(m)
        integer x, y, v, l
        integer nw, no, ne, ea, we, sw, so, se

        call get(arr, m, w, h, x-1,y-1, nw)
        call get(arr, m, w, h, x, y-1, no)
        call get(arr, m, w, h, x+1, y-1, ne)
        call get(arr, m, w, h, x-1, y, ea)
        call get(arr, m, w, h, x, y, l)
        call get(arr, m, w, h, x+1, y, we)
        call get(arr, m, w, h, x-1, y+1, sw)
        call get(arr, m, w, h, x, y+1, so)
        call get(arr, m, w, h, x+1, y+1, se)

        v = nw + no + ne + ea + l + we + sw + so + se
      end

c     Calculate the population (sum)
      subroutine pop(arr, m, w, h, p)
        implicit none
        integer m, w, h, p
        character arr(m), v
        integer i, s
       
        p = 0
        s = w*h

        do i = 1, s
          v = arr(i)
          if (v .eq. '1') then
            p = p + 1
          endif
        enddo
      end
