function std_erprefch

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RE-REFERENCE ERP TO AVERAGE MASTOIDS & CAR: ERP CHANNEL OPERATION.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global M12 nraw pathname_all data_path subject CA ch64 all one s n

disp('ERP re-reference: Working ...')

if one
    
    if M12
        sname = [data_path{n} subject{n} '_ar.erp'];
        if exist(sname, 'file')>0               
            clear ERP;  % Clear is to make sure that we start fresh for each subject with the EEG and ERP structures    
            ERP = pop_loaderp('filename', [subject{n} '_ar.erp'] , 'filepath', data_path{n});
            ERP = pop_erpchanoperator( ERP, [pathname_all 'ERPref64M12.txt'] , 'ErrorMsg', 'popup' );
            erpname = [subject{n} '_armM'];  % name for erpset menu
            fname_erp = fullfile(data_path{n}, [erpname '.erp']);
            pop_savemyerp(ERP, 'erpname', erpname, 'filename', fname_erp, 'Warning', 'off');
        else
            fprintf('\n *** WARNING: %s does not exist *** \n\n', sname);
        end
         
        fprintf('\n+++++++++++++++\n+ ERP Average Mastoids Re-Reference: done! ... \n+++++++++++++++\n\n');   
    end    

    if CA
        sname = [data_path{n} subject{n} '_ar.erp'];
        if exist(sname, 'file')>0               
            clear ERP;  % Clear is to make sure that we start fresh for each subject with the EEG and ERP structures    
            ERP = pop_loaderp('filename', [subject{n} '_ar.erp'] , 'filepath', data_path{n});
                if ch64 % 64 channel cap            
                    ERP = pop_erpchanoperator( ERP, { 'ch70 = ch65 - ch66 label HE' 'ch71 = ch34 - ch67 label VE' 'ch72 = ch34 label Fp2c' 'ch73 = ch67 label LEc' });
                 % ERP = pop_erpchanoperator( ERP, [pathname_all 'ERPref64CAR.txt'] , 'ErrorMsg', 'popup' );% or create a txt file 'ERPref64CAR.txt' for 64 channels
                else    % 32 channel cap
                    ERP = pop_erpchanoperator( ERP, { 'ch38 = ch33 - ch34 label HE' 'ch39 = ch30 - ch35 label VE' 'ch40 = ch30 label Fp2c' 'ch41 = ch35 label LEc'});
                 %  ERP = pop_erpchanoperator( ERP, [pathname_all  'ERPref32CAR.txt'] , 'ErrorMsg', 'popup' );% or create a txt file 'ERPref32CAR.txt' for 32 channels 
                end

                erpname = [subject{n} '_arCA'];  % name for erpset menu
                fname_erp= fullfile(data_path{n}, [erpname '.erp']);
                pop_savemyerp(ERP, 'erpname', erpname, 'filename', fname_erp, 'Warning', 'off');

            else
            fprintf('\n *** WARNING: %s does not exist *** \n\n', sname);
        end

        fprintf('\n+++++++++++++++\n+ ERP Common Average Re-Reference: done! ... \n+++++++++++++++\n\n');   
    end     
end

%optional
if all     
    if M12

        for s=1:nraw
            sname = [data_path{s} subject{s} '_ar.erp'];
            if exist(sname, 'file')>0               
                clear ERP;  % Clear is to make sure that we start fresh for each subject with the EEG and ERP structures    
                ERP = pop_loaderp('filename', [subject{s} '_ar.erp'] , 'filepath', data_path{s});
                ERP = pop_erpchanoperator( ERP, [pathname_all 'ERPref64M12.txt'] , 'ErrorMsg', 'popup' );
                erpname = [subject{s} '_armM'];  % name for erpset menu
                fname_erp = fullfile(data_path{s}, [erpname '.erp']);
                pop_savemyerp(ERP, 'erpname', erpname, 'filename', fname_erp, 'Warning', 'off');
            else
                fprintf('\n *** WARNING: %s does not exist *** \n\n', sname);
            end
        end 
        fprintf('\n+++++++++++++++\n+ ERP Average Mastoids Re-Reference: done! ... \n+++++++++++++++\n\n');   
    end    

    if CA
        for s=1:nraw
            sname = [data_path{s} subject{s} '_ar.erp'];
            if exist(sname, 'file')>0               
                clear ERP;  % Clear is to make sure that we start fresh for each subject with the EEG and ERP structures    
                ERP = pop_loaderp('filename', [subject{s} '_ar.erp'] , 'filepath', data_path{s});
                    if ch64 % 64 channel cap            
                        ERP = pop_erpchanoperator( ERP, { 'ch70 = ch65 - ch66 label HE' 'ch71 = ch34 - ch67 label VE' 'ch72 = ch34 label Fp2c' 'ch73 = ch67 label LEc' });
                     % ERP = pop_erpchanoperator( ERP, [pathname_all 'ERPref64CAR.txt'] , 'ErrorMsg', 'popup' );% or create a txt file 'ERPref64CAR.txt' for 64 channels
                    else    % 32 channel cap
                        ERP = pop_erpchanoperator( ERP, { 'ch38 = ch33 - ch34 label HE' 'ch39 = ch30 - ch35 label VE' 'ch40 = ch30 label Fp2c' 'ch41 = ch35 label LEc'});
                     %  ERP = pop_erpchanoperator( ERP, [pathname_all  'ERPref32CAR.txt'] , 'ErrorMsg', 'popup' );% or create a txt file 'ERPref32CAR.txt' for 32 channels 
                    end

                    erpname = [subject{s} '_arCA'];  % name for erpset menu
                    fname_erp= fullfile(data_path{s}, [erpname '.erp']);
                    pop_savemyerp(ERP, 'erpname', erpname, 'filename', fname_erp, 'Warning', 'off');

                else
                fprintf('\n *** WARNING: %s does not exist *** \n\n', sname);
            end
        end
            fprintf('\n+++++++++++++++\n+ ERP Common Average Re-Reference: done! ... \n+++++++++++++++\n\n');   
    end 
end

    
    
        
