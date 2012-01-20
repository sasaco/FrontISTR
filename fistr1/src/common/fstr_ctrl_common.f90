!======================================================================!
!                                                                      !
! Software Name : FrontISTR Ver. 3.2                                   !
!                                                                      !
!      Module Name : I/O and Utility                                   !
!                                                                      !
!            Written by Noboru Imai (Univ. of Tokyo)                   !
!                                                                      !
!      Contact address :  IIS,The University of Tokyo, CISS            !
!                                                                      !
!      "Structural Analysis for Large Scale Assembly"                  !
!                                                                      !
!======================================================================!

!> \brief This module contains fstr control file data obtaining functions

module fstr_ctrl_common
use m_fstr
use hecmw
use mContact                                                            

implicit none

include 'fstr_ctrl_util_f.inc'

     private :: pc_strupr
	 
contains

subroutine pc_strupr( s )
        implicit none
        character(*) :: s
        integer :: i, n, a, da

        n = len_trim(s)
        da = iachar('a') - iachar('A')
        do i = 1, n
                a = iachar(s(i:i))
                if( a > iachar('Z')) then
                        a = a - da
                       s(i:i) = achar(a)
                end if
        end do
end subroutine pc_strupr


!> Read in !SOLUTION
function fstr_ctrl_get_SOLUTION( ctrl, type )
        integer(kind=kint) :: ctrl
        integer(kind=kint) :: type
        integer(kind=kint) :: fstr_ctrl_get_SOLUTION

        integer(kind=kint) :: rcode
        character(len=80) :: s

        s = 'ELEMCHECK,STATIC,EIGEN,HEAT,DYNAMIC,NLSTATIC '
        rcode = fstr_ctrl_get_param_ex( ctrl, 'TYPE ', s, 1, 'P', type )
        type = type -1
        fstr_ctrl_get_SOLUTION = rcode
end function fstr_ctrl_get_SOLUTION


!> Read in !SOLVER
function fstr_ctrl_get_SOLVER( ctrl, method, precond, nset, iterlog, timelog, nier, &
                                iterpremax, nrest, resid, singma_diag, sigma, thresh, filter )
        integer(kind=kint) :: ctrl
        integer(kind=kint) :: method
        integer(kind=kint) :: precond
        integer(kind=kint) :: nset
        integer(kind=kint) :: iterlog
        integer(kind=kint) :: timelog
        integer(kind=kint) :: nier
        integer(kind=kint) :: iterpremax
        integer(kind=kint) :: nrest
        real(kind=kreal) :: resid
        real(kind=kreal) :: singma_diag
        real(kind=kreal) :: sigma
        real(kind=kreal) :: thresh
        real(kind=kreal) :: filter
        integer(kind=kint) :: fstr_ctrl_get_SOLVER

        character(66) :: mlist = '1,2,3,4,101,CG,BiCGSTAB,GMRES,GPBiCG,DIRECT,DIRECTmkl,DIRECTlag '   

        integer(kind=kint) :: number_number = 5    
        integer(kind=kint) :: indirect_number = 4
        integer(kind=kint) :: iter, time

        fstr_ctrl_get_SOLVER = -1

        iter = iterlog+1
        time = timelog+1
        !* parameter in header line -----------------------------------------------------------------*!

        ! JP-0
        if( fstr_ctrl_get_param_ex( ctrl, 'METHOD ',   mlist,              1,   'P',   method  ) /= 0) return
        if( fstr_ctrl_get_param_ex( ctrl, 'PRECOND ', '1,2,3,10,11,12,21 ',0,   'I',   precond ) /= 0) return
        if( fstr_ctrl_get_param_ex( ctrl, 'NSET ',    '0,-1,+1 ',          0,   'I',   nset    ) /= 0) return
        if( fstr_ctrl_get_param_ex( ctrl, 'ITERLOG ', 'NO,YES ',           0,   'P',   iter ) /= 0) return
        if( fstr_ctrl_get_param_ex( ctrl, 'TIMELOG ', 'NO,YES ',           0,   'P',   time ) /= 0) return
        ! JP-1
        if( method > number_number ) then  ! JP-2
                method = method - number_number
                if( method > indirect_number ) then
                        ! JP-3
                        method = method - indirect_number + 100
                end if
        end if

        !* data --------------------------------------------------------------------------------------- *!

        ! JP-4
        if( fstr_ctrl_get_data_ex( ctrl, 1,   'iii ', nier, iterpremax, nrest   )/= 0) return
        if( fstr_ctrl_get_data_ex( ctrl, 2,   'rrr ', resid, singma_diag, sigma )/= 0) return

        if( precond == 21 ) then
                if( fstr_ctrl_get_data_ex( ctrl, 3, 'rr ', thresh, filter)/= 0) return
        end if

        iterlog = iter -1
        timelog = time -1

        fstr_ctrl_get_SOLVER = 0

