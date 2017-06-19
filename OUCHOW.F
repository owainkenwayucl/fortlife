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

c     Start random number generation.
c     Technically we don't need to do anything in OpenWatcom
      subroutine initrand(seed)
        implicit none

        integer seed, dummy

c       Do something with seed to supress warnings.
        dummy = seed

      end

c     Get next number.
c     Need to pass seed as that's always needed by OpenWatcom
      function getrand(seed)
        implicit none

        real getrand, urand
        integer seed

        getrand = urand(seed)

      end

