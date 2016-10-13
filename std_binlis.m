%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Assign bins (Binlister) %
%   ADD RT OUTPUT FLAGS   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%bdfRTlock & RTlock are not used

function std_binlis

global nraw data_path subject pathname_cmd pathname_beh binlisb bdf
global set
disp('binlister working ...')

sfx = '_e'; %initial suffix, please modify it yourself
x = 'b';   % please modify it yourself
  
for s=1:nraw
    sname = [data_path{s} subject{s} sfx set];       
    if exist(sname, 'file')>0                
        clear EEG;  % Clear is to make sure that we start fresh for each subject with the EEG structures
        % Load dataset
        EEG = pop_loadset('filename', [subject{s} sfx set], 'filepath', data_path{s});           
        % Binlister. Detects bin(s)
        % If you want to update the event information in the EEG structure, you can check the Transfer EVENTLIST info… box.  This will allow you to view the EEG data with bin numbers rather than event codes or event labels (which is occasionally useful).
        if binlisb    
            EEG = pop_binlister( EEG, 'BDF', [pathname_cmd bdf{s}], 'ExportEL', [pathname_beh 'BLO/' subject{s} '_blout.txt'], 'IndexEL',  1, 'SendEL2', 'EEG&Text', 'UpdateEEG', 'on', 'Voutput', 'EEG' );                 
        else
            EEG = pop_binlister( EEG, 'BDF', [pathname_cmd bdf{s}], 'ExportEL', [pathname_beh 'BLO/' subject{s} '_blout.txt'], 'IndexEL',  1, 'SendEL2', 'EEG&Text', 'UpdateEEG', 'off', 'Voutput', 'EEG' );                 
        end
        % Name dataset
    
        EEG.setname= [subject{s} sfx x];
        % Save dataset
        EEG = pop_saveset(EEG, 'filename', [EEG.setname set], 'filepath', data_path{s}); 
        
        % RT export, basic RT and detailed RTs format: to get RTs used for ERPs arfilter
        values = pop_rt2text(EEG, 'eventlist',  1, 'filename', [pathname_beh 'RT/' EEG.setname '_RT.txt'], 'header', 'on', 'listformat', 'basic' );
        values = pop_rt2text(EEG, 'eventlist',  1, 'filename', [pathname_beh 'RT/' EEG.setname '_RT.xls'], 'header', 'on', 'listformat', 'basic' );

        values = pop_rt2text(EEG, 'eventlist',  1, 'filename', [pathname_beh 'RT/' EEG.setname '_RTs.txt'], 'header', 'on', 'listformat', 'itemized' );
        values = pop_rt2text(EEG, 'eventlist',  1, 'filename', [pathname_beh 'RT/' EEG.setname '_RTs.xls'], 'header', 'on', 'listformat', 'itemized' );

        fprintf('binlister done for %s! \n', sname);
    else
        fprintf('\n *** WARNING: %s does not exist *** \n\n', sname);
    end
end

fprintf('\n+++++++++++++++\n+ binlister: done! ... \n+++++++++++++++\n\n');

 