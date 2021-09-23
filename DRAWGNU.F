c     This module provides routine for output when compiled with gfortran.

c     Output generation message. 
      subroutine wrgen(g, p)
        implicit none

        integer g, p
          write (*, 91) ' ↑ Generation:', g
          write (*, 91) '   Population:', p
  91      format(A,1I8,$)

      end

!     Top line
      subroutine prtop(w)
        implicit none

        integer i, w, fl
        character l*4, m*4 ,r*4
        
        l = '╭'
        m = '─'
        r = '╮'

        fl = w
   34   format(A,$)  
   35   format(A)  

        write(*,34) trim(l)

        do i = 1,fl
          write(*,34) trim(m)
        enddo
        if (fl .eq. 78) then
          write(*,34) trim(r)
        else
          write(*,35) trim(r)
        endif
      end

!     Bottom line
      subroutine prbot(w)
        implicit none

        integer i, w, fl
        character l*4, m*4 ,r*4

        r = '╯'
        m = '─'
        l = '╰'

        fl = w
   36   format(A,$)  
   37   format(A) 

        write(*,36) trim(l)

        do i = 1,fl
          write(*,36) trim(m)
        enddo
        write(*,37) trim(r)
      end


!     Draw a line 
      subroutine prline(arr, m, w, h, y)
        implicit none

        integer m, w, h, y
        character arr(m), e*4, t, f, tc
        integer i, fl, ti

        e = '│'
        t = 'o'
        f = ' '

        fl = w
   32   format(A,$)  
   33   format(A) 

        write(*,32) trim(e) 
        do i = 1, fl
          call get(arr, m, w, h, i, y, ti)
          if (ti .eq. 1) then
            tc = t
          else
            tc = f 
          endif
          write(*,32) tc
        enddo
        write(*,33) trim(e)
      end
c     Draw a double line (78 character + edges).
      subroutine pr2line(arr, m, w, h, y)
        implicit none

        integer m, w, h, y
        character arr(m) 
        character*4 p(0:3), e, tc
        integer i, fl, ti, tii, idex

        e = '│'

        p(0) = ' '
        p(1) = '▄' 
        p(2) = '▀'
        p(3) = '█'

        fl = w
   32   format(A,$)  
   33   format(A) 

        write(*,32) trim(e) 
        do i = 1, fl
          call get(arr, m, w, h, i, y, ti)
          if (y .eq. h) then
            tii = 0
          else
            call get(arr, m, w, h, i, (y+1), tii)
          endif
          idex = (2*ti) + tii
          tc = p(idex)
          if (idex .eq. 0) then
            write(*,32) ' '
          else  
            write(*,32) trim(tc)
          endif
        enddo
        write(*,33) trim(e)
      end

!     Print a period2d array
      subroutine prbox(arr, m, w, h )
        implicit none
 
        integer m, w, h, i, fh, maxl
        character arr(m)

        fh = h

        call prtop(w)
        do i = 1, fh
          call prline(arr, m, w, h, i)
        enddo 
        call prbot(w)
      end 

! Print a period2d array
      subroutine pr2box(arr, m, w, h )
        implicit none
 
        integer m, w, h, i, fh, maxl
        character arr(m)

        fh = h
        fh = (fh+1)/2
        call clearterm()
        call prtop(w)
        do i = 1, fh
          call pr2line(arr, m, w, h, (i*2)-1)
        enddo 
        call prbot(w)
      end 

! Clear the terminal (ANSI)
      subroutine clearterm()
        implicit none
        write(*,66) achar(27)//"[2J"//achar(27)//"[;H"

  66    format(A,$)
      end
