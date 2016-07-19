function std_xrtlock1

% BELOW NOT IMPLEMENTED
% TO DO: RTlock, CAR ref versions, 64 vs. 32 chan, delete eye chans, long vs. wide meas
% option. filter cut off enter parameters.


% AVERAGING 
% RT locked 1

global nraw data_path subject artparm

for s=1:nraw
    clear EEG;  % Clear is to make sure that we start fresh for each subject with the EEG and ERP structures
    clear ERP;  % Clear is to make sure that we start fresh for each subject with the EEG and ERP structures
    sname = [data_path{s} subject{s} '_e_bRTlock_be1EOG_M12.set'];       
    if exist(sname, 'file')>0               
        EEG = pop_loadset('filename', [subject{s} '_e_bRTlock_be1EOG_M12.set'], 'filepath', data_path{s});                
%TO DO: Detect artifacts for current dataset. Adjust parameter values after EEG in function
% Artifact detection notes: 
% BLINK & HEOG: Step-like. Test window = [-1100 500] ms; Threshold = TODO uV; Window width = 400 ms (use default or TODO); Window step = 10 ms; Channels = 65 (Blink); Flags to be activated = 1 & 3

EEG = pop_artextval( EEG, 'Channel', 1:64, 'Flag', [ 1 2], 'Review', 'off', 'Threshold', [ artparm(s,1) artparm(s,2)], 'Twindow', [-1100 500]); %Voltage threshold
EEG = pop_artstep( EEG , 'Channel',  71, 'Flag', [ 1 3], 'Review', 'off', 'Threshold',  artparm(s,3), 'Twindow', [ -1100 500], 'Windowsize',  artparm(s,4), 'Windowstep',  artparm(s,5) ); % step-like artifacts VEOG
EEG = pop_artstep( EEG , 'Channel',  70, 'Flag', [ 1 4], 'Review', 'off', 'Threshold',  artparm(s,6), 'Twindow', [ -1100 500], 'Windowsize',  artparm(s,7), 'Windowstep',  artparm(s,8) ); % step-like artifacts HEOG
EEG = pop_artstep( EEG , 'Channel',  1:64, 'Flag', [ 1 5], 'Review', 'off', 'Threshold',  artparm(s,9), 'Twindow', [ -1100 500], 'Windowsize',  artparm(s,10), 'Windowstep',  artparm(s,11) ); % step-like artifacts other chans
EEG = pop_artmwppth( EEG , 'Channel',  1:64, 'Flag', [ 1 6], 'Review', 'off', 'Threshold',  artparm(s,12), 'Twindow', [ -1100 500], 'Windowsize',  artparm(s,13), 'Windowstep',  artparm(s,14) ); % P2P ALL
EEG = pop_artmwppth( EEG , 'Channel',  71, 'Flag', [ 1 7], 'Review', 'off', 'Threshold',  artparm(s,15), 'Twindow', [ -1100 500], 'Windowsize',  artparm(s,16), 'Windowstep',  artparm(s,17) ); % P2P VOG           
EEG = pop_artdiff( EEG , 'Channel',  1:64, 'Flag', [ 1 8], 'Review', 'off', 'Threshold',  artparm(s,18), 'Twindow', [ -1100 500] ); %Extreme spikiness                               

            EEG.setname= [subject{s} '_e_bRTlock_be1EOG_M12_ar.set'];
            EEG = pop_saveset(EEG, 'filename', [subject{s} '_e_bRTlock_be1EOG_M12_ar.set'], 'filepath', data_path{s});
            EEG = pop_exporteegeventlist(EEG, [subject{s} '_EEG_ar.txt']);
            pop_summary_AR_eeg_detection(EEG, [data_path{s}, subject{s} 'RTlock1_EEG_tab_ar.txt']);  % Save ar Table
            ERP = pop_averager( EEG, 'Criterion', 'good', 'Stdev', 'on');
            erpname = [subject{s} 'RTlock1_M12_ar'];  % name for erpset menu
            fname_erp= fullfile(data_path{s}, [erpname '.erp']);
            pop_savemyerp(ERP, 'erpname', erpname, 'filename', fname_erp, 'warning', 'off');  

    else
            fprintf('\n *** WARNING: %s does not exist *** \n\n', sname);
    end
    
    disp('Artifact rejection & artifact-free average RTlock1: DONE! ...')
    
end

