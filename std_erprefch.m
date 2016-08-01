function std_erprefch

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RE-REFERENCE ERP TO AVERAGE MASTOIDS & CAR: ERP CHANNEL OPERATION.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global nraw pathname_all data_path subject CAR ch64

disp('ERP re-reference: Working ...')

for s=1:nraw
    sname = [data_path{s} subject{s} 'M12_ar.erp'];
    if exist(sname, 'file')>0               
        clear ERP;  % Clear is to make sure that we start fresh for each subject with the EEG and ERP structures    
        ERP = pop_loaderp('filename', [subject{s} 'M12_ar.erp'] , 'filepath', data_path{s});
        ERP = pop_erpchanoperator( ERP, [pathname_all 'ERPref64M12.txt'] , 'ErrorMsg', 'popup' );
        erpname = [subject{s} 'M12_arM12'];  % name for erpset menu
        fname_erp= fullfile(data_path{s}, [erpname '.erp']);
        pop_savemyerp(ERP, 'erpname', erpname, 'filename', fname_erp, 'Warning', 'off');
    else
        fprintf('\n *** WARNING: %s does not exist *** \n\n', sname);
    end
end
    fprintf('\n+++++++++++++++\n+ ERP Re-Reference: done! ... \n+++++++++++++++\n\n');
    
if CAR
    for s=1:nraw     
        if exist(sname, 'file')>0
            clear ERP;  % Clear is to make sure that we start fresh for each subject with the EEG structures
            ERP = pop_loaderp('filename', [subject{s} 'M12_ar.erp'] , 'filepath', data_path{s});
            if ch64 % 64 channel cap            
                ERP = pop_erpchanoperator( ERP, { 'ch70 = ch65 - ch66 label HE' 'ch71 = ch34 - ch67 label VE' 'ch72 = ch34 label Fp2c' 'ch73 = ch67 label LEc' });
             % ERP = pop_erpchanoperator( ERP, [pathname_all 'ERPref64CAR.txt'] , 'ErrorMsg', 'popup' );% or create a txt file 'ERPref64CAR.txt' for 64 channels
            else    % 32 channel cap
                ERP = pop_erpchanoperator( ERP, { 'ch38 = ch33 - ch34 label HE' 'ch39 = ch30 - ch35 label VE' 'ch40 = ch30 label Fp2c' 'ch41 = ch35 label LEc'});
             %  ERP = pop_erpchanoperator( ERP, [pathname_all  'ERPref32CAR.txt'] , 'ErrorMsg', 'popup' );% or create a txt file 'ERPref32CAR.txt' for 32 channels 

            end
            
            erpname = [subject{s} 'M12_arCAR'];  % name for erpset menu
            fname_erp= fullfile(data_path{s}, [erpname '.erp']);
            pop_savemyerp(ERP, 'erpname', erpname, 'filename', fname_erp, 'Warning', 'off');
        else
        fprintf('\n *** WARNING: %s does not exist *** \n\n', sname);
        end
    end
        fprintf('\n+++++++++++++++\n+ ERP CAR: done! ... \n+++++++++++++++\n\n');
end

    
    
        
