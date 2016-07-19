function std_xrtlock3
  
% average   

global nraw 
global pathname_write impexpsubject20

for s=1:nraw
    clear EEG;  % Clear is to make sure that we start fresh for each subject with the EEG and ERP structures
    clear ERP;  % Clear is to make sure that we start fresh for each subject with the EEG and ERP structures
    
    sname = [pathname_write impexpsubject20{s} 'M12_e-nor_e64M2_bins_be65_ar.set'];        
    if exist(sname, 'file')>0
            % Load dataset
            EEG = pop_loadset('filename', [impexpsubject20{s} 'M12_e-nor_e64M2_bins_be65_ar.set'], 'filepath', pathname_write);
            % Averaging. Single epoched EEG. Only good trials. No
            % weighted average
            ERP = pop_averager( EEG, 1, 1, 1);
            % Save dataset
            erpname = [impexpsubject20{s} 'M12_ERP_ar'];  % name for erpset menu
            fname_erp= fullfile(pathname_write, [erpname 'M12.erp']);
            pop_savemyerp(ERP, 'erpname', erpname, 'filename', fname_erp);                
            % REPEAT Averaging WITH NO ARTIFACT REJECTION. Single epoched EEG. ALL trials. No weighted average
            % TO DO: ERP = pop_averager( EEG, 1, 1, 1);
            % Save dataset
            %erpname = [subject{s} '_ERP_wArtifacts'];  % name for erpset menu
            %fname_erp= fullfile(pathname_write, [erpname '.erp']);
            %pop_savemyerp(ERP, 'erpname', erpname, 'filename', fname_erp);                
    else
            fprintf('\n *** WARNING: %s does not exist *** \n\n', sname);
    end
end
