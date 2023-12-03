module VMC_print
    use VMC_parameters
    implicit none

    integer , private :: FID = 11

    contains

    

    !####################################################
    !#           Print Configuration to File            #
    !####################################################
    subroutine print_configuration_toFile(R,filename)
        use VMC_parameters
        implicit none
        real*8,dimension(Natoms,DIM),intent(in) :: R 
        character(*) :: filename
        integer :: i_atom

        open(FID,file=filename,status="replace")
        write(FID,"(A)") "atom,x,y"
        do i_atom=1, Natoms
            write(FID,*) i_atom,",",R(i_atom,1),",",R(i_atom,2)
        end do
        close(FID)
    end subroutine


    subroutine print_inital_conf_toFile(R)
        use VMC_parameters
        implicit none 
        real*8,intent(in),dimension(Natoms,DIM) :: R
        character(MAX_FILENAME_LENGHT) :: filename 
        filename = trim(outfile_path)//trim(init_conf_filename)
        call print_configuration_toFile(R,filename)
    end subroutine print_inital_conf_toFIle

    subroutine print_final_conf_toFile(R)
        use VMC_parameters
        implicit none
        real*8,intent(in),dimension(Natoms,DIM) :: R
        character(MAX_FILENAME_LENGHT) :: filename
        filename = trim(outfile_path)//trim(fin_conf_filename)
        call print_configuration_toFile(R,filename)
    end subroutine
    !####################################################

    !####################################################
    !#         Print Energies Evolution to file         #
    !####################################################       
    subroutine print_E_evolution_toFile(MC_step,E,Epot,Ekin,Ekinfor)
        use VMC_parameters
        implicit none
        integer,intent(in) :: MC_step
        real*8, intent(in) :: E,Epot,Ekin,Ekinfor
        logical,save ::FirstTime = .TRUE. 
        character(MAX_FILENAME_LENGHT),save :: filename
        
        if (FirstTime) then 
            filename = trim(outfile_path)//trim(energy_evolution_filename)
            open(FID,file=filename,status="replace")
            write(FID,*) "step,E,E^2,epot,ekin,ekinfor"
            FirstTime = .FALSE. 
            close(FID)
        end if

        open(FID,file=filename,access="append") 
        write(FID,*) MC_step,E,E**2,Epot,Ekin,Ekinfor
        close(FID)
    end subroutine

end module 