!-------------------------------------------------------------------------------
! Copyright (c) 2016 The University of Tokyo
! This software is released under the MIT License, see LICENSE.txt
!-------------------------------------------------------------------------------
module m_fstr_EIG_output

  contains

  subroutine fstr_eigen_output(hecMESH, hecMAT, fstrEIG)
    use m_fstr
    use m_fstr_EIG_lanczos_util
    use hecmw_solver_las
    implicit none
    type(hecmwST_local_mesh) :: hecMESH
    type(hecmwST_matrix    ) :: hecMAT
    type(fstr_eigen        ) :: fstrEIG

    integer(kind=kint) :: N, NP, NDOF, NNDOF, NPNDOF
    integer(kind=kint), allocatable  :: new(:)

    integer(kind=kint) :: I,IREOR,JJITER,JITER,IITER
    real(kind=kreal) :: prechk0(1)
    integer(kind=kint) :: j, k , ii, iii, ik, in, in1, in2, in3, nstep, istep, maxItr
    integer(kind=kint) :: ig, ig0, is0, ie0, its0, ite0
    integer(kind=kint) :: kk, ppc, nget
    integer(kind=kint) IOUT,eITMAX,itype,iS,iE,ic_type,icel,jS,nn
    real(kind=kreal)   :: t1, t2, aalf, tmp, tmp2, gm, gm2, r1, r2, r3, r4, r5, r6
    real(kind=kreal), pointer :: mass(:), eigval(:)

      REAL (KIND=KREAL), pointer :: EWK(:,:)
    real(kind=kreal), allocatable :: s(:), t(:), u(:)

      REAL(KIND=KREAL) :: PRECHK1,PRECHK2,CCHK0,CCHK1,CCHK,CERR

    N      = hecMAT%N
    NP     = hecMAT%NP
    NDOF   = hecMESH%n_dof
    NNDOF  = N *NDOF
    NPNDOF = NP*NDOF

    nget =  fstrEIG%nget
    mass => fstrEIG%mass
    eigval => fstrEIG%eigval

    EWK => fstrEIG%eigvec

!C***** compute effective mass and participation factor
    allocate(fstrEIG%effmass(3*NGET))
    allocate(fstrEIG%partfactor(3*NGET))
    allocate(new(fstrEIG%iter))
    allocate(s(NPNDOF))
    allocate(t(NPNDOF))
    allocate(u(NPNDOF))
    fstrEIG%effmass    = 0.0d0
    fstrEIG%partfactor = 0.0d0

    if(NDOF == 3)then
      DO i=1,NGET
        r1 = 0.0d0
        r2 = 0.0d0
        r3 = 0.0d0
        gm = 0.0d0
        do j = 1, N
          in1 = 3*j-2
          in2 = 3*j-1
          in3 = 3*j
          r1 = r1 + mass(in1)*ewk(in1,i)
          r2 = r2 + mass(in2)*ewk(in2,i)
          r3 = r3 + mass(in3)*ewk(in3,i)
          gm = gm + mass(in1)*ewk(in1,i)*ewk(in1,i) &
          & + mass(in2)*ewk(in2,i)*ewk(in2,i) &
          & + mass(in3)*ewk(in3,i)*ewk(in3,i)
        enddo
        call hecmw_allreduce_R1(hecMESH,r1,hecmw_sum)
        call hecmw_allreduce_R1(hecMESH,r2,hecmw_sum)
        call hecmw_allreduce_R1(hecMESH,r3,hecmw_sum)
        call hecmw_allreduce_R1(hecMESH,gm,hecmw_sum)
        fstrEIG%partfactor(3*i-2) = r1/gm
        fstrEIG%partfactor(3*i-1) = r2/gm
        fstrEIG%partfactor(3*i  ) = r3/gm
        fstrEIG%effmass(3*i-2) = r1*r1/gm
        fstrEIG%effmass(3*i-1) = r2*r2/gm
        fstrEIG%effmass(3*i  ) = r3*r3/gm
      enddo

    elseif(NDOF == 2)then
      DO i=1,NGET
        r1 = 0.0d0
        r2 = 0.0d0
        gm = 0.0d0
        do j = 1, N
          in1 = 2*j-1
          in2 = 2*j
          r1 = r1 + mass(in1)*ewk(in1,i)
          r2 = r2 + mass(in2)*ewk(in2,i)
          gm = gm + r1*ewk(in1,i) + r2*ewk(in2,i)
        enddo
        call hecmw_allreduce_R1(hecMESH,r1,hecmw_sum)
        call hecmw_allreduce_R1(hecMESH,r2,hecmw_sum)
        call hecmw_allreduce_R1(hecMESH,gm,hecmw_sum)
        fstrEIG%partfactor(3*i-2) = r1/gm
        fstrEIG%partfactor(3*i-1) = r2/gm
        fstrEIG%effmass(3*i-2) = r1*r1/gm
        fstrEIG%effmass(3*i-1) = r2*r2/gm
      enddo
    endif

      CALL EGLIST(hecMESH,hecMAT,fstrEIG,new)

      IF(myrank.EQ.0) THEN
        WRITE(IMSG,*) ''
        WRITE(IMSG,*) '*----------------------------------------------*'
        WRITE(IMSG,*) '*--E I G E N V A L U E  C O N V E R G E N C E--*'
        WRITE(IMSG,*) '*----------------------------------------------*'
        WRITE(IMSG,*) 'Absolute residual =  |(||Kx - lambda*Mx||)|'
      ENDIF
