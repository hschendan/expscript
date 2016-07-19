%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Basic Filtering for ERP with Low Pass Pg. 36
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function std_lp

global nraw data_path subject ch64
   
disp('ERP Filter: Working ...')

for s=1:nraw
    sname = [data_path{s} subject{s} 'M12_ar.erp'];
    if exist(sname, 'file')>0               
        clear EEG;  % Clear is to make sure that we start fresh for each subject with the EEG and ERP structures
        clear ERP;  % Clear is to make sure that we start fresh for each subject with the EEG and ERP structures
        ERP = pop_loaderp({'filename', [subject{s} 'M12_ar.erp'] }, 'filepath', data_path{s});
        EEG = pop_loadset('filename', [subject{s} '_cebM12eya.set'], 'filepath', data_path{s}); 
        % Filtering. Channels = 1 to 16; No high-pass;
        % Lowpass cuttof at 30 Hz; Order of the filter = 2.
        % Type of filter = "Butterworth"; Not remove DC offset
        if ch64 % 64 channel
            ERP = pop_filterp( ERP,  1:71 , 'Cutoff',  30, 'Design', 'butter', 'Filter', 'lowpass', 'Order',  2 );
        else    % 32 channel
            ERP = pop_filterp( ERP,  1:39 , 'Cutoff',  30, 'Design', 'butter', 'Filter', 'lowpass', 'Order',  2 );
        end
        erpname = [subject{s} 'M12_arLp30'];  % name for erpset menu
        fname_erp= fullfile(data_path{s}, [erpname '.erp']);
        pop_savemyerp(ERP, 'erpname', erpname, 'filename', fname_erp, 'Warning', 'off'); 
        
    else
            fprintf('\n+++++++++++++++\n+ WARNING: %s does not exist \n+++++++++++++++\n+', sname);
    end
end

fprintf('\n+++++++++++++++\n+ Filter ERP with low pass: done! ... \n+++++++++++++++\n\n');
