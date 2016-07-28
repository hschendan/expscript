%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Average ERP Pg. 28
% Note: Added eye channels only show in classic ERP plot, untick all
% channels, plot, then plot again tick all chans
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function  std_avg

global nraw data_path subject sfx set
   
disp('ERP Averaging: Working ...')

fprintf('\n+++++++++++++++\n+ (avg) Previous sfx = %s ... \n+++++++++++++++\n\n', sfx);


for s=1:nraw
    sname = [data_path{s} subject{s} sfx set];       
    if exist(sname, 'file')>0               
        clear EEG;  % Clear is to make sure that we start fresh for each subject with the EEG and ERP structures
        clear ERP;  % Clear is to make sure that we start fresh for each subject with the EEG and ERP structures
        EEG = pop_loadset('filename', [subject{s} sfx set], 'filepath', data_path{s});     
        % Good trials, no artifacts
        % matlab2015b, eeglab13, erplab 5 spectra doesn't work
        %ERP = pop_averager( EEG , 'Compute', 'TFFT', 'Criterion', 'good', 'ExcludeBoundary', 'on', 'SEM', 'on', 'TaperWindow', {'Hanning' [-200 900]});
        ERP = pop_averager( EEG , 'Criterion', 'good', 'ExcludeBoundary', 'on', 'SEM', 'on' );
        erpname = [subject{s} 'M12_ar'];  % name for erpset menu
        fname_erp= fullfile(data_path{s}, [erpname '.erp']);
        pop_savemyerp(ERP, 'erpname', erpname, 'filename', fname_erp, 'Warning', 'off'); 
        % RTs for ERPs (redundant with ar above?)
        % values = pop_rt2text(ERP, 'arfilter', 'on', 'eventlist',  1, 'filename', '/home/schendan/ERPDATA/Color/EEG-ANAL/S01/JUNKdetail.txt', 'header', 'on', 'listformat', 'itemized' );
        values = pop_rt2text(ERP, 'arfilter', 'on', 'eventlist',  1, 'filename', [data_path{s} erpname '_erp_RT.txt'], 'header',' on', 'listformat', 'basic' );
        values = pop_rt2text(ERP, 'arfilter', 'on', 'eventlist',  1, 'filename', [data_path{s} erpname '_erp_RTs.txt'], 'header', 'on', 'listformat', 'itemized' );
        % All Trials
        ERP = pop_averager( EEG , 'Criterion', 'all', 'ExcludeBoundary', 'on', 'SEM', 'on' );
        erpname = [subject{s} 'M12_all'];  % name for erpset menu
        fname_erp= fullfile(data_path{s}, [erpname '.erp']);
        pop_savemyerp(ERP, 'erpname', erpname, 'filename', fname_erp, 'Warning', 'off'); 
        % Artifact Trials
        ERP = pop_averager( EEG , 'Criterion', 'bad', 'ExcludeBoundary', 'on', 'SEM', 'on' );
        erpname = [subject{s} 'M12_bad'];  % name for erpset menu
        fname_erp= fullfile(data_path{s}, [erpname '.erp']);
        pop_savemyerp(ERP, 'erpname', erpname, 'filename', fname_erp, 'Warning', 'off'); 
        % Get Evoked spectra, Good trials, no artifacts
        ERP = pop_averager( EEG , 'Compute', 'EFFT', 'Criterion', 'good', 'ExcludeBoundary', 'on', 'SEM', 'on' );
        erpname = [subject{s} 'EFFT_M12_ar'];  % name for erpset menu
        fname_erp= fullfile(data_path{s}, [erpname '.erp']);
        pop_savemyerp(ERP, 'erpname', erpname, 'filename', fname_erp, 'Warning', 'off');  
        % RTs
    else
        fprintf('\n *** WARNING: %s does not exist *** \n\n', sname);
    end
    
   
end
 
 fprintf('\n+++++++++++++++\n+ (avg) New sfx = %s ... \n+++++++++++++++\n\n', sfx);

 fprintf('\n+++++++++++++++\n+ ERP Averaging: done! ... \n+++++++++++++++\n\n');
   
 
