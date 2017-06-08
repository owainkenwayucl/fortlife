c     Code to abstract OW specific calls.
c     I intend to implement versions of this for other compilers, most
c     specifically gfortran and NAG.
c
c     Owain Kenway

c     Equivalent of iargc
      subroutine countargs(n)
        
        implicit none
        integer         n, iargc

        n = iargc() - 1
      end

c     Equivalent of igetarg
      subroutine getargat(n, s, l)
  
        implicit none
        integer         n, l, igetarg
        character*1024  s

        l = igetarg(n, s)
      end

c     Equivalent of gettim
      subroutine getsec(t)
     
        implicit none
        real            t
        integer*2       hrs, mins, sec, hsec

        call gettim(hrs,mins,sec,hsec)
        t = (3600*hrs) + (60*mins) + sec + (hsec/100.0)
      end