end function fstr_ctrl_get_SOLVER


!> Read in !STEP                                                                            
function fstr_ctrl_get_STEP( ctrl, amp, iproc, incmax )
        integer(kind=kint) :: ctrl
        character(len=HECMW_NAME_LEN) :: amp
        integer(kind=kint) :: iproc
        integer(kind=kint) :: incmax
        integer(kind=kint) :: fstr_ctrl_get_STEP

        integer(kind=kint) :: ipt = 0
        integer(kind=kint) :: ip = 0

        fstr_ctrl_get_STEP = -1

        if( fstr_ctrl_get_param_ex( ctrl, 'AMP ',     '# ',  0, 'S', amp )/= 0) return
        if( fstr_ctrl_get_param_ex( ctrl, 'INCMAX ', '# ',           0,   'I',   incmax )/= 0) return
        if( fstr_ctrl_get_param_ex( ctrl, 'TYPE ',   'STANDARD,NLGEOM ', 0, 'P',   ipt    )/= 0) return
        if( fstr_ctrl_get_param_ex( ctrl, 'NLGEOM ',  '# ',           0,    'E',   ip     )/= 0) return

        if( ipt == 2 .or. ip == 1 ) iproc = 1

        fstr_ctrl_get_STEP = 0

end function fstr_ctrl_get_STEP

