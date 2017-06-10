c     This module provides routines for output using codepage 437 chars
c     when compiled with Open Watcom F77 on FreeDOS.

c     Print a generation number label.
      subroutine wrgen(g, p)
        implicit none

          integer g, p

          write (*, 91) '  Generation:', g, '        Population:', p
  91      format(A,1I8,$)

      end


c     Top line.
      subroutine prtop(w)
        implicit none

        integer i, w, fl
        character l, m ,r
        
        r = char(191)
        m = char(196)
        l = char(218)

        fl = w
        if (w .ge. 78) then
          fl = 78
        endif
   34   format(A1,$)  
   35   format(A1)  

        write(*,34) l

        do i = 1,fl
          write(*,34) m
        enddo
        if (fl .eq. 78) then
          write(*,34) r
        else
          write(*,35) r
        endif
      end

c     Bottom line.
      subroutine prbot(w)
        implicit none

        integer i, w, fl
        character l, m ,r

        r = char(217)
        m = char(196)
        l = char(192)

        fl = w
        if (w .ge. 78) then
          fl = 78
        endif
   36   format(A1,$)  
   37   format(A1) 

        write(*,36) l

        do i = 1,fl
          write(*,36) m
        enddo
        if (fl .eq. 78) then
          write(*,36) r
        else
          write(*,37) r
        endif
      end


c     Draw a line (78 character + edges).
      subroutine prline(arr, m, w, h, y)
        implicit none

        integer m, w, h, y
        character arr(m), e, t, f, tc
        integer i, fl, ti

        e = char(179)
        t = 'o'
        f = ' '

        fl = w
        if (w .gt. 78) then
          fl = 78
        endif
   32   format(A1,$)  
   33   format(A1) 

        write(*,32) e 
        do i = 1, fl
          call get(arr, m, w, h, i, y, ti)
          if (ti .eq. 1) then
            tc = t
          else
            tc = f 
          endif
          write(*,32) tc
        enddo
        if (fl .eq. 78) then
          write(*,32) e
        else
          write(*,33) e
        endif
      end

c     Draw a double line (78 character + edges).
      subroutine pr2line(arr, m, w, h, y)
        implicit none

        integer m, w, h, y
        character arr(m), e, tc, p(0:3)
        integer i, fl, ti, tii, idex

        e = char(179)

        p(0) = ' '
        p(1) = char(220)
        p(2) = char(223)
        p(3) = char(219)

        fl = w
        if (w .gt. 78) then
          fl = 78
        endif
   32   format(A1,$)  
   33   format(A1) 

        write(*,32) e 
        do i = 1, fl
          call get(arr, m, w, h, i, y, ti)
          if (y .eq. h) then
            tii = 0
          else
            call get(arr, m, w, h, i, (y+1), tii)
          endif
          idex = (2*ti) + tii
          tc = p(idex)
          write(*,32) tc
        enddo
        if (fl .eq. 78) then
          write(*,32) e
        else
          write(*,33) e
        endif
      end


c     Print a period2d array.
      subroutine prbox(arr, m, w, h )
        implicit none
 
        integer m, w, h, i, fh, maxl
        character arr(m)

        maxl = 22
        fh = h
        if (h .gt. maxl) then
          fh = maxl
        endif

        call prtop(w)
        do i = 1, fh
          call prline(arr, m, w, h, i)
        enddo 
        call prbot(w)
      end 

c     Print a period2d array, double lines.
      subroutine pr2box(arr, m, w, h )
        implicit none
 
        integer m, w, h, i, fh, maxl
        character arr(m)

        maxl = 44
        fh = h
        if (h .gt. maxl) then
          fh = maxl
        endif
        fh = (fh+1)/2
        call prtop(w)
        do i = 1, fh
          call pr2line(arr, m, w, h, (i*2)-1)
        enddo 
        call prbot(w)
      end 

