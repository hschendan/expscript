function std_erprefch

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RE-REFERENCE ERP TO AVERAGE MASTOIDS & CAR: ERP CHANNEL OPERATION.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global M12 nraw pathname_all data_path subject CA ch64 all one s n
 
disp('ERP re-reference: Working ...')
% Set filename for text file holding re-referencing channal operations
% Set ERP suffix
% Set reference type for printed report
if M12
    erpREFtext = ['ERPref64M12.txt'];
    erp_ext = '_armM';
    ref_type = 'MASTOIDS';
elseif CA
    erpREFtext = ['ERPref64CAR.txt'];
    erp_ext = '_armCA';
    ref_type = 'COMMON AVERAGE';
end

if one
    sname = [data_path{n} subject{n} '_ar.erp'];
    if exist(sname, 'file')>0
        clear ERP;  % Clear is to make sure that we start fresh for each subject with the EEG and ERP structures
        ERP = pop_loaderp('filename', [subject{n} '_ar.erp'] , 'filepath', data_path{n});
        ERP = pop_erpchanoperator( ERP, erpREFtext, 'ErrorMsg', 'popup' );
        % ERP = pop_erpchanoperator( ERP, [pathname_all 'ERPref64M12.txt'] , 'ErrorMsg', 'popup' );
        erpname = [subject{n} erp_ext];  % name for erpset menu
        fname_erp = fullfile(data_path{n}, [erpname '.erp']);
        pop_savemyerp(ERP, 'erpname', erpname, 'filename', fname_erp, 'Warning', 'off');
    else
        fprintf('\n *** WARNING: %s does not exist *** \n\n', sname);
    end
    
    fprintf('\n+++++++++++++++\n+ ERP Average %s Re-Reference: done! ... \n+++++++++++++++\n\n',ref_type);
 
end

if all     
    for s=1:nraw
        sname = [data_path{s} subject{s} '_ar.erp'];
        if exist(sname, 'file')>0
            clear ERP;  % Clear is to make sure that we start fresh for each subject with the EEG and ERP structures
            ERP = pop_loaderp('filename', [subject{s} '_ar.erp'] , 'filepath', data_path{s});
            ERP = pop_erpchanoperator( ERP, erpREFtext , 'ErrorMsg', 'popup' );
            % ERP = pop_erpchanoperator( ERP, [pathname_all 'ERPref64M12.txt'] , 'ErrorMsg', 'popup' );
            erpname = [subject{s} erp_ext];  % name for erpset menu
            fname_erp = fullfile(data_path{s}, [erpname '.erp']);
            pop_savemyerp(ERP, 'erpname', erpname, 'filename', fname_erp, 'Warning', 'off');
        else
            fprintf('\n *** WARNING: %s does not exist *** \n\n', sname);
        end
    end
    fprintf('\n+++++++++++++++\n+ ERP Average %s Re-Reference: done! ... \n+++++++++++++++\n\n',ref_type);
end

end