!> Read in !STEP and !ISTEP
logical function fstr_ctrl_get_ISTEP( ctrl, hecMESH, steps )
        use fstr_setup_util
        use m_step
        integer(kind=kint), intent(in)        :: ctrl      !< ctrl file
        type (hecmwST_local_mesh), intent(in) :: hecMESH   !< mesh information
        type(step_info), intent(out)          :: steps     !< step control info

        character(len=HECMW_NAME_LEN) :: data_fmt,ss, data_fmt1
        character(len=HECMW_NAME_LEN) :: amp
        character(len=HECMW_NAME_LEN) :: header_name 
        integer(kind=kint) :: bcid
        integer(kind=kint) :: i, n, sn, ierr
        integer(kind=kint) :: bc_n, load_n, contact_n
        real(kind=kreal) :: fn, f1, f2, f3

        fstr_ctrl_get_ISTEP = .false.

        write(ss,*)  HECMW_NAME_LEN
        write( data_fmt, '(a,a,a)') 'S', trim(adjustl(ss)), 'I '
        write( data_fmt1, '(a,a,a)') 'S', trim(adjustl(ss)),'rrr '

        call init_stepInfo(steps)
		steps%solution = stepStatic
        if( fstr_ctrl_get_param_ex( ctrl, 'TYPE ',   'STATIC,VISCO ', 0, 'P', steps%solution )/= 0) return
        if( fstr_ctrl_get_param_ex( ctrl, 'SUBSTEPS ',  '# ',  0, 'I', steps%num_substep )/= 0) return
        steps%initdt = 1.d0/steps%num_substep
        if( fstr_ctrl_get_param_ex( ctrl, 'INCMAX ',  '# ',  0, 'I', steps%max_incr )/= 0) return
        if( fstr_ctrl_get_param_ex( ctrl, 'ITMAX ',  '# ',  0, 'I', steps%max_iter )/= 0) return
        if( fstr_ctrl_get_param_ex( ctrl, 'MAXINC ',  '# ',  0, 'I', steps%max_incr )/= 0) return
        if( fstr_ctrl_get_param_ex( ctrl, 'MAXITER ',  '# ',  0, 'I', steps%max_iter )/= 0) return
        if( fstr_ctrl_get_param_ex( ctrl, 'CONVERG ',  '# ',  0, 'R', steps%converg )/= 0) return
        amp = ""
        if( fstr_ctrl_get_param_ex( ctrl, 'AMP ',  '# ',  0, 'S', amp )/= 0) return
        if( len( trim(amp) )>0 ) then
          call amp_name_to_id( hecMESH, '!STEP', amp, steps%amp_id ) 
        endif

        n = fstr_ctrl_get_data_line_n( ctrl )
        if( n == 0 ) then
          fstr_ctrl_get_ISTEP = .true.;  return
        endif

        if( fstr_ctrl_get_data_ex( ctrl, 1, data_fmt1, ss, f1, f2, f3  )/= 0) return
        read( ss, * , iostat=ierr ) fn		
        sn=1
        if( ierr==0 ) then
          steps%initdt = fn
          steps%elapsetime = f1
          steps%num_substep = int((f1+0.1*fn)/fn)
          !if( mod(f1,fn)/=0 ) steps%num_substep =steps%num_substep+1
          sn = 2
        endif

        bc_n = 0
        load_n = 0
        contact_n = 0
        do i=sn,n
          if( fstr_ctrl_get_data_ex( ctrl, i, data_fmt, header_name, bcid  )/= 0) return
          if( trim(header_name) == 'BOUNDARY' ) then
            bc_n = bc_n + 1
          else if( trim(header_name) == 'LOAD' ) then
            load_n = load_n +1
          else if( trim(header_name) == 'CONTACT' ) then       
            contact_n = contact_n+1
          else if( trim(header_name) == 'TEMPERATURE' ) then
         !   steps%Temperature = .true.
          endif
        end do

        if( bc_n>0 ) allocate( steps%Boundary(bc_n) )
        if( load_n>0 ) allocate( steps%Load(load_n) )
        if( contact_n>0 ) allocate( steps%Contact(contact_n) )

        bc_n = 0
        load_n = 0
        contact_n = 0
        do i=sn,n
          if( fstr_ctrl_get_data_ex( ctrl, i, data_fmt, header_name, bcid  )/= 0) return
          if( trim(header_name) == 'BOUNDARY' ) then
            bc_n = bc_n + 1
            steps%Boundary(bc_n) = bcid
          else if( trim(header_name) == 'LOAD' ) then
            load_n = load_n +1
            steps%Load(load_n) = bcid
          else if( trim(header_name) == 'CONTACT' ) then    
            contact_n = contact_n+1
            steps%Contact(contact_n) = bcid
          endif
        end do

        fstr_ctrl_get_ISTEP = .true.
    end function fstr_ctrl_get_ISTEP


!> Read in !WRITE                    
function fstr_ctrl_get_WRITE( ctrl, res, visual, femap )
        integer(kind=kint) :: ctrl
        integer(kind=kint) :: res
        integer(kind=kint) :: visual
        integer(kind=kint) :: femap
        integer(kind=kint) :: fstr_ctrl_get_WRITE

        fstr_ctrl_get_WRITE = -1

        ! JP-6
        if( fstr_ctrl_get_param_ex( ctrl, 'RESULT ',  '# ',    0,   'E',   res    )/= 0) return
        if( fstr_ctrl_get_param_ex( ctrl, 'VISUAL ',  '# ',    0,   'E',   visual )/= 0) return
        if( fstr_ctrl_get_param_ex( ctrl, 'FEMAP ',   '# ',    0,   'E',   femap  )/= 0) return

        fstr_ctrl_get_WRITE = 0

