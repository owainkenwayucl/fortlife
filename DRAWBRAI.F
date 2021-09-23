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

        fl = (w+1)/2

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

        fl = (w+1)/2

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

c     Draw a row of unicode characters encoding the 2x4 boxes as braille.
      subroutine pr2line(arr, m, w, h, y)
        use iso_fortran_env

        implicit none

        integer, parameter :: ucs4 = selected_char_kind('ISO_10646')

        character(kind=ucs4) :: outputchar
        integer :: base
        integer :: lookup(1:8)
        integer m, w, h, y
        character arr(m), tc
        character*4 e
        integer i, j, fl, t(1:8), idex

        e = '│'

        base = int(z'2800')
        lookup(1) = int(z'1')
        lookup(2) = int(z'8') 
        lookup(3) = int(z'2')
        lookup(4) = int(z'10')
        lookup(5) = int(z'4')
        lookup(6) = int(z'20')
        lookup(7) = int(z'40')
        lookup(8) = int(z'80')

        fl = (w+1)/2
   32   format(A,$)  
   33   format(A) 
        write(*,32) trim(e) 
        do i = 1, fl
          call get(arr, m, w, h, (i*2)-1, y, t(1))
          call get(arr, m, w, h, (i*2), y, t(2))
          call get(arr, m, w, h, (i*2)-1, y+1, t(3))
          call get(arr, m, w, h, (i*2), y+1, t(4))
          call get(arr, m, w, h, (i*2)-1, y+2, t(5))
          call get(arr, m, w, h, (i*2), y+2, t(6))
          call get(arr, m, w, h, (i*2)-1, y+3, t(7))
          call get(arr, m, w, h, (i*2), y+3, t(8))
          
          if ((y + 1) .gt. h) then
            t(3) = 0
            t(4) = 0
          endif
          if ((y + 2) .gt. h) then
            t(5) = 0
            t(6) = 0
          endif
          if ((y + 3) .gt. h) then
            t(7) = 0
            t(8) = 0
          endif
          if ((i + 1) .gt. w) then
            t(2) = 0
            t(4) = 0
            t(6) = 0
            t(8) = 0
          endif

          idex = base

          do j = 1,8 
            idex = idex + (t(j) * lookup(j))
          enddo
         outputchar =  char(idex, ucs4)
         open (output_unit, encoding='UTF-8')

         write(*,32) outputchar
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
        fh = (fh+3)/4
        call clearterm()
        call prtop(w)
        do i = 1, fh
          call pr2line(arr, m, w, h, (i*4)-3)
        enddo 
        call prbot(w)
      end 

! Clear the terminal (ANSI)
      subroutine clearterm()
        implicit none
        write(*,66) achar(27)//"[2J"//achar(27)//"[;H"

  66    format(A,$)
      end
