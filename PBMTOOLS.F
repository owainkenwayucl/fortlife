c     This module contains routines to read and write PBMs.

c     Write out as pbm
      subroutine writepbm(arr, m, w, h, fname)
        implicit none

        integer m, w, h, s, i, j, u, v
        character arr(m), fname*1024

        s = w * h
        u = 24
        open(u,FILE=fname)

c     Header
        write(u,'(A)') 'P1'
        write(u,'(2I8)') w, h 

        do j=1,h
          do i=1,w
           call get(arr, m, w, h,i, j, v)
           write(u,2) v
    2      format(I1,' ',$)  
          enddo
          write(u,*) ' '
        enddo

        close(u)
      end

c     Read in pbm
      subroutine readpbm(arr, m, w, h, fname)
        implicit none

        integer m, w, h,  i, j, u, v, pos
        character arr(m), fname*1024, ht*2, l*1024

        u = 24
        open(u,FILE=fname)

c     Header
        call skipcom(u, l)
        read(l,'(A)') ht
        call skipcom(u, l)
        read(l,*) w, h 
        do j = 1, h
          call skipcom(u, l)
          pos = 1
          do i = 1, w
            call nextc(l, pos, 1024, v)
            call set(arr, m, w, h, i, j, v)
          enddo
        enddo
        close(u)
      end

c Scan along a space separated line to find the next value (int 1/0).
      subroutine nextc(l, pos, w, v)
        implicit none

        integer v, pos, w
        character l*1024
        logical n0
        
        n0 = .FALSE.
        do while ((n0 .eqv. .FALSE.) .AND. (pos .le. w))
          if (l(pos:pos) .eq. '1') then
            v = 1
            n0 = .TRUE.
          else if (l(pos:pos) .eq. '0') then
            v = 0
            n0 = .TRUE.
          end if
          pos = pos + 1
        enddo
      end 

c Scan along a space separated line to find the next value (character).
      subroutine nextch(l, pos, w, v)
        implicit none

        integer pos, w
        character l*1024, v
        logical n0
        
        n0 = .FALSE.
        do while ((n0 .eqv. .FALSE.) .AND. (pos .le. w))
          if (l(pos:pos) .eq. ' ') then
            v = ' '
          else 
            v = l(pos:pos)
            n0 = .TRUE.
          end if
          pos = pos + 1
        enddo
      end 

c     Get the next line from a given unit that doesn't start with a #
      subroutine skipcom(u, l)
        implicit none

        character l*1024, v
        integer u, pos
        logical got

        got = .FALSE.
        do while (got .eqv. .FALSE.)
          read(u,'(A)') l
          pos = 1
          call nextch(l, pos, 1024, v)
          if (v .ne. '#') then
            got = .TRUE.
          end if
        enddo
      end