end function fstr_ctrl_get_WRITE

!> Read in !ECHO                                                                                   
function fstr_ctrl_get_ECHO( ctrl, echo )
        integer(kind=kint) :: ctrl
        integer(kind=kint) :: echo
        integer(kind=kint) :: fstr_ctrl_get_ECHO

        echo = kON;

        fstr_ctrl_get_ECHO = 0

end function fstr_ctrl_get_ECHO

!> Read in !COUPLE                
function fstr_ctrl_get_COUPLE( ctrl, fg_first, surf_id, surf_id_len )
        integer(kind=kint) :: ctrl                           !< readed data
        integer(kind=kint) :: fg_first                       !< if first
        character(len=HECMW_NAME_LEN),target  :: surf_id(:)  !< surface id
        character(len=HECMW_NAME_LEN),pointer :: surf_id_p   !< surface id
        integer(kind=kint) :: surf_id_len
        integer(kind=kint) :: fstr_ctrl_get_COUPLE

        character(len=HECMW_NAME_LEN) :: data_fmt,ss
        write(ss,*)  surf_id_len 
        write(data_fmt,'(a,a,a)') 'S',trim(adjustl(ss)),' '

        fstr_ctrl_get_COUPLE = -1
        if( fstr_ctrl_get_param_ex( ctrl, 'TYPE ', '1,2,3,4,5,6 ', 0, 'I', fg_first )/= 0) return

        surf_id_p => surf_id(1)
        fstr_ctrl_get_COUPLE = &
                fstr_ctrl_get_data_array_ex( ctrl, data_fmt, surf_id_p )

end function fstr_ctrl_get_COUPLE

!> Read in !MPC                                              
function fstr_ctrl_get_MPC( ctrl, penalty )
        integer(kind=kint), intent(in) :: ctrl      !< readed data
        real(kind=kreal), intent(out)  :: penalty   !< penalty
        integer(kind=kint) :: fstr_ctrl_get_MPC

        fstr_ctrl_get_MPC = fstr_ctrl_get_data_ex( ctrl, 1,   'r ', penalty )
        if( penalty <= 1.0 ) then
          if (myrank == 0) then
            write(IMSG,*) "Warging : !MPC : too small penalty: ", penalty
            write(*,*) "Warging : !MPC : too small penalty: ", penalty
          endif
        endif

end function fstr_ctrl_get_MPC

!> Read in !NODE_OUTPUT
logical function fstr_ctrl_get_outnode( ctrl, hecMESH, outinfo )
  use fstr_setup_util
  use m_out
  integer(kind=kint), intent(in)        :: ctrl      !< readed data
  type (hecmwST_local_mesh), intent(in) :: hecMESH   !< mesh information
  type( output_info ), intent(out)      :: outinfo   !< output information

  integer(kind=kint) :: rcode, citem, ipos
  integer(kind=kint) :: n, i, grpid(1)
  character(len=HECMW_NAME_LEN) :: data_fmt,ss
  character(len=HECMW_NAME_LEN),allocatable :: header_name(:), onoff(:), vtype(:)
  logical  :: available 
  
  write(ss,*)  HECMW_NAME_LEN
  write( data_fmt, '(a,a,a,a,a,a)') 'S', trim(adjustl(ss)),'s', trim(adjustl(ss)),'s', trim(adjustl(ss))

  fstr_ctrl_get_outnode = .false.

  outinfo%grp_id_name ="ALL"
  rcode = fstr_ctrl_get_param_ex( ctrl, 'NGROUP ',   '# ',  0, 'S', outinfo%grp_id_name )
  ipos = 0
  rcode = fstr_ctrl_get_param_ex( ctrl, 'ACTION ',   'SUM ', 0, 'P',   ipos )
  outinfo%actn = ipos
