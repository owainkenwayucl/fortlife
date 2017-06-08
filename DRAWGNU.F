c     This module provides routine for output when compiled with gfortran.

c     Output generation message. 
      subroutine wrgen(g)
        implicit none

        integer g
          write (*, 91) ' ^ Generation:', g
  91      format(A,1I8,$)

      end

!     Top line
      subroutine prtop(w)
        implicit none

        integer i, w, fl
        character l, m ,r
        
        r = '+'
        m = '-'
        l = '+'

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

!     Bottom line
      subroutine prbot(w)
        implicit none

        integer i, w, fl
        character l, m ,r

        r = '+'
        m = '-'
        l = '+'

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


!     Draw a line (78 character + edges)
      subroutine prline(arr, m, w, h, y)
        implicit none

        integer m, w, h, y
        character arr(m), e, t, f, tc
        integer i, fl, ti

        e = '|'
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

!     Print a period2d array
      subroutine prbox(arr, m, w, h )
        implicit none
 
        integer m, w, h, i, fh, maxl
        character arr(m)

        maxl = 46
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

! Print a period2d array
      subroutine pr2box(arr, m, w, h )
        implicit none
 
        integer m, w, h, i, fh, maxl
        character arr(m)

        call prbox(arr, m, w, h)
      end