!C
!Normalize eigenvectors
      IF(myrank==0) THEN
        WRITE(IMSG,*) '*------------- Residual Check ----------------*'
        WRITE(IMSG,*) '   Iter.#   Eigenvalue    Abs. Residual  '
        WRITE(IMSG,*) '   *-----*  *---------*  *--------------*'
      ENDIF
!C
      DO JJITER = 1,fstrEIG%nget
        JITER = NEW(JJITER)

          prechk1=0.0
          do i = 1, NNDOF
            prechk1=prechk1+ewk(i,JJITER)**2
          enddo
            CALL hecmw_allreduce_R1( hecMESH,prechk1,hecmw_sum )
          prechk1 = sqrt(prechk1)
          if( prechk1.NE.0.0D0 ) ewk(:,JJITER) = ewk(:,JJITER)/prechk1
!C
          DO IITER = 1, NNDOF
            u(IITER) = ewk(IITER,JJITER)
          ENDDO
!C
          call hecmw_matvec(hecMESH, hecMAT, u, t)
!C
          s = 0.0D0
          do i = 1, NNDOF
            s(i) = mass(i)*ewk(i,JJITER)
          enddo
!C
          CCHK1 = 0.0D0
          DO IITER = 1,NNDOF
            CCHK1 = CCHK1 + (t(IITER) - (eigval(JITER)-fstrEIG%sigma)*s(IITER))**2
          END DO
!C
            CALL hecmw_allreduce_R1(hecMESH,CCHK1,hecmw_sum)

          CCHK1 = SQRT(CCHK1)
          IF(myrank.EQ.0) THEN
             WRITE(IMSG,'(2X,I5,2X,5E15.6)') JITER,eigval(JITER),CCHK1
          ENDIF
      ENDDO