!  if( len(trim(ss1(1)))>0 ) then
!    call node_grp_name_to_id_ex( hecMESH, '!NODE OUTPUT', 1, ss1, grpid )
!    outinfo%GroupID = grpid(1)
!  endif

  n = fstr_ctrl_get_data_line_n( ctrl )
  if( n == 0 ) return
  allocate( header_name(n), onoff(n), vtype(n) )
  vtype(:) = "";  onoff(:)=""
  rcode=fstr_ctrl_get_data_array_ex( ctrl, data_fmt, header_name, onoff, vtype ) 

  do i=1,n
    if( len( trim(header_name(i)) )==0 ) return
    available = .false.
    citem = -1
    if( trim(header_name(i)) == 'DISP' ) then
        available = .true.
        citem = 1
    else if( trim(header_name(i)) == 'REAC' ) then
        available = .true.
        citem = 2
    else if( trim(header_name(i)) == 'TEMPERATURE ' ) then
        available = .true.
        outinfo%num_items = outinfo%num_items+1
        if( outinfo%num_items>MAXOUT ) return
        outinfo%keyWord(outinfo%num_items) = "TEMPERATURE"
        outinfo%vtype(outinfo%num_items) = -1
    else if( trim(header_name(i)) == 'STRAIN' ) then
        available = .true.
        outinfo%num_items = outinfo%num_items+1
        if( outinfo%num_items>MAXOUT ) return
        outinfo%keyWord(outinfo%num_items) = "STRAIN"
        outinfo%vtype(outinfo%num_items) = -3
    else if( trim(header_name(i)) == 'STRESS' ) then
        available = .true.
        outinfo%num_items = outinfo%num_items+1
        if( outinfo%num_items>MAXOUT ) return
        outinfo%keyWord(outinfo%num_items) = "STRESS"
        outinfo%vtype(outinfo%num_items) = -3
    else if( trim(header_name(i)) == 'MISESSTRESS ' ) then
        available = .true.
        outinfo%num_items = outinfo%num_items+1
        if( outinfo%num_items>MAXOUT ) return
        outinfo%keyWord(outinfo%num_items) = "MISES STRESS"
        outinfo%vtype(outinfo%num_items) = -1
    endif
    if( .not. available ) cycle
    if( citem==-1 ) citem = outinfo%num_items
    if( len( trim(vtype(i)) )>0 ) then
        if( fstr_str2index( vtype(i), n ) ) then
          outinfo%vtype(citem)=n
        else if( trim(vtype(i))=="SCALE") then
          outinfo%vtype(citem)=-1
        else if( trim(vtype(i))=="VECTOR") then
          outinfo%vtype(citem)=-2
        else if( trim(vtype(i))=="SYMTENSOR") then
          outinfo%vtype(citem)=-3
        else if( trim(vtype(i))=="TENSOR") then
          outinfo%vtype(citem)=-4
        else
          return      ! incorrect varibale type
        endif
    endif
    outinfo%on(citem)= .true.
    if( trim(onoff(i)) == 'OFF') outinfo%on(citem)= .false.
  enddo

  deallocate( header_name, onoff, vtype )
  fstr_ctrl_get_outnode = .true.

end function 

