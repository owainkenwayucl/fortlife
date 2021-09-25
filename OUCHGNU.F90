! Code to abstract GFortran specific calls.
! Owain Kenway

! Equivalent of iargc
subroutine countargs(n)
  use ISO_FORTRAN_ENV
  implicit none

  integer, intent(out) :: n

  n = command_argument_count()
end

! Equivalent of getarg
subroutine getargat(n, s, l)
  use ISO_FORTRAN_ENV
  implicit none

  integer, intent(in) :: n
  integer, intent(out) :: l
  character (len=1024), intent(out) :: s

  call get_command_argument(n, length=l)
  call get_command_argument(n, s)
end

! Get time in seconds
subroutine getsec(t)
  use ISO_FORTRAN_ENV
  implicit none

  real, intent(out) :: t

  call cpu_time(t)
end

! Start random number generation.
! Technically we don't need to do anything in OpenWatcom
subroutine initrand(seed)
  implicit none

  integer, intent(in) :: seed

  call srand(seed)
end

! Get next number.
! Need to pass seed as that's always needed by OpenWatcom
function getrand(seed)
  implicit none

  real :: getrand
  integer :: seed

  getrand = rand()

end

! Sleep that only happens on DOS
  subroutine dossleep(seconds)
    implicit none
    integer :: seconds
  end