!C
      IF(myrank==0) THEN
        WRITE(IMSG,*) ''
        WRITE(IMSG,*)'*    ---END Eigenvalue listing---     *'
        WRITE(IMSG,*) ''
      ENDIF

      end subroutine fstr_eigen_output

      subroutine fstr_eigen_make_result(hecMESH, hecMAT, fstrEIG, fstrRESULT)
        use m_fstr
        use m_hecmw2fstr_mesh_conv
        use hecmw_util
        implicit none
        type (hecmwST_local_mesh ) :: hecMESH
        type (hecmwST_matrix     ) :: hecMAT
        type (fstr_eigen         ) :: fstrEIG
        type (hecmwST_result_data) :: fstrRESULT

        integer(kind=kint) :: i, istep, nget, NP, NDOF, NPNDOF, totalmpc, MPC_METHOD
        real(kind=kreal)   :: t1
        real(kind=kreal), pointer :: ewk(:,:)
        real(kind=kreal), allocatable :: X(:)
        character(len=HECMW_HEADER_LEN) :: header
        character(len=HECMW_NAME_LEN)   :: label
        character(len=HECMW_NAME_LEN)   :: nameID

        nget   = fstrEIG%nget
        NDOF   = hecMAT%NDOF
        NPNDOF = hecMAT%NP*hecMAT%NDOF
        !totalmpc = hecMESH%mpc%n_mpc
        !call hecmw_allreduce_I1 (hecMESH, totalmpc, hecmw_sum)

    EWK => fstrEIG%eigvec

        allocate(X(NPNDOF))
        X = 0.0d0

        do istep = 1, nget
          do i=1,NPNDOF
            X(i) = ewk(i,istep)
          enddo

          !if (totalmpc > 0) then
          !  MPC_METHOD = hecmw_mat_get_mpc_method(hecMAT)
          !  if (MPC_METHOD < 1 .or. 3 < MPC_METHOD) MPC_METHOD = 3
          !  if (MPC_METHOD == 3) then  ! elimination
          !    call hecmw_tback_x_33(hecMESH, X, t1)
          !  else
          !    if (hecMESH%my_rank.eq.0) write(0,*) "### ERROR: MPC_METHOD must set to 3"
          !    stop
          !  endif
          !endif

          call hecmw_update_m_R(hecMESH, X, hecMAT%NP, NDOF)

          if( IRESULT.eq.1 ) then
            header = "*fstrresult"
            call hecmw_result_init(hecMESH,nget,istep,header)
            label = "DISPLACEMENT"
            call hecmw_result_add(1,NDOF,label,X)
            nameID = "fstrRES"
            call hecmw_result_write_by_name(nameID)
            call hecmw_result_finalize
          endif

          if( IVISUAL.eq.1 ) then
            call hecmw_nullify_result_data(fstrRESULT)
            fstrRESULT%nn_component = 1
            fstrRESULT%ne_component = 0
            allocate(fstrRESULT%nn_dof(1))
            allocate(fstrRESULT%node_label(1))
            allocate(fstrRESULT%node_val_item(NDOF*hecMAT%NP))
            fstrRESULT%nn_dof(1) = NDOF
            fstrRESULT%node_label(1) = 'DISPLACEMENT'
            fstrRESULT%node_val_item = X
            call fstr2hecmw_mesh_conv(hecMESH)
            call hecmw_visualize_init
            call hecmw_visualize(hecMESH,fstrRESULT,istep,nget,1)
            call hecmw_visualize_finalize
            call hecmw2fstr_mesh_conv(hecMESH)
            call hecmw_result_free(fstrRESULT)
          endif
        enddo

        deallocate(X)

      end subroutine fstr_eigen_make_result

!> Output eigenvalues and vectors
      SUBROUTINE EGLIST( hecMESH,hecMAT,fstrEIG,new )
      use m_fstr
      use hecmw_util
      use m_fstr_EIG_lanczos_util
      implicit none
      type (hecmwST_local_mesh) :: hecMESH
      type (hecmwST_matrix    ) :: hecMAT
      type (fstr_eigen) :: fstrEIG

      INTEGER(kind=kint) :: i, j, ii
      INTEGER(kind=kint) :: nglobal, istt, ied, GID, gmyrank, groot, kcount
      INTEGER(kind=kint) :: groupcount, GROUP, XDIFF, hecGROUP, LTRIAL, NGET
      INTEGER(kind=kint), allocatable :: new(:)
      INTEGER(kind=kint), POINTER :: istarray(:,:), grouping(:), gmem(:)
      INTEGER(kind=kint), POINTER :: counts(:),disps(:)
      REAL(kind=kreal) :: pi, EEE, WWW, FFF, PFX, PFY, PFZ, EMX, EMY, EMZ

    real(kind=kreal), pointer :: mass(:), eigval(:)
      NGET = fstrEIG%nget
      LTRIAL =  fstrEIG%iter
       PI = 4.0*ATAN(1.0)
    eigval => fstrEIG%eigval