!> Read in !ELEMENT_OUTPUT
logical function fstr_ctrl_get_outelem( ctrl, hecMESH, outinfo )
  use fstr_setup_util
  use m_out
  integer(kind=kint), intent(in)        :: ctrl      !< readed data
  type (hecmwST_local_mesh), intent(in) :: hecMESH   !< mesh information
  type( output_info ),intent(out)       :: outinfo   !< output information

  integer(kind=kint) :: rcode, citem, ipos
  integer(kind=kint) :: n, i, grpid(1)
  character(len=HECMW_NAME_LEN) :: data_fmt,ss, ss1(1)
  character(len=HECMW_NAME_LEN),allocatable :: header_name(:), onoff(:), vtype(:)
  logical  :: available 
  
  write(ss,*)  HECMW_NAME_LEN
  write( data_fmt, '(a,a,a,a,a,a)') 'S', trim(adjustl(ss)),'s', trim(adjustl(ss)),'s', trim(adjustl(ss))

  fstr_ctrl_get_outelem = .false.

  outinfo%grp_id_name ="ALL"
  rcode = fstr_ctrl_get_param_ex( ctrl, 'EGROUP ',   '# ',  0, 'S', outinfo%grp_id_name )
 ! if( len(trim(ss1(1)))>0 ) then
 !   call elem_grp_name_to_id( hecMESH, '!ELEMENT OUTPUT', 1, ss1, grpid )
 !   outinfo%GroupID = grpid(1)
 ! endif
  ipos = 2
  ss = 'CENTER,AVERAGE,INTEG,NODE '
  if( fstr_ctrl_get_param_ex( ctrl, 'POSITION ',   ss, 0, 'P',   ipos  )/= 0) return
  if( ipos>0 ) ipos=ipos-1

  n = fstr_ctrl_get_data_line_n( ctrl )
  if( n == 0 ) return
  allocate( header_name(n), onoff(n), vtype(n) )
  onoff=""; vtype=""
  if( fstr_ctrl_get_data_array_ex( ctrl, data_fmt, header_name, onoff, vtype ) /= 0 ) return

  do i=1,n
    available = .false.
    citem = -1
    if( trim(header_name(i)) == 'STRAIN' ) then
        available = .true.
        citem = 3
    else if( trim(header_name(i)) == 'STRESS' ) then
        available = .true.
        citem = 4
    else if( trim(header_name(i)) == 'MISESSTRESS ' ) then
        available = .true.
        outinfo%num_items = outinfo%num_items+1
        if( outinfo%num_items>MAXOUT ) return
        outinfo%keyWord(outinfo%num_items) = "MISES STRESS"
        outinfo%vtype(outinfo%num_items) = -1
    else if( trim(header_name(i)) == 'PLSTRAIN' ) then
        available = .true.
        outinfo%num_items = outinfo%num_items+1
        if( outinfo%num_items>MAXOUT ) return
        outinfo%keyWord(outinfo%num_items) = "PLASTIC_STRAIN"
        outinfo%vtype(outinfo%num_items) = -1
    endif
    if( .not. available ) cycle
    if( citem==-1 ) citem = outinfo%num_items
    outinfo%location(citem) = ipos
    if( len( trim(vtype(i)) )>0 ) then
        if( fstr_str2index( vtype(i), n ) ) then
          outinfo%vtype(citem)=n
        else if( trim(vtype(i))=="SCALE") then
          outinfo%vtype(citem)=-1
        else if( trim(vtype(i))=="VECTOR") then
          outinfo%vtype(citem)=-2
        else if( trim(vtype(i))=="SYMTENSOR") then
          outinfo%vtype(citem)=-3
        else if( trim(vtype(i))=="TENSOR") then
          outinfo%vtype(citem)=-4
        else
          return      ! incorrect varibale type
        endif
    endif
    outinfo%on(citem)= .true.
    if( trim(onoff(i)) == 'OFF') outinfo%on(citem)= .false.
  enddo

  deallocate( header_name, onoff, vtype )
  fstr_ctrl_get_outelem = .true.

end function fstr_ctrl_get_outelem

