function std_bo

%%%%%%%%%%%%%%%%%%
% Bin Operations %
%%%%%%%%%%%%%%%%%%

global nraw data_path subject

disp('Perform Bin Operations ...')

binop = cellstr(repmat('ny-test-binop.txt', nraw, 1)); % create an array of 52 strings {'ny-test-binop.txt' 'ny-test-binop.txt' ...}

boRTlock = cellstr(repmat('ny-test-RTlock-binop.txt', nraw, 1)); % create an array of 52 strings {'ny-test-RTlock-binop.txt' 'ny-test-RTlock-binop.txt' ...}

lrp = cellstr(repmat('ny-test-binopLRP.txt', nraw, 1)); % create an array of 52 strings {'ny-test-binopLRP.txt' 'ny-test-binopLRP.txt' ...}

lrpRTlock = cellstr(repmat('ny-test-RTlock-binopLRP.txt', nraw, 1)); % create an array of 52 strings {'ny-test-RTlock-binopLRP.txt' 'ny-test-RTlock-binopLRP.txt' ...}

for s=1:nraw
    clear EEG;  % Clear is to make sure that we start fresh for each subject with the EEG and ERP structures
    clear ERP;  % Clear is to make sure that we start fresh for each subject with the EEG and ERP structures
    
    sname = [data_path{s} subject{s} 'M12_ar.erp'];        
    if exist(sname, 'file')>0  
            % Stimulus-locked
            %
            % Load erpset
            %
        ERP = pop_loaderp('filename', [subject{s} 'M12_ar.erp'], 'filepath', data_path{s}, 'Multiload', 'off', 'overwrite', 'off', 'Warning', 'on' );

            % bin operations
        ERP = pop_binoperator( ERP, [pathname_cmd binop{s}]); 

            % Save dataset as
        erpname = [subject{s} 'M12_ar_bo'];  % name for erpset menu
        fname_erp= fullfile(data_path{s}, [erpname '.erp']);  
        pop_savemyerp(ERP, 'erpname', erpname, 'filename', fname_erp, 'warning', 'off'); 

            % LRP
            %clear ERP;  % Clear is to make sure that we start fresh for each subject with the EEG and ERP structures
            %ERP = pop_loaderp('filename', [subject{s} 'M12_ar_bo.erp'], 'filepath', data_path{s}, 'Multiload', 'off', 'overwrite', 'off', 'Warning', 'on' );
         ERP = pop_binoperator( ERP, [pathname_cmd lrp{s}]); 
            % Save dataset as
         erpname = [subject{s} 'M12_ar_boLRP'];  % name for erpset menu
         fname_erp= fullfile(data_path{s}, [erpname '.erp']);  
         pop_savemyerp(ERP, 'erpname', erpname, 'filename', fname_erp, 'warning', 'off'); 

% Response-locked 1
         clear ERP;  % Clear is to make sure that we start fresh for each subject with the EEG and ERP structures
            %
            % Load erpset
            %
         ERP = pop_loaderp('filename', [subject{s} 'RTlock1_M12_ar.erp'], 'filepath', data_path{s}, 'Multiload', 'off', 'overwrite', 'off', 'Warning', 'on' );

            % bin operations
         ERP = pop_binoperator( ERP, [pathname_cmd boRTlock{s}]); 

            % Save dataset as
         erpname = [subject{s} 'RTlock1_M12_ar_bo'];  % name for erpset menu
         fname_erp= fullfile(data_path{s}, [erpname '.erp']);  
         pop_savemyerp(ERP, 'erpname', erpname, 'filename', fname_erp, 'warning', 'off'); 

            % LRP
            %clear ERP;  % Clear is to make sure that we start fresh for each subject with the EEG and ERP structures
            %ERP = pop_loaderp('filename', [subject{s} 'M12_ar_bo.erp'], 'filepath', data_path{s}, 'Multiload', 'off', 'overwrite', 'off', 'Warning', 'on' );    
         ERP = pop_binoperator( ERP, [pathname_cmd lrpRTlock{s}]); 
            % Save dataset as
         erpname = [subject{s} 'RTlock1_M12_ar_boLRP'];  % name for erpset menu
         fname_erp= fullfile(data_path{s}, [erpname '.erp']);  
         pop_savemyerp(ERP, 'erpname', erpname, 'filename', fname_erp, 'warning', 'off'); 

% Response-locked 2
         clear ERP;  % Clear is to make sure that we start fresh for each subject with the EEG and ERP structures
            %
            % Load erpset
            %
         ERP = pop_loaderp('filename', [subject{s} 'RTlock2_M12_ar.erp'], 'filepath', data_path{s}, 'Multiload', 'off', 'overwrite', 'off', 'Warning', 'on' );

            % bin operations
          ERP = pop_binoperator( ERP, [pathname_cmd boRTlock{s}]); 

            % Save dataset as
          erpname = [subject{s} 'RTlock2_M12_ar_bo'];  % name for erpset menu
          fname_erp= fullfile(data_path{s}, [erpname '.erp']);  
          pop_savemyerp(ERP, 'erpname', erpname, 'filename', fname_erp, 'warning', 'off'); 

            % LRP
            %clear ERP;  % Clear is to make sure that we start fresh for each subject with the EEG and ERP structures
            %ERP = pop_loaderp('filename', [subject{s} 'M12_ar_bo.erp'], 'filepath', data_path{s}, 'Multiload', 'off', 'overwrite', 'off', 'Warning', 'on' );
           ERP = pop_binoperator( ERP, [pathname_cmd lrpRTlock{s}]); 
            % Save dataset as
           erpname = [subject{s} 'RTlock2_M12_ar_boLRP'];  % name for erpset menu
           fname_erp= fullfile(data_path{s}, [erpname '.erp']);  
           pop_savemyerp(ERP, 'erpname', erpname, 'filename', fname_erp, 'warning', 'off');                    


%    ERP = pop_binoperator( ERP, pathname_cmd 'inny-test-binop_RHLH.txt');                                                                          
%ERP = pop_savemyerp(ERP, 'erpname', '011finny-testM12_ERP_ar1', 'filename', '011finny-testM12_ERP_ar1M12 (copy).erp', 'filepath', '/home/schendan/ERPDATA/UNTASK/ERPLab');

    else
            fprintf('\n *** WARNING: %s does not exist *** \n\n', sname);
    end
end

disp('Created Bin Operated ERP & LRP sets: DONE! ...')