!C*EIGEN VALUE SORTING
      CALL EVSORT(eigval,NEW,LTRIAL)
      IF(myrank==0) THEN
        WRITE(ILOG,*)""
        WRITE(ILOG,"(a)")"********************************"
        WRITE(ILOG,"(a)")"*RESULT OF EIGEN VALUE ANALYSIS*"
        WRITE(ILOG,"(a)")"********************************"
        WRITE(ILOG,"(a)")""
        WRITE(ILOG,"(a,i8)")"NUMBER OF ITERATIONS = ",LTRIAL
        WRITE(ILOG,"(a,1pe12.4)")"TOTAL MASS = ",fstrEIG%totalmass
        WRITE(ILOG,"(a)")""
        WRITE(ILOG,"(3a)")"                   ANGLE       FREQUENCY   ",&
        "PARTICIPATION FACTOR                EFFECTIVE MASS"
        WRITE(ILOG,"(3a)")"  NO.  EIGENVALUE  FREQUENCY   (HZ)        ",&
        "X           Y           Z           X           Y           Z"
        WRITE(ILOG,"(3a)")"  ---  ----------  ----------  ----------  ",&
        "----------  ----------  ----------  ----------  ----------  ----------"
        WRITE(*,*)""
        WRITE(*,"(a)")"#----------------------------------#"
        WRITE(*,"(a)")"#  RESULT OF EIGEN VALUE ANALYSIS  #"
        WRITE(*,"(a)")"#----------------------------------#"
        WRITE(*,"(a)")""
        WRITE(*,"(a,i8)")"### NUMBER OF ITERATIONS = ",LTRIAL
        WRITE(*,"(a,1pe12.4)")"### TOTAL MASS = ",fstrEIG%totalmass
        WRITE(*,"(a)")""
        WRITE(*,"(3a)")"       PERIOD     FREQUENCY  ",&
        "PARTICIPATION FACTOR             EFFECTIVE MASS"
        WRITE(*,"(3a)")"  NO.  [Sec]      [HZ]       ",&
        "X          Y          Z          X          Y          Z"
        WRITE(*,"(3a)")"  ---  ---------  ---------  ",&
        "---------  ---------  ---------  ---------  ---------  ---------"

        if(LTRIAL < NGET)then
          j = LTRIAL
        else
          j = NGET
        endif

        kcount = 0
        DO 40 i=1,LTRIAL
          II=NEW(I)
            kcount = kcount + 1
            EEE=eigval(II)
            IF(EEE.LT.0.0) EEE=0.0
            WWW=DSQRT(EEE)
            FFF=WWW*0.5/PI
            PFX=fstrEIG%partfactor(3*i-2)
            PFY=fstrEIG%partfactor(3*i-1)
            PFZ=fstrEIG%partfactor(3*i  )
            EMX=fstrEIG%effmass(3*i-2)
            EMY=fstrEIG%effmass(3*i-1)
            EMZ=fstrEIG%effmass(3*i  )
            WRITE(ILOG,'(I5,1P9E12.4)') kcount,EEE,WWW,FFF,PFX,PFY,PFZ,EMX,EMY,EMZ
            WRITE(*   ,'(I5,1P8E11.3)') kcount,1.0d0/FFF,FFF,PFX,PFY,PFZ,EMX,EMY,EMZ
            if( kcount.EQ.j ) go to 41
   40   CONTINUE
   41   continue
        WRITE(ILOG,*)
        WRITE(*,*)""
      ENDIF
      RETURN
      END SUBROUTINE EGLIST
end module m_fstr_EIG_output