!> Read in !CONTACT                                                           
function fstr_ctrl_get_CONTACTALGO( ctrl, algo )           
        integer(kind=kint) :: ctrl
        integer(kind=kint) :: algo
        integer(kind=kint) :: fstr_ctrl_get_CONTACTALGO    

        integer(kind=kint) :: rcode
        character(len=80) :: s
        algo = kcaSLagrange
        s = 'SLAGRANGE,ALAGRANGE '
        rcode = fstr_ctrl_get_param_ex( ctrl, 'TYPE ', s, 0, 'P', algo )   
        fstr_ctrl_get_CONTACTALGO = rcode                                  
end function fstr_ctrl_get_CONTACTALGO

  !>  Read in contact definition
  logical function fstr_ctrl_get_CONTACT( ctrl, n, contact, np, tp, ntol, ttol, ctAlgo )    
      integer(kind=kint), intent(in)    :: ctrl          !< ctrl file
      integer(kind=kint), intent(in)    :: n             !< number of item defined in this section
      integer(kind=kint), intent(in)    :: ctAlgo        !< contact algorithm                    
      type(tContact), intent(out)       :: contact(n)    !< contact definition
      real(kind=kreal), intent(out)      :: np             !< penalty along contact nomral
      real(kind=kreal), intent(out)      :: tp             !< penalty along contact tangent
      real(kind=kreal), intent(out)      :: ntol           !< tolrence along contact nomral
      real(kind=kreal), intent(out)      :: ttol           !< tolrence along contact tangent

      integer           :: rcode, ipt
      character(len=30) :: s1 = 'TIED,GLUED,SSLID,FSLID'
      character(len=HECMW_NAME_LEN) :: data_fmt,ss
      character(len=HECMW_NAME_LEN) :: cp_name(n)      
      real(kind=kreal)  :: fcoeff(n),tPenalty(n) 
      
      tPenalty = 1.0d6                                            

      write(ss,*)  HECMW_NAME_LEN
      write( data_fmt, '(a,a,a)') 'S', trim(adjustl(ss)),'Rr'                      

      fstr_ctrl_get_CONTACT = .false.                               
      contact(1)%ctype = 1   ! pure slave-master contact; default value
      contact(1)%algtype = CONTACTSSLID ! small sliding contact; default value
      rcode = fstr_ctrl_get_param_ex( ctrl, 'INTERACTION ', s1, 0, 'P', contact(1)%algtype )         
      if( contact(1)%algtype==CONTACTGLUED ) contact(1)%algtype=CONTACTFSLID  ! not complemented yet
      if( fstr_ctrl_get_param_ex( ctrl, 'GRPID ', '#', 1, 'I', contact(1)%group )/=0) return
      do rcode=2,n
        contact(rcode)%ctype = contact(1)%ctype
        contact(rcode)%group = contact(1)%group
        contact(rcode)%algtype = contact(1)%algtype
      end do
      if(  fstr_ctrl_get_data_array_ex( ctrl, data_fmt, cp_name, fcoeff, tPenalty ) /= 0 ) return
      do rcode=1,n
        contact(rcode)%pair_name = cp_name(rcode)
        contact(rcode)%fcoeff = fcoeff(rcode)
        contact(rcode)%tPenalty = tPenalty(rcode)        
      enddo
      
      np = 0.d0;  tp=0.d0
      ntol = 0.d0;  ttol=0.d0
      if( fstr_ctrl_get_param_ex( ctrl, 'NPENALTY ',  '# ',  0, 'R', np ) /= 0 ) return
      if( fstr_ctrl_get_param_ex( ctrl, 'TPENALTY ', '#', 0, 'R', tp ) /= 0 ) return
      if( fstr_ctrl_get_param_ex( ctrl, 'NTOL ',  '# ',  0, 'R', ntol ) /= 0 ) return
      if( fstr_ctrl_get_param_ex( ctrl, 'TTOL ', '#', 0, 'R', ttol ) /= 0 ) return
      fstr_ctrl_get_CONTACT = .true.                                          
  end function fstr_ctrl_get_CONTACT                                                


end module fstr_ctrl_common
