% Before running script: 
% raw file list: linux/dos vi: ls > x <enter> :g/firstchars/s//'firstchars/g <enter>
% :g/lastchars\n/s//lastchars' /g <enter> :g/\n/s// /g <enter>
% EEG-DATA assumes Deci.bdf data files in one directory. 
% in EEG-ANAL, Need subdirectories CMD, GRAND, MEASURE.
% in EEG-ANAL, need subdirectories for each subject: S01, S02, S02, ... SNN 
% where NN= number of last subject in experiment.
% To setup, try batch file, setupanal.sh or setupanal.bat
% type eeglab redraw and/or erplab redraw right before you go back to the GUI after executing commands from the command line or a script.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Clear memory and the command window
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear
clc
disp('Setting up...')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% START SET UP %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MODIFY THE FOLLOWING FOR YOUR EXPERIMENT ***************************

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LINUX OR WINDOWS: UNCOMMENT FOR YOUR OPERATING SYSTEM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LINUX START
% * CHANGE * for each experiment
% User's Paths
pathname_all = '/home/schendan/ERPDATA/Color/'; %where experiment is

% Common paths: Should be the same for all Schendan Team Experiments
pathname_raw  = strcat(pathname_all,'EEG-DATA/'); %where original biosemi or raw datafiles are
pathname_anal  = strcat(pathname_all,'EEG-ANAL/'); %where intermediate data and analysis command files are
pathname_cmd  = strcat(pathname_anal,'CMD/');
%pathname_anal = strcat(pathname_anal,'EEGLab/'); % where EEGLab intermediate files are
%data_path = strcat(pathname_anal,'ERPLab/'); % where ERPLab intermediate files are
%for GARVing. Delete ERPtmp when done.
%pathname_ERPtmp = strcat(pathname_anal,'ERPtmp/'); % temporary directory
% pathname_savg = strcat(pathname_anal,'SessionAvg/'); % UNCOMMENT if needed: only for multi-session experiments
pathname_gav = strcat(pathname_anal,'GRAND/');
pathname_meas = strcat(pathname_anal,'MEASURE/');
% LINUX END

% WINDOWS START
% User's Paths
%pathname_all = 'C:\color and ImaRecall\Color\'; % where experiment is

% Common paths: Should be the same for all Schendan Team Experiments
%pathname_raw  = strcat(pathname_all,'EEG-DATA\');
%pathname_anal  = strcat(pathname_all,'EEG-ANAL\'); % where raw bdfs are
%pathname_cmd  = strcat(pathname_all,'CMD\');
%%pathname_anal = strcat(pathname_all,'EEGLab\');
%%data_path = strcat(pathname_all,'ERPLab\');
%for GARVing. Delete ERPtmp when done.
%%pathname_ERPtmp = strcat(pathname_all,'ERPtmp\');
%%pathname_savg = strcat(pathname_all,'SessionAvg\');
%pathname_gav = strcat(pathname_all,'Grand\');
%pathname_meas = strcat(pathname_all,'Measure\');
% WINDOWS END
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% * CHANGE * FLAGS for each experiment
% SELECT FLAGS, as needed for each phase of analysis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Global flags determine how script runs
save_everything  = 0; % Only used when NOT running modular
mod = 1; % Run MODULAR, load and save each step
ch64 = 1; % 64 channel, else 32 channel
CAR = 1;    % In addition  to mean mastoid reference M12, also create CAR ref
RTlock = 0; % default 0; not implemented for refch and from addeye onwards % run parts for response locked ERPs, needed for LRP
lrp = 0; %not implemented % Use for Lateralized Readiness Potential (LRP)
binlisb = 1; % default is 1; binlister option: Use bin # to label epochs, transfer to EEG structure checked

% ERPLab Function Flags in sequence
import = 1; % run alone first then never again (also helpful for some subjects with specific file problems)
chanloc = 0;   % Add channel locations
elist = 0;  % EventList
binlis = 0; % Binlister
refch = 0;  % Define reference channel for biosemi data, default M12, option CAR
epoch = 0;  % BinEpoch
addeye = 0; % Add eye channels
artif = 0; % ar 
avg = 0; % NOT implemented separately
gavg = 0;   % input required in CMD: 1 column list of subject .erp files with pathname in erpfiles.txt
meas = 0; % 
% script works thru here
lp = 0; % not checked that it works but should work
bo = 0; % bin op to collapse channels & create LRP: Stimulus-locked

%%%%% START %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% * CHANGE * filenames for each experiment
% list filenames of raw data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FOR TESTING SCRIPT ONLY: start, UNCOMMENT if needed
% short temporary versions of rawdata, nraw, and eegsubj variables for testing script only. 

%rawdata = {'color_s01.1_A11F-Deci.bdf' 'color_S02_A12R-Deci.bdf'}; 
%nraw = length(rawdata); % number of BioSemi bdf or raw datafiles, based on number of files defined as rawdata
%subject = {'S01' 'S02' };
%bdf = {'bdf.txt' 'bdf.txt'};
%bdfRTlock = {'bdfRTlock.txt' 'bdfRTlock.txt' };

% FOR TESTING SCRIPT ONLY: end
% COMMENT OUT WHEN DONE TESTING SCRIPT and change below from xsubject to subject 
%%%%% END %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%% START %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TO DO:
% * CHANGE * replace with name for each experiment
expname = 'Color';  
chloc64 = strcat(pathname_cmd, 'biosemi64xyz10-20.xyz');  % Not implemented: filename of channel location file, script default is matlab xyz format
artparm = load(strcat(pathname_cmd, 'garvparm.txt'));  
%artparmRT = load('garvparm2.txt'); 
% * CHANGE * replace with # bins in bin descriptor file for this experiment
allbins = 174; % color 174


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% UNCOMMENT/DELETE X after testing; COMMENT OUT WITH % OR ADD X FOR TESTING
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rawdata = {'color_s01.1_A11F-Deci.bdf' 'color_S02_A12R-Deci.bdf' 'color_S03_B21R-Deci.bdf' 'color_S04_B22R-Deci.bdf' 'color_S05_A21R-Deci.bdf' 'color_S06_B12F-Deci.bdf' 'color_S07_A22R-Deci.bdf' 'color_S08_B11F-Deci.bdf' 'color_S09_A12F-Deci.bdf' 'color_S10_B22F-Deci.bdf' 'Color_S11_B21F-Deci.bdf' 'Color_S12_A11R-Deci.bdf' 'color_S13_B11R-Deci.bdf' 'Color_S14_A22F-Deci.bdf' 'color_S15_B12R-Deci.bdf' 'Color_S16_A21F-Deci.bdf' 'Color_S17_A11F-Deci.bdf' 'Color_S18_A12R-Deci.bdf' 'Color_S19_B21R-Deci.bdf' 'Color_S20_B22R-Deci.bdf' 'Color_S21_A21R-Deci.bdf' 'Color_S22_B12F-Deci.bdf' 'Color_S23_A22R-Deci.bdf' 'Color_S24_B11F-Deci.bdf' 'Color_S25_A12F-Deci.bdf' 'Color_S26_B22F-Deci.bdf' 'Color_S27_B21F-Deci.bdf' 'Color_S28_A11R-Deci.bdf' 'Color_S29_B11R-Deci.bdf' 'Color_S30_A22F-Deci.bdf' 'Color_S31_B12R-Deci.bdf' 'Color_S32_A21F-Deci.bdf' 'Color_S33_B22R_Replace_S04-Deci.bdf' 'Color_S34_A22F_Replace_14-Deci.bdf' 'Color_S35_B12R_Replace_S15-Deci.bdf' 'Color_S36_A11F-Deci.bdf' 'Color_S37_A12R-Deci.bdf' 'Color_S38_B21R-Deci.bdf' 'Color_S39_B22R-Deci.bdf' 'Color_S40_A21R-Deci.bdf' 'Color_S41_B12F-Deci.bdf' 'Color_S42_A22R-Deci.bdf' 'Color_S43_B11F-Deci.bdf' 'Color_S44_A12F-Deci.bdf' 'Color_S45_B22F-Deci.bdf' 'Color_S46_B21F-Deci.bdf' 'Color_S47_A11R-Deci.bdf' 'Color_S48_B11R-Deci.bdf' 'Color_S49_A22F-Deci.bdf' 'Color_S50_B12R-Deci.bdf' 'Color_S51_A21F-Deci.bdf' 'Color_S52_A22R_Replace_S42-Deci.bdf' };
nraw = length(rawdata); % number of BioSemi bdf or raw datafiles, based on number of files defined as rawdata
% filenames to create in EEGLab for each subject (when translating from raw/biosemi to EEGLab
% Template: subject = {'S01','S02','S03','S04','S05','S06','S07','S08','S09','S10','S11','S12','S13','S14','S15','S16','S17','S18','S19','S20','S21','S22','S23','S24','S25','S26','S27','S28','S29','S30','S31','S32','S33','S34','S35','S36','S37','S38','S39','S40','S41','S42','S43','S44','S45','S46','S47','S48','S49','S50','S51','S52'};
subject = {'S01','S02','S03','S04','S05','S06','S07','S08','S09','S10','S11','S12','S13','S14','S15','S16','S17','S18','S19','S20','S21','S22','S23','S24','S25','S26','S27','S28','S29','S30','S31','S32','S33','S34','S35','S36','S37','S38','S39','S40','S41','S42','S43','S44','S45','S46','S47','S48','S49','S50','S51','S52','S53','S54','S55','S56','S57','S58','S59'};
nsubj = length(subject); % # subjects or # EEGLab .set files

% * CHANGE * filename of bdf file for each experiment, depending on whether 
% bin descriptor file = bdf
% (A) same bdf for all subjects or 
% (B) each subject or group has a different bdf file
% UNCOMMENT A or B, and specify filename(s) for each experiment
% (A) same bdf for all subjects
bdf = {'bdf.txt' 'bdf.txt' 'bdf.txt' 'bdf.txt' 'bdf.txt' 'bdf.txt' 'bdf.txt' 'bdf.txt' 'bdf.txt' 'bdf.txt' 'bdf.txt' 'bdf.txt' 'bdf.txt' 'bdf.txt' 'bdf.txt' 'bdf.txt' 'bdf.txt' 'bdf.txt' 'bdf.txt' 'bdf.txt' 'bdf.txt' 'bdf.txt' 'bdf.txt' 'bdf.txt' 'bdf.txt' 'bdf.txt' 'bdf.txt' 'bdf.txt' 'bdf.txt' 'bdf.txt' 'bdf.txt' 'bdf.txt' 'bdf.txt' 'bdf.txt' 'bdf.txt' 'bdf.txt' 'bdf.txt' 'bdf.txt' 'bdf.txt' 'bdf.txt' 'bdf.txt' 'bdf.txt' 'bdf.txt' 'bdf.txt' 'bdf.txt' 'bdf.txt' 'bdf.txt' 'bdf.txt' 'bdf.txt' 'bdf.txt' 'bdf.txt' 'bdf.txt'}; % A: Same bdf all subjects
% (B) each subject or group has a different bdf file
% bdf = {'inny-test.txt' 'inny-test.txt' 'inny-test.txt' 'inny-test.txt' 'inny-test.txt' 'inny-test.txt' 'inyn-test.txt' 'inyn-test.txt' 'inyn-test.txt' 'inyn-test.txt' 'inyn-test.txt' 'inyn-test.txt' 'otny-test.txt' 'otny-test.txt' 'otny-test.txt' 'otny-test.txt' 'otny-test.txt' 'otny-test.txt' 'otyn-test.txt' 'otyn-test.txt' 'otyn-test.txt' 'otyn-test.txt' 'otyn-test.txt' 'otyn-test.txt'}; % B: Different bdf all/some subjects 

% RT-locked bdf
% If also RT-locked ERPs, then UNCOMMENT A or B, and specify filename(s) for each experiment
% (A) same bdf for all subjects
%bdfRTlock = {'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt'}; % A: Same bdfRTlock all subjects % (B) each subject or group has a different bdfRTlock file
% (B) each subject or group has a different bdf file
% bdfRTlock = {'bdfRTlock01.txt' 'bdfRTlock02.txt' 'bdfRTlock03.txt' 'bdfRTlockGP1.txt' 'bdfRTlockGP2.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt' 'bdfRTlock.txt'}; % A: Same bdfRTlock all subjects % (B) each subject or group has a different bdfRTlock file
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% END %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End parameter set up
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% END SET UP %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% SCRIPT RUNS FROM HERE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MODULES BELOW: Load and save each step; makes it easy to re-run any step
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if mod   % if modular
    % Initialize the ALLERP structure and CURRENTERP
ALLERP = buildERPstruct([]);
CURRENTERP = 0;
disp('Working...')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Import and translate BioSemi/Raw Data into EEGLab .set
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if import
	disp('Importing biosemi data.bdf into EEGLab and saving as EEGLab sets ...')  
    for s=1:nraw
        fprintf('\n******\nProcessing subject %s\n******\n\n', subject{s});
        EEG = pop_biosig([pathname_raw rawdata{s}]);
        EEG = eeg_checkset( EEG );
        data_path = [pathname_anal subject{s} '/'];  % Path to the folder containing the current subject's data
        EEG = pop_saveset( EEG, 'filename', [subject{s} '.set'],'filepath', data_path);
        EEG = eeg_checkset( EEG );   
    end
    disp('Import: done! ...')
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Add Channel Locs 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
if chanloc
for s=1:nsubj
    data_path = [pathname_anal subject{s} '/'];  % Path to the folder containing the current subject's data
    sname = [data_path subject{s} '.set'];        
    if exist(sname, 'file')>0
        disp('Add channel locations: WORKING! ...')
        clear EEG;  % Clear is to make sure that we start fresh for each subject with the EEG structures
        EEG = pop_loadset('filename', [subject{s} '.set'], 'filepath', data_path);                
        if ch64 % 64 channel cap            
            %EEG=pop_chanedit(EEG, 'load',{'/home/schendan/ERPDATA/Color/EEG-ANAL/CMD/biosemi64xyz10-20.xyz' 'filetype' 'xyz'});
            EEG=pop_chanedit(EEG, 'load', { [pathname_cmd 'biosemi64xyz10-20.xyz'] 'filetype' 'xyz'});
%            EEG=pop_chanedit(EEG, 'load', { chloc, 'filetype' 'xyz'});
%chloc = {'biosemi64xyz10-20.xyz'};  % Not implemented: filename of channel location file, script default is matlab xyz format
            %EEG=pop_chanedit(EEG, 'load', { [pathname_cmd chloc] 'filetype' 'xyz'});
        else % 32 channel cap           EEG.setname= [subject{s} '_ebec'];
            EEG=pop_chanedit(EEG, 'load', { [pathname_cmd 'biosemi32xyz10-20.xyz'] 'filetype' 'xyz'});
        end
        EEG.setname= [subject{s} '_c'];
        EEG = pop_saveset(EEG, 'filename', [EEG.setname '.set'], 'filepath', data_path);             
    else
        fprintf('\n *** WARNING: %s does not exist *** \n\n', sname);
    end
end
disp('Add Channel Locations: DONE! ...')
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Creates ERPLab Eventlist (Basic) Pg. 15
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if elist 
disp('Using ERPLab to Create EEG Eventlist (Basic) in EEGLab file ...')
for s=1:nsubj
    clear EEG;  % Clear is to make sure that we start fresh for each subject with the EEG structures
    data_path = [pathname_anal subject{s} '/'];  % Path to the folder containing the current subject's data
    sname = [data_path subject{s} '_c.set'];       
    if exist(sname, 'file')>0
        % Load dataset
        EEG = pop_loadset('filename', [subject{s} '_c.set'], 'filepath', data_path);                
        % Creates basic EVENTLIST (Option 1)
        EEG = pop_creabasiceventlist(EEG, 'AlphanumericCleaning', 'on', 'BoundaryNumeric', { -99 }, 'BoundaryString', { 'boundary' }, 'Eventlist', [data_path subject{s} '_e_list.txt'], 'Warning', 'on' );               
        % Advanced event list editing (Option 2)
        %EEG  = pop_editeventlist( EEG , 'AlphanumericCleaning', 'on', 'BoundaryNumeric', { -99}, 'BoundaryString', { 'boundary' }, 'ExportEL', [data_path subject{s} '_e_list.txt'], 'SendEL2', 'EEG&Text', 'UpdateEEG', 'on', 'Warning', 'on' );
        %EEG  = pop_overwritevent( EEG, 'code' ); 
        % Save dataset
        EEG.setname = [subject{s} '_ce']; % name for the dataset menu
        EEG= pop_saveset(EEG, 'filename', [EEG.setname '.set'], 'filepath', data_path); 
    else
        fprintf('\n *** WARNING: %s does not exist *** \n\n', sname);
        fprintf('\n *** Skip all processing for this subject *** \n\n');
    end
end
disp('Imported event info (Basic) into ERPLab from EEGLab: done! ...')
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Assign bins (Binlister) (based on demo1.txt Pg. 54)
%   ADD RT OUTPUT FLAGS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if binlis
disp('binlister working ...')
for s=1:nsubj
    data_path = [pathname_anal subject{s} '/'];  % Path to the folder containing the current subject's data
    sname = [data_path subject{s} '_ce.set'];       
    if exist(sname, 'file')>0                
        clear EEG;  % Clear is to make sure that we start fresh for each subject with the EEG structures
        % Load dataset
        EEG = pop_loadset('filename', [subject{s} '_ce.set'], 'filepath', data_path);           
        % Binlister. Detects bin(s)
        % If you want to update the event information in the EEG structure, you can check the Transfer EVENTLIST info… box.  This will allow you to view the EEG data with bin numbers rather than event codes or event labels (which is occasionally useful).
        if binlisb
            EEG = pop_binlister( EEG, 'BDF', [pathname_cmd bdf{s}], 'ExportEL', [data_path subject{s} '_blout.txt'], 'IndexEL',  1, 'SendEL2', 'EEG&Text', 'UpdateEEG', 'on', 'Voutput', 'EEG' );                 
        else
            EEG = pop_binlister( EEG, 'BDF', [pathname_cmd bdf{s}], 'ExportEL', [data_path subject{s} '_blout.txt'], 'IndexEL',  1, 'SendEL2', 'EEG&Text', 'UpdateEEG', 'off', 'Voutput', 'EEG' );                 
        end
        % Name dataset
        EEG.setname= [subject{s} '_ceb'];
        % Save dataset
        EEG= pop_saveset(EEG, 'filename', [EEG.setname '.set'], 'filepath', data_path); 
        % RT export, basic RT and detailed RTs format: to get RTs used for ERPs arfilter
        values = pop_rt2text(EEG, 'eventlist',  1, 'filename', [data_path EEG.setname 'ceb_RT.txt'], 'header', 'on', 'listformat', 'basic' );
        values = pop_rt2text(EEG, 'eventlist',  1, 'filename', [data_path EEG.setname 'ceb_RTs.txt'], 'header', 'on', 'listformat', 'itemized' );
        % RT lock ERPs: Do load, binlister, and save for RT-lock
        if RTlock
            disp('binlister RT-locked working ...')
            clear EEG;  % Clear is to make sure that we start fresh for each subject with the EEG structures
            EEG = pop_loadset('filename', [subject{s} '_ce.set'], 'filepath', data_path);           
            if binlisb
                EEG = pop_binlister( EEG, 'BDF', [pathname_cmd bdfRTlock{s}], 'ExportEL', [data_path subject{s} '_RTlock_blout.txt'], 'IndexEL',  1, 'SendEL2', 'EEG&Text', 'UpdateEEG', 'on', 'Voutput', 'EEG' );                 
            else
                EEG = pop_binlister( EEG, 'BDF', [pathname_cmd bdfRTlock{s}], 'ExportEL', [data_path subject{s} '_RTlock_blout.txt'], 'IndexEL',  1, 'SendEL2', 'EEG&Text', 'UpdateEEG', 'off', 'Voutput', 'EEG' ); 
            end
            EEG.setname= [subject{s} '_RT_ceb'];
            EEG= pop_saveset(EEG, 'filename', [EEG.setname '.set'], 'filepath', data_path); 
            % RT export, basic RT and detailed RTs format
            values = pop_rt2text(EEG, 'eventlist',  1, 'filename', [data_path EEG.setname 'RTlock_ceb_RT.txt'], 'header', 'on', 'listformat', 'basic' );
            values = pop_rt2text(EEG, 'eventlist',  1, 'filename', [data_path EEG.setname 'RTlock_ceb_RTs.txt'], 'header', 'on', 'listformat', 'itemized' );
        end
        fprintf('binlister done for %s! \n', sname);
    else
        fprintf('\n *** WARNING: %s does not exist *** \n\n', sname);
    end
end
disp('binlister: DONE! ...')
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Reference to mean of bilateral mastoids & CAR  
% To DO: Add RTlock
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
if refch
disp('Ref: WORKING ...')
for s=1:nsubj
    data_path = [pathname_anal subject{s} '/'];  % Path to the folder containing the current subject's data
    sname = [data_path subject{s} '_ceb.set'];        
    if exist(sname, 'file')>0
        clear EEG;  % Clear is to make sure that we start fresh for each subject with the EEG structures
        EEG = pop_loadset('filename', [subject{s} '_ceb.set'], 'filepath', data_path);
        if ch64 % 64 channel cap
            EEG = pop_reref( EEG, [68 69],'keepref','on'); % reference to mean of M1 and M2
        else    % 32 channel cap
            EEG = pop_reref( EEG, [36 37],'keepref','on');
        end
        EEG.setname= [subject{s} '_cebM12'];
        EEG= pop_saveset(EEG, 'filename', [EEG.setname '.set'], 'filepath', data_path); 
        if CAR
            clear EEG;  % Clear is to make sure that we start fresh for each subject with the EEG structures
            EEG = pop_loadset('filename', [subject{s} '_ceb.set'], 'filepath', data_path); 
            EEG = pop_reref( EEG, []); % Common average reference,
             %EEG = pop_reref( EEG, [],'exclude',[65:67] ); % Common average reference for 64 ch, exclude HE1, HE2, LE
            EEG.setname= [subject{s} '_cebCAR'];
            EEG= pop_saveset(EEG, 'filename', [EEG.setname '.set'], 'filepath', data_path); 
        end
    else
        fprintf('\n *** WARNING: %s does not exist *** \n\n', sname);
    end
end
disp('Re-Referenced to M12 and CAR: DONE! ...')
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Create Bin based Epoch Pg. 19
% For ICA, re-reference before epoching; rereference non-epoched data
% To do: RTlock
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if epoch
    disp('Create Bin based Epoch: WORKING ...')
for s=1:nsubj
    data_path = [pathname_anal subject{s} '/'];  % Path to the folder containing the current subject's data
    sname = [data_path subject{s} '_cebM12.set'];        
    if exist(sname, 'file')>0
        clear EEG;  % Clear is to make sure that we start fresh for each subject with the EEG and ERP structures
        % Load dataset
        EEG = pop_loadset('filename', [subject{s} '_cebM12.set'], 'filepath', data_path);                
        % Extracts bin-based epochs (200 ms pre-stim, 900 ms post-stim. Baseline correction by pre-stim window)
        EEG = pop_epochbin( EEG , [-200.0  900.0],  'pre');               
        EEG.setname= [subject{s} '_cebM12e'];
        % Save dataset
        EEG = pop_saveset(EEG, 'filename', [EEG.setname '.set'], 'filepath', data_path); 
        if CAR
            data_path = [pathname_anal subject{s} '/'];  % Path to the folder containing the current subject's data
            sname = [data_path subject{s} '_cebCAR.set'];        
            if exist(sname, 'file')>0
                clear EEG;  % Clear is to make sure that we start fresh for each subject with the EEG structures
                EEG = pop_loadset('filename', [subject{s} '_cebCAR.set'], 'filepath', data_path); 
                EEG = pop_epochbin( EEG , [-200.0  900.0],  'pre');               
                EEG.setname= [subject{s} '_cebCARe'];
                EEG= pop_saveset(EEG, 'filename', [EEG.setname '.set'], 'filepath', data_path); 
            else
                fprintf('\n *** WARNING: %s does not exist *** \n\n', sname);
            end
        end
    else
        fprintf('\n *** WARNING: %s does not exist *** \n\n', sname);
    end
    % RT lock ERP
    if RTlock
        sname = [data_path subject{s} '_RT_cebM12.set'];        
        if exist(sname, 'file')>0
            disp('Create Bin based Epoch for RT-locked: WORKING ...')
            clear EEG;  % Clear is to make sure that we start fresh for each subject with the EEG structures
            EEG = pop_loadset('filename', [subject{s} '_RT_cebM12.set'], 'filepath', data_path);                
            EEG = pop_epochbin( EEG , [-1100.0  500.0],  [-1100 -1000]);               
            EEG.setname= [subject{s} '_RT_cebM12e'];
            EEG = pop_saveset(EEG, 'filename', [EEG.setname '.set'], 'filepath', data_path);    
            if CAR
                data_path = [pathname_anal subject{s} '/'];  % Path to the folder containing the current subject's data
                sname = [data_path subject{s} '_RT_cebCAR.set'];        
                if exist(sname, 'file')>0
                    clear EEG;  % Clear is to make sure that we start fresh for each subject with the EEG structures
                    EEG = pop_loadset('filename', [subject{s} '_RT_cebCAR.set'], 'filepath', data_path); 
                    EEG = pop_epochbin( EEG , [-1100.0  500.0],  [-1100 -1000]);               
                    EEG.setname= [subject{s} '_RT_cebCARe'];
                    EEG= pop_saveset(EEG, 'filename', [EEG.setname '.set'], 'filepath', data_path); 
                else
                    fprintf('\n *** WARNING: %s does not exist *** \n\n', sname);
                end            
        else
            fprintf('\n *** WARNING: %s does not exist *** \n\n', sname);
        end
    end
    end
end
disp('Created Bin based Epoch: DONE! ...')
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Add Channels for Artifact Detection. Also Copy LE and Fp2 to end
% To do: RTlock
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if addeye
disp('Add eye channels ...')
for s=1:nsubj
    data_path = [pathname_anal subject{s} '/'];  % Path to the folder containing the current subject's data
    sname = [data_path subject{s} '_cebM12e.set'];        
    if exist(sname, 'file')>0
        disp('Add eye channels: WORKING ...')
        clear EEG;  % Clear is to make sure that we start fresh for each subject with the EEG structures
        EEG = pop_loadset('filename', [subject{s} '_cebM12e.set'], 'filepath', data_path);                
        % Add HEOG and Blink/VEOG channels, and Copy LE and Fp2 to below Copy LE and Fp2 to below VE/blink
        if ch64 % 64 channel cap            
            %EEG = pop_eegchanoperator( EEG, {  ' nch1 = ch1 label 1'   ' nch2 = ch2 label HE'   ' nch3 = ch3 label M2'   ' nch4 = ch4 label ns'   ' nch5 = ch5 label 1'   ' nch6 = ch6 label 2'   ' nch7 = ch7 label 3'   ' nch8 = ch8 label 4'   ' nch9 = ch9 label 5'   ' nch10 = ch10 label 6'   ' nch11 = ch11 label 7'   ' nch12 = ch12 label 8'   ' nch13 = ch13 label 9'   ' nch14 = ch14 label 10'   ' nch15 = ch15 label 11'   ' nch16 = ch16 label 12'   ' nch17 = ch17 label 13'   ' nch18 = ch18 label 14'   ' nch19 = ch19 label 15'   ' nch20 = ch20 label 16'   ' nch21 = ch21 label 17'   ' nch22 = ch22 label 18'   ' nch23 = ch23 label 19'   ' nch24 = ch24 label 20'   ' nch25 = ch25 label 21'   ' nch26 = ch26 label 22'   ' nch27 = ch27 label 23'   ' nch28 = ch28 label 24'   ' nch29 = ch29 label 25'   ' nch30 = ch30 label 26'   ' nch31 = ch31 label 27'   ' nch32 = ch32 label 28'   ' nch33 = ch33 label 29'   ' nch34 = ch34 label 30'   ' nch35 = ch35 label 31'   ' nch36 = ch36 label 32'   ' nch37 = ch37 label 33'   ' nch38 = ch38 label 34'   ' nch39 = ch39 label 35'   ' nch40 = ch40 label 36'   ' nch41 = ch41 label 37'   ' nch42 = ch42 label 38'   ' nch43 = ch43 label 39'   ' nch44 = ch44 label 40'   ' nch45 = ch45 label 41'   ' nch46 = ch46 label 42'   ' nch47 = ch47 label 43'   ' nch48 = ch48 label 44'   ' nch49 = ch49 label 45'   ' nch50 = ch50 label 46'   ' nch51 = ch51 label 47'   ' nch52 = ch52 label 48'   ' nch53 = ch53 label 49'   ' nch54 = ch54 label 50'   ' nch55 = ch55 label 51'   ' nch56 = ch56 label 52'   ' nch57 = ch57 label 53'   ' nch58 = ch58 label 54'   ' nch59 = ch59 label 55'   ' nch60 = ch60 label 56'   ' nch61 = ch61 label 57'   ' nch62 = ch62 label 58'   ' nch63 = ch63 label 59'   ' nch64 = ch64 label 60'   ' nch65 = ch65 label' 'ch70 = ch67 - ch66 label HEOG' 'Ch71 = ch1 - ch65 label VOG' '  });
            EEG = pop_eegchanoperator( EEG, { 'ch70 = ch65 - ch66 label HE' 'ch71 = ch34 - ch67 label VE' 'ch72 = ch34 label Fp2c' 'ch73 = ch67 label LEc'});
        else    % 32 channel cap
            EEG = pop_eegchanoperator( EEG, { 'ch38 = ch33 - ch34 label HE' 'ch39 = ch30 - ch35 label VE' 'ch40 = ch30 label Fp2c' 'ch41 = ch35 label LEc'});
        end    
        EEG.setname= [subject{s} '_cebM12ey'];
        EEG = pop_saveset(EEG, 'filename', [EEG.setname '.set'], 'filepath', data_path); 
        if CAR
            data_path = [pathname_anal subject{s} '/'];  % Path to the folder containing the current subject's data
            sname = [data_path subject{s} '_cebCARe.set'];        
            if exist(sname, 'file')>0
                clear EEG;  % Clear is to make sure that we start fresh for each subject with the EEG structures
                EEG = pop_loadset('filename', [subject{s} '_cebCARe.set'], 'filepath', data_path); 
                if ch64 % 64 channel cap            
                    EEG = pop_eegchanoperator( EEG, { 'ch70 = ch65 - ch66 label HE' 'ch71 = ch34 - ch67 label VE' 'ch72 = ch34 label Fp2c' 'ch73 = ch67 label LEc' });
                else    % 32 channel cap
                    EEG = pop_eegchanoperator( EEG, { 'ch38 = ch33 - ch34 label HE' 'ch39 = ch30 - ch35 label VE' 'ch40 = ch30 label Fp2c' 'ch41 = ch35 label LEc'});
                end    
                EEG.setname= [subject{s} '_cebCARey'];
                EEG= pop_saveset(EEG, 'filename', [EEG.setname '.set'], 'filepath', data_path); 
            else
                fprintf('\n *** WARNING: %s does not exist *** \n\n', sname);
            end
        end
    else
        fprintf('\n *** WARNING: %s does not exist *** \n\n', sname);
    end    
    % RT lock ERP
    if RTlock
        sname = [data_path subject{s} '_RT_cebM12e.set'];        
        if exist(sname, 'file')>0
            disp('Add eye channels for RT-locked: WORKING ...')
            clear EEG;  % Clear is to make sure that we start fresh for each subject with the EEG structures
            EEG = pop_loadset('filename', [subject{s} '_RT_cebM12e.set'], 'filepath', data_path);                
            if ch64 % 64 channel cap
                EEG = pop_eegchanoperator( EEG, { 'ch70 = ch65 - ch66 label HE' 'ch71 = ch34 - ch67 label VE' 'ch72 = ch34' 'ch73 = ch67'});
            else    % 32 channel cap
                EEG = pop_eegchanoperator( EEG, { 'ch38 = ch33 - ch34 label HE' 'ch39 = ch30 - ch35 label VE' 'ch40 = ch30' 'ch41 = ch35'});
            end                           
            EEG.setname= [subject{s} '_RT_cebM12ey'];
            EEG = pop_saveset(EEG, 'filename', [EEG.setname '.set'], 'filepath', data_path);     
        else
            fprintf('\n *** WARNING: %s does not exist *** \n\n', sname);
        end
    end
end
disp('Added eye channels: DONE! ...')
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Artifact Detection & artifact-free average
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if artif
disp('Artifact detection: Working ...')
for s=1:nsubj
    data_path = [pathname_anal subject{s} '/'];  % Path to the folder containing the current subject's data
    sname = [data_path subject{s} '_cebM12ey.set'];       
    if exist(sname, 'file')>0               
    clear EEG;  % Clear is to make sure that we start fresh for each subject with the EEG and ERP structures
%    clear ERP;  % Clear is to make sure that we start fresh for each subject with the EEG and ERP structures
        EEG = pop_loadset('filename', [subject{s} '_cebM12ey.set'], 'filepath', data_path);                
%TO DO: Detect artifacts for current dataset. Adjust parameter values after EEG in function
% Artifact detection notes: 
% BLINK & HEOG: Step-like. Test window = [-100 898] ms; Threshold = TODO uV; Window width = 400 ms (use default or TODO); Window step = 10 ms; Channels = 65 (Blink); Flags to be activated = 1 & 3
        if ch64 % 64 channel cap            
            EEG = pop_artextval( EEG, 'Channel', [1:64,70:71], 'Flag', [ 1 2], 'Review', 'off', 'Threshold', [ artparm(s,1) artparm(s,2)], 'Twindow', [-200 900]); %Voltage threshold
            EEG = pop_artstep( EEG , 'Channel',  71, 'Flag', [ 1 3], 'Review', 'off', 'Threshold',  artparm(s,3), 'Twindow', [ -200 900], 'Windowsize',  artparm(s,4), 'Windowstep',  artparm(s,5) ); % step-like artifacts VEOG
            EEG = pop_artstep( EEG , 'Channel',  70, 'Flag', [ 1 4], 'Review', 'off', 'Threshold',  artparm(s,6), 'Twindow', [ -200 900], 'Windowsize',  artparm(s,7), 'Windowstep',  artparm(s,8) ); % step-like artifacts HEOG
            EEG = pop_artstep( EEG , 'Channel',  1:64, 'Flag', [ 1 5], 'Review', 'off', 'Threshold',  artparm(s,9), 'Twindow', [ -200 900], 'Windowsize',  artparm(s,10), 'Windowstep',  artparm(s,11) ); % step-like artifacts other chans
            EEG = pop_artmwppth( EEG , 'Channel',  1:64, 'Flag', [ 1 6], 'Review', 'off', 'Threshold',  artparm(s,12), 'Twindow', [ -200 900], 'Windowsize',  artparm(s,13), 'Windowstep',  artparm(s,14) ); % P2P ALL
            EEG = pop_artmwppth( EEG , 'Channel',  71, 'Flag', [ 1 7], 'Review', 'off', 'Threshold',  artparm(s,15), 'Twindow', [ -200 900], 'Windowsize',  artparm(s,16), 'Windowstep',  artparm(s,17) ); % P2P VOG           
            EEG = pop_artdiff( EEG , 'Channel',  1:64, 'Flag', [ 1 8], 'Review', 'off', 'Threshold',  artparm(s,18), 'Twindow', [ -200 900] ); %Extreme spikiness
        else    % 32 channel cap: TO check
            EEG = pop_artextval( EEG, 'Channel', [1:32,38:39], 'Flag', [ 1 2], 'Review', 'off', 'Threshold', [ artparms(s,1) artparms(s,2)], 'Twindow', [-200 900]); %Voltage threshold
            EEG = pop_artstep( EEG , 'Channel',  39, 'Flag', [ 1 3], 'Review', 'off', 'Threshold',  artparms(s,3), 'Twindow', [ -200 900], 'Windowsize',  artparms(s,4), 'Windowstep',  artparms(s,5) ); % step-like artifacts VEOG
            EEG = pop_artstep( EEG , 'Channel',  38, 'Flag', [ 1 4], 'Review', 'off', 'Threshold',  artparms(s,6), 'Twindow', [ -200 900], 'Windowsize',  artparms(s,7), 'Windowstep',  artparms(s,8) ); % step-like artifacts HEOG
            EEG = pop_artstep( EEG , 'Channel',  1:32, 'Flag', [ 1 5], 'Review', 'off', 'Threshold',  artparms(s,9), 'Twindow', [ -200 900], 'Windowsize',  artparms(s,10), 'Windowstep',  artparms(s,11) ); % step-like artifacts other chans
            EEG = pop_artmwppth( EEG , 'Channel',  1:32, 'Flag', [ 1 6], 'Review', 'off', 'Threshold',  artparms(s,12), 'Twindow', [ -200 900], 'Windowsize',  artparms(s,13), 'Windowstep',  artparms(s,14) ); % P2P ALL
            EEG = pop_artmwppth( EEG , 'Channel',  39, 'Flag', [ 1 7], 'Review', 'off', 'Threshold',  artparms(s,15), 'Twindow', [ -200 900], 'Windowsize',  artparms(s,16), 'Windowstep',  artparms(s,17) ); % P2P VOG           
            EEG = pop_artdiff( EEG , 'Channel',  1:32, 'Flag', [ 1 8], 'Review', 'off', 'Threshold',  artparms(s,18), 'Twindow', [ -200 900] ); %Extreme spikiness
        end    
        EEG.setname= [subject{s} '_cebM12eya'];
        EEG = pop_saveset(EEG, 'filename', [EEG.setname '.set'], 'filepath', data_path);   
        % Export ar info          
        EEG = pop_exporteegeventlist(EEG, [data_path, subject{s} '_EEG_ar.txt']);
        pop_summary_AR_eeg_detection(EEG, [data_path, subject{s} '_EEG_arTab.txt']);  % Save ar Table
        values = pop_rt2text(EEG, 'arfilter', 'on', 'eventlist',  1, 'filename', [data_path EEG.setname '_arRT.txt'], 'header','on', 'listformat', 'basic' );
        values = pop_rt2text(EEG, 'arfilter', 'on', 'eventlist',  1, 'filename', [data_path EEG.setname '_arRTs.txt'], 'header','on', 'listformat', 'itemized' );
%            ERP = pop_averager( EEG, 'Criterion', 'good', 'Stdev', 'on');
%            erpname = [subject{s} 'M12_ar'];  % name for erpset menu
%            fname_erp= fullfile(data_path, [erpname '.erp']);
%            pop_savemyerp(ERP, 'erpname', erpname, 'filename', fname_erp, 'warning', 'off');  
    else
            fprintf('\n *** WARNING: %s does not exist *** \n\n', sname);
    end
disp('Artifact rejection: DONE! ...')
%disp('Artifact rejection & artifact-free average: DONE! ...')
end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Average ERP Pg. 28
% Note: Added eye channels only show in classic ERP plot, untick all
% channels, plot, then plot again tick all chans
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if avg
    disp('ERP Averaging: Working ...')
for s=1:nsubj
    data_path = [pathname_anal subject{s} '/'];  % Path to the folder containing the current subject's data
    sname = [data_path subject{s} '_cebM12eya.set'];       
    if exist(sname, 'file')>0               
        clear EEG;  % Clear is to make sure that we start fresh for each subject with the EEG and ERP structures
        clear ERP;  % Clear is to make sure that we start fresh for each subject with the EEG and ERP structures
        EEG = pop_loadset('filename', [subject{s} '_cebM12eya.set'], 'filepath', data_path);     
        % Good trials, no artifacts
        % matlab2015b, eeglab13, erplab 5 spectra doesn't work
        %ERP = pop_averager( EEG , 'Compute', 'TFFT', 'Criterion', 'good', 'ExcludeBoundary', 'on', 'SEM', 'on', 'TaperWindow', {'Hanning' [-200 900]});
        ERP = pop_averager( EEG , 'Criterion', 'good', 'ExcludeBoundary', 'on', 'SEM', 'on' );
        erpname = [subject{s} 'M12_ar'];  % name for erpset menu
        fname_erp= fullfile(data_path, [erpname '.erp']);
        pop_savemyerp(ERP, 'erpname', erpname, 'filename', fname_erp, 'Warning', 'off'); 
        % RTs for ERPs (redundant with ar above?)
        % values = pop_rt2text(ERP, 'arfilter', 'on', 'eventlist',  1, 'filename', '/home/schendan/ERPDATA/Color/EEG-ANAL/S01/JUNKdetail.txt', 'header', 'on', 'listformat', 'itemized' );
        values = pop_rt2text(ERP, 'arfilter', 'on', 'eventlist',  1, 'filename', [data_path erpname '_erp_RT.txt'], 'header',' on', 'listformat', 'basic' );
        values = pop_rt2text(ERP, 'arfilter', 'on', 'eventlist',  1, 'filename', [data_path erpname '_erp_RTs.txt'], 'header', 'on', 'listformat', 'itemized' );
        % All Trials
        ERP = pop_averager( EEG , 'Criterion', 'all', 'ExcludeBoundary', 'on', 'SEM', 'on' );
        erpname = [subject{s} 'M12_all'];  % name for erpset menu
        fname_erp= fullfile(data_path, [erpname '.erp']);
        pop_savemyerp(ERP, 'erpname', erpname, 'filename', fname_erp, 'Warning', 'off'); 
        % Artifact Trials
        ERP = pop_averager( EEG , 'Criterion', 'bad', 'ExcludeBoundary', 'on', 'SEM', 'on' );
        erpname = [subject{s} 'M12_bad'];  % name for erpset menu
        fname_erp= fullfile(data_path, [erpname '.erp']);
        pop_savemyerp(ERP, 'erpname', erpname, 'filename', fname_erp, 'Warning', 'off'); 
        % Get Evoked spectra, Good trials, no artifacts
        ERP = pop_averager( EEG , 'Compute', 'EFFT', 'Criterion', 'good', 'ExcludeBoundary', 'on', 'SEM', 'on' );
        erpname = [subject{s} 'EFFT_M12_ar'];  % name for erpset menu
        fname_erp= fullfile(data_path, [erpname '.erp']);
        pop_savemyerp(ERP, 'erpname', erpname, 'filename', fname_erp, 'Warning', 'off');  
        % RTs
    end
end
    disp('ERP Averaging: DONE!')
end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% GRAND AVERAGE. Include standard deviation.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if gavg
% Stimulus-locked
    clear EEG;  % Clear is to make sure that we start fresh for each subject with the EEG and ERP structures
    clear ERP;  % Clear is to make sure that we start fresh for each subject with the EEG and ERP structures
    ERP = pop_gaverager( [pathname_cmd, 'erpfiles.txt'] , 'Criterion',  33, 'ExcludeNullBin', 'on', 'SEM', 'on' );
    erpname = [expname 'M12_gav'];
    fname_erp= fullfile(pathname_gav, [erpname '.erp']);  
    pop_savemyerp(ERP, 'erpname', erpname, 'filename', fname_erp, 'warning', 'off');
   % Filter gav
    ERP = pop_filterp( ERP, 1:71 , 'Cutoff', 30, 'Design', 'butter', 'Filter', 'lowpass', 'Order', 2 ); 
    erpname = [expname 'M12_gavLp30'];
    fname_erp= fullfile(pathname_gav, [erpname '.erp']);  
    pop_savemyerp(ERP, 'erpname', erpname, 'filename', fname_erp, 'warning', 'off'); 
end
end % SCRIPT WORKS UNTIL THIS END

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Measure ERPs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if meas
    disp('Measuring ERPs ...')
% Measure the mean amplitude in all bins at all channels
% Save the results in a variable named "values" and in a file in the Measurement folder for the experiment
    values = pop_geterpvalues( {'Loadlist', [pathname_cmd, 'erpfiles.txt']}, [ 95 115], [1:allbins], 1:64, 'Baseline', 'pre', 'Binlabel', 'on', 'FileFormat', 'long', 'Filename', [pathname_meas '95-115_All.txt'], 'Fracreplace', 'NaN', 'InterpFactor', 1, 'Measure', 'meanbl', 'Resolution',6, 'Warning', 'off' );
    values = pop_geterpvalues( {'Loadlist', [pathname_cmd, 'erpfiles.txt']}, [ 120 140], [1:allbins], 1:64, 'Baseline', 'pre', 'Binlabel', 'on', 'FileFormat', 'long', 'Filename', [pathname_meas '120-140_All.txt'], 'Fracreplace', 'NaN', 'InterpFactor', 1, 'Measure', 'meanbl', 'Resolution',6, 'Warning', 'off' );
    values = pop_geterpvalues( {'Loadlist', [pathname_cmd, 'erpfiles.txt']}, [ 145 160], [1:allbins], 1:64, 'Baseline', 'pre', 'Binlabel', 'on', 'FileFormat', 'long', 'Filename', [pathname_meas '145-160_All.txt'], 'Fracreplace', 'NaN', 'InterpFactor', 1, 'Measure', 'meanbl', 'Resolution',6, 'Warning', 'off' );
    values = pop_geterpvalues( {'Loadlist', [pathname_cmd, 'erpfiles.txt']}, [ 200 299], [1:allbins], 1:64, 'Baseline', 'pre', 'Binlabel', 'on', 'FileFormat', 'long', 'Filename', [pathname_meas '200-299_All.txt'], 'Fracreplace', 'NaN', 'InterpFactor', 1, 'Measure', 'meanbl', 'Resolution',6, 'Warning', 'off' );
    values = pop_geterpvalues( {'Loadlist', [pathname_cmd, 'erpfiles.txt']}, [ 300 399], [1:allbins], 1:64, 'Baseline', 'pre', 'Binlabel', 'on', 'FileFormat', 'long', 'Filename', [pathname_meas '300-399_All.txt'], 'Fracreplace', 'NaN', 'InterpFactor', 1, 'Measure', 'meanbl', 'Resolution',6, 'Warning', 'off' );
    values = pop_geterpvalues( {'Loadlist', [pathname_cmd, 'erpfiles.txt']}, [ 400 499], [1:allbins], 1:64, 'Baseline', 'pre', 'Binlabel', 'on', 'FileFormat', 'long', 'Filename', [pathname_meas '400-499_All.txt'], 'Fracreplace', 'NaN', 'InterpFactor', 1, 'Measure', 'meanbl', 'Resolution',6, 'Warning', 'off' );
    values = pop_geterpvalues( {'Loadlist', [pathname_cmd, 'erpfiles.txt']}, [ 500 699], [1:allbins], 1:64, 'Baseline', 'pre', 'Binlabel', 'on', 'FileFormat', 'long', 'Filename', [pathname_meas '500-699_All.txt'], 'Fracreplace', 'NaN', 'InterpFactor', 1, 'Measure', 'meanbl', 'Resolution',6, 'Warning', 'off' );
    values = pop_geterpvalues( {'Loadlist', [pathname_cmd, 'erpfiles.txt']}, [ 700 899], [1:allbins], 1:64, 'Baseline', 'pre', 'Binlabel', 'on', 'FileFormat', 'long', 'Filename', [pathname_meas '700-899_All.txt'], 'Fracreplace', 'NaN', 'InterpFactor', 1, 'Measure', 'meanbl', 'Resolution',6, 'Warning', 'off' );

    disp('Measured ERPs: DONE! ...')
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Basic Filtering for ERP with Low Pass Pg. 36
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if lp
    disp('ERP Filter: Working ...')
for s=1:nsubj
    data_path = [pathname_anal subject{s} '/'];  % Path to the folder containing the current subject's data
    sname = [data_path subject{s} 'M12_ERP.erp'];
    if exist(sname, 'file')>0               
        clear EEG;  % Clear is to make sure that we start fresh for each subject with the EEG and ERP structures
        clear ERP;  % Clear is to make sure that we start fresh for each subject with the EEG and ERP structures
        ERP = pop_loaderp({'filename', [subject{s} 'M12_ERP.erp'] }, 'filepath', data_path);
        EEG = pop_loadset('filename', [subject{s} '_cebM12eya.set'], 'filepath', data_path); 
        % Filtering. Channels = 1 to 16; No high-pass;
        % Lowpass cuttof at 30 Hz; Order of the filter = 2.
        % Type of filter = "Butterworth"; Not remove DC offset
        if ch64 % 64 channel
            ERP = pop_filterp( ERP,  1:71 , 'Cutoff',  30, 'Design', 'butter', 'Filter', 'lowpass', 'Order',  2 );
        else    % 32 channel
            ERP = pop_filterp( ERP,  1:39 , 'Cutoff',  30, 'Design', 'butter', 'Filter', 'lowpass', 'Order',  2 );
        end
        erpname = [subject{s} 'M12_arLp30'];  % name for erpset menu
        fname_erp= fullfile(data_path, [erpname '.erp']);
        pop_savemyerp(ERP, 'erpname', erpname, 'filename', fname_erp, 'Warning', 'off'); 
    else
            fprintf('\n *** WARNING: %s does not exist *** \n\n', sname);
    end
end
disp('Filtered ERPs: DONE! ...')
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BELOW NOT IMPLEMENTED
% TO DO: RTlock, CAR ref versions, 64 vs. 32 chan, delete eye chans, long vs. wide meas
% option. filter cut off enter parameters.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% AVERAGING 
% RT locked 1
xRTlock = 0;
if xRTlock
for s=1:nsubj
    clear EEG;  % Clear is to make sure that we start fresh for each subject with the EEG and ERP structures
    clear ERP;  % Clear is to make sure that we start fresh for each subject with the EEG and ERP structures
    sname = [data_path subject{s} '_e_bRTlock_be1EOG_M12.set'];       
    if exist(sname, 'file')>0               
            EEG = pop_loadset('filename', [subject{s} '_e_bRTlock_be1EOG_M12.set'], 'filepath', data_path);                
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
            EEG = pop_saveset(EEG, 'filename', [subject{s} '_e_bRTlock_be1EOG_M12_ar.set'], 'filepath', data_path);
            EEG = pop_exporteegeventlist(EEG, [subject{s} '_EEG_ar.txt']);
            pop_summary_AR_eeg_detection(EEG, [data_path, subject{s} 'RTlock1_EEG_tab_ar.txt']);  % Save ar Table
            ERP = pop_averager( EEG, 'Criterion', 'good', 'Stdev', 'on');
            erpname = [subject{s} 'RTlock1_M12_ar'];  % name for erpset menu
            fname_erp= fullfile(data_path, [erpname '.erp']);
            pop_savemyerp(ERP, 'erpname', erpname, 'filename', fname_erp, 'warning', 'off');  

    else
            fprintf('\n *** WARNING: %s does not exist *** \n\n', sname);
    end
disp('Artifact rejection & artifact-free average RTlock1: DONE! ...')
end


% RT locked 2
for s=1:nsubj
clear EEG;  % Clear is to make sure that we start fresh for each subject with the EEG and ERP structures
clear ERP;  % Clear is to make sure that we start fresh for each subject with the EEG and ERP structures
    sname = [data_path subject{s} '_e_bRTlock_be2EOG_M12.set'];       
    if exist(sname, 'file')>0               
            EEG = pop_loadset('filename', [subject{s} '_e_bRTlock_be2EOG_M12.set'], 'filepath', data_path);                
%TO DO: Detect artifacts for current dataset. Adjust parameter values after EEG in function
% Artifact detection notes: 
% BLINK & HEOG: Step-like. Test window = [-100 898] ms; Threshold = TODO uV; Window width = 400 ms (use default or TODO); Window step = 10 ms; Channels = 65 (Blink); Flags to be activated = 1 & 3

EEG = pop_artextval( EEG, 'Channel', 1:64, 'Flag', [ 1 2], 'Review', 'off', 'Threshold', [ artparmRT(s,1) artparmRT(s,2)], 'Twindow', [-300 200]); %Voltage threshold
EEG = pop_artstep( EEG , 'Channel',  71, 'Flag', [ 1 3], 'Review', 'off', 'Threshold',  artparmRT(s,3), 'Twindow', [ -300 200], 'Windowsize',  artparmRT(s,4), 'Windowstep',  artparmRT(s,5) ); % step-like artifacts VEOG
EEG = pop_artstep( EEG , 'Channel',  70, 'Flag', [ 1 4], 'Review', 'off', 'Threshold',  artparmRT(s,6), 'Twindow', [ -300 200], 'Windowsize',  artparmRT(s,7), 'Windowstep',  artparmRT(s,8) ); % step-like artifacts HEOG
EEG = pop_artstep( EEG , 'Channel',  1:64, 'Flag', [ 1 5], 'Review', 'off', 'Threshold',  artparmRT(s,9), 'Twindow', [ -300 200], 'Windowsize',  artparmRT(s,10), 'Windowstep',  artparmRT(s,11) ); % step-like artifacts other chans
EEG = pop_artmwppth( EEG , 'Channel',  1:64, 'Flag', [ 1 6], 'Review', 'off', 'Threshold',  artparmRT(s,12), 'Twindow', [ -300 200], 'Windowsize',  artparmRT(s,13), 'Windowstep',  artparmRT(s,14) ); % P2P ALL
EEG = pop_artmwppth( EEG , 'Channel',  71, 'Flag', [ 1 7], 'Review', 'off', 'Threshold',  artparmRT(s,15), 'Twindow', [ -300 200], 'Windowsize',  artparmRT(s,16), 'Windowstep',  artparmRT(s,17) ); % P2P VOG           
EEG = pop_artdiff( EEG , 'Channel',  1:64, 'Flag', [ 1 8], 'Review', 'off', 'Threshold',  artparmRT(s,18), 'Twindow', [ -300 200] ); %Extreme spikiness                              

            EEG.setname= [subject{s} '_e_bRTlock_be2EOG_M12_ar.set'];
            EEG = pop_saveset(EEG, 'filename', [subject{s} '_e_bRTlock_be2EOG_M12_ar.set'], 'filepath', data_path);
            EEG = pop_exporteegeventlist(EEG, [subject{s} '_EEG_ar.txt']);
            pop_summary_AR_eeg_detection(EEG, [data_path, subject{s} 'RTlock2_EEG_tab_ar.txt']);  % Save ar Table
            ERP = pop_averager( EEG, 'Criterion', 'good', 'Stdev', 'on');
            erpname = [subject{s} 'RTlock2_M12_ar'];  % name for erpset menu
            fname_erp= fullfile(data_path, [erpname '.erp']);
            pop_savemyerp(ERP, 'erpname', erpname, 'filename', fname_erp, 'warning', 'off');  

    else
            fprintf('\n *** WARNING: %s does not exist *** \n\n', sname);
    end
disp('Artifact rejection & artifact-free average RTlock2: DONE! ...')
end
end

xRTlock = 0;
if xRTlock    
% average    
for s=1:nsubj
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


% START HERE: MODIFY FOR RTLOCK 1 AND 2 AND ADD LRP
if bo
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Bin Operations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Perform Bin Operations ...')
%binop = {'ny-test-binop.txt' 'ny-test-binop.txt' 'yn-test-binop.txt' 'ny-test-binop.txt'};
binop = {'ny-test-binop.txt' 'ny-test-binop.txt' 'ny-test-binop.txt' ...
'ny-test-binop.txt' 'ny-test-binop.txt' 'ny-test-binop.txt'...
'yn-test-binop.txt' 'yn-test-binop.txt' 'yn-test-binop.txt'...
'yn-test-binop.txt' 'yn-test-binop.txt' 'yn-test-binop.txt' ...
'ny-test-binop.txt' 'ny-test-binop.txt' 'ny-test-binop.txt' ...
'ny-test-binop.txt' 'ny-test-binop.txt' 'ny-test-binop.txt'...
'yn-test-binop.txt' 'yn-test-binop.txt' 'yn-test-binop.txt' ...
'yn-test-binop.txt' 'yn-test-binop.txt' 'yn-test-binop.txt'};
%boRTlock = {'ny-test-RTlock-binop.txt' 'ny-test-RTlock-binop.txt' 'yn-test-RTlock-binop.txt' 'ny-test-RTlock-binop.txt'};
boRTlock = {'ny-test-RTlock-binop.txt' 'ny-test-RTlock-binop.txt' 'ny-test-RTlock-binop.txt' ...
'ny-test-RTlock-binop.txt' 'ny-test-RTlock-binop.txt' 'ny-test-RTlock-binop.txt'...
'yn-test-RTlock-binop.txt' 'yn-test-RTlock-binop.txt' 'yn-test-RTlock-binop.txt'...
'yn-test-RTlock-binop.txt' 'yn-test-RTlock-binop.txt' 'yn-test-RTlock-binop.txt'...
'ny-test-RTlock-binop.txt' 'ny-test-RTlock-binop.txt' 'ny-test-RTlock-binop.txt' ...
'ny-test-RTlock-binop.txt' 'ny-test-RTlock-binop.txt' 'ny-test-RTlock-binop.txt'...
'yn-test-RTlock-binop.txt' 'yn-test-RTlock-binop.txt' 'yn-test-RTlock-binop.txt' ...
'yn-test-RTlock-binop.txt' 'yn-test-RTlock-binop.txt' 'yn-test-RTlock-binop.txt'};

%lrp = {'ny-test-binopLRP.txt' 'ny-test-binopLRP.txt' 'yn-test-binopLRP.txt' 'ny-test-binopLRP.txt'};
lrp = {'ny-test-binopLRP.txt' 'ny-test-binopLRP.txt' 'ny-test-binopLRP.txt' ...
'ny-test-binopLRP.txt' 'ny-test-binopLRP.txt' 'ny-test-binopLRP.txt'...
'yn-test-binopLRP.txt' 'yn-test-binopLRP.txt' 'yn-test-binopLRP.txt'...
'yn-test-binopLRP.txt' 'yn-test-binopLRP.txt' 'yn-test-binopLRP.txt'...
'ny-test-binopLRP.txt' 'ny-test-binopLRP.txt' 'ny-test-binopLRP.txt' ...
'ny-test-binopLRP.txt' 'ny-test-binopLRP.txt' 'ny-test-binopLRP.txt'...
'yn-test-binopLRP.txt' 'yn-test-binopLRP.txt' 'yn-test-binopLRP.txt' ...
'yn-test-binopLRP.txt' 'yn-test-binopLRP.txt' 'yn-test-binopLRP.txt'};
%lrpRTlock = {'ny-test-RTlock-binopLRP.txt' 'ny-test-RTlock-binopLRP.txt' 'yn-test-RTlock-binopLRP.txt' 'ny-test-RTlock-binopLRP.txt'};
lrpRTlock = {'ny-test-RTlock-binopLRP.txt' 'ny-test-RTlock-binopLRP.txt' 'ny-test-RTlock-binopLRP.txt' ...
'ny-test-RTlock-binopLRP.txt' 'ny-test-RTlock-binopLRP.txt' 'ny-test-RTlock-binopLRP.txt'...
'yn-test-RTlock-binopLRP.txt' 'yn-test-RTlock-binopLRP.txt' 'yn-test-RTlock-binopLRP.txt'...
'yn-test-RTlock-binopLRP.txt' 'yn-test-RTlock-binopLRP.txt' 'yn-test-RTlock-binopLRP.txt'...
'ny-test-RTlock-binopLRP.txt' 'ny-test-RTlock-binopLRP.txt' 'ny-test-RTlock-binopLRP.txt' ...
'ny-test-RTlock-binopLRP.txt' 'ny-test-RTlock-binopLRP.txt' 'ny-test-RTlock-binopLRP.txt'...
'yn-test-RTlock-binopLRP.txt' 'yn-test-RTlock-binopLRP.txt' 'yn-test-RTlock-binopLRP.txt' ...
'yn-test-RTlock-binopLRP.txt' 'yn-test-RTlock-binopLRP.txt' 'yn-test-RTlock-binopLRP.txt'};
for s=1:nsubj
clear EEG;  % Clear is to make sure that we start fresh for each subject with the EEG and ERP structures
clear ERP;  % Clear is to make sure that we start fresh for each subject with the EEG and ERP structures
    sname = [data_path subject{s} 'M12_ar.erp'];        
    if exist(sname, 'file')>0  
% Stimulus-locked
            %
            % Load erpset
            %
            ERP = pop_loaderp('filename', [subject{s} 'M12_ar.erp'], 'filepath', data_path, 'Multiload', 'off', 'overwrite', 'off', 'Warning', 'on' );

            % bin operations
            ERP = pop_binoperator( ERP, [pathname_cmd binop{s}]); 

            % Save dataset as
            erpname = [subject{s} 'M12_ar_bo'];  % name for erpset menu
            fname_erp= fullfile(data_path, [erpname '.erp']);  
            pop_savemyerp(ERP, 'erpname', erpname, 'filename', fname_erp, 'warning', 'off'); 

            % LRP
            %clear ERP;  % Clear is to make sure that we start fresh for each subject with the EEG and ERP structures
            %ERP = pop_loaderp('filename', [subject{s} 'M12_ar_bo.erp'], 'filepath', data_path, 'Multiload', 'off', 'overwrite', 'off', 'Warning', 'on' );
            ERP = pop_binoperator( ERP, [pathname_cmd lrp{s}]); 
            % Save dataset as
            erpname = [subject{s} 'M12_ar_boLRP'];  % name for erpset menu
            fname_erp= fullfile(data_path, [erpname '.erp']);  
            pop_savemyerp(ERP, 'erpname', erpname, 'filename', fname_erp, 'warning', 'off'); 

% Response-locked 1
clear ERP;  % Clear is to make sure that we start fresh for each subject with the EEG and ERP structures
            %
            % Load erpset
            %
            ERP = pop_loaderp('filename', [subject{s} 'RTlock1_M12_ar.erp'], 'filepath', data_path, 'Multiload', 'off', 'overwrite', 'off', 'Warning', 'on' );

            % bin operations
            ERP = pop_binoperator( ERP, [pathname_cmd boRTlock{s}]); 

            % Save dataset as
            erpname = [subject{s} 'RTlock1_M12_ar_bo'];  % name for erpset menu
            fname_erp= fullfile(data_path, [erpname '.erp']);  
            pop_savemyerp(ERP, 'erpname', erpname, 'filename', fname_erp, 'warning', 'off'); 

            % LRP
            %clear ERP;  % Clear is to make sure that we start fresh for each subject with the EEG and ERP structures
            %ERP = pop_loaderp('filename', [subject{s} 'M12_ar_bo.erp'], 'filepath', data_path, 'Multiload', 'off', 'overwrite', 'off', 'Warning', 'on' );
            ERP = pop_binoperator( ERP, [pathname_cmd lrpRTlock{s}]); 
            % Save dataset as
            erpname = [subject{s} 'RTlock1_M12_ar_boLRP'];  % name for erpset menu
            fname_erp= fullfile(data_path, [erpname '.erp']);  
            pop_savemyerp(ERP, 'erpname', erpname, 'filename', fname_erp, 'warning', 'off'); 

% Response-locked 2
clear ERP;  % Clear is to make sure that we start fresh for each subject with the EEG and ERP structures
            %
            % Load erpset
            %
            ERP = pop_loaderp('filename', [subject{s} 'RTlock2_M12_ar.erp'], 'filepath', data_path, 'Multiload', 'off', 'overwrite', 'off', 'Warning', 'on' );

            % bin operations
            ERP = pop_binoperator( ERP, [pathname_cmd boRTlock{s}]); 

            % Save dataset as
            erpname = [subject{s} 'RTlock2_M12_ar_bo'];  % name for erpset menu
            fname_erp= fullfile(data_path, [erpname '.erp']);  
            pop_savemyerp(ERP, 'erpname', erpname, 'filename', fname_erp, 'warning', 'off'); 

            % LRP
            %clear ERP;  % Clear is to make sure that we start fresh for each subject with the EEG and ERP structures
            %ERP = pop_loaderp('filename', [subject{s} 'M12_ar_bo.erp'], 'filepath', data_path, 'Multiload', 'off', 'overwrite', 'off', 'Warning', 'on' );
            ERP = pop_binoperator( ERP, [pathname_cmd lrpRTlock{s}]); 
            % Save dataset as
            erpname = [subject{s} 'RTlock2_M12_ar_boLRP'];  % name for erpset menu
            fname_erp= fullfile(data_path, [erpname '.erp']);  
            pop_savemyerp(ERP, 'erpname', erpname, 'filename', fname_erp, 'warning', 'off');                    


%    ERP = pop_binoperator( ERP, pathname_cmd 'inny-test-binop_RHLH.txt');                                                                          
%ERP = pop_savemyerp(ERP, 'erpname', '011finny-testM12_ERP_ar1', 'filename', '011finny-testM12_ERP_ar1M12 (copy).erp', 'filepath', '/home/schendan/ERPDATA/UNTASK/ERPLab');

    else
            fprintf('\n *** WARNING: %s does not exist *** \n\n', sname);
    end
end

disp('Created Bin Operated ERP & LRP sets: DONE! ...')

end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% GRAND AVERAGE. Include standard deviation.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if xRTlock
                %erpname = [subject{s} 'M12_ar_bo'];  % name for erpset menu

% Stimulus-locked
%    clear EEG;  % Clear is to make sure that we start fresh for each subject with the EEG and ERP structures
clear ERP;  % Clear is to make sure that we start fresh for each subject with the EEG and ERP structures
ERP = pop_gaverager('Loadlist', [pathname_cmd, 'erpfiles.txt'] , 'Criterion',  33, 'ExcludeNullBin', 'on', 'SEM', 'on' );
%ERP = pop_gaverager( '/home/schendan/ERPDATA/Color/EEG-ANAL/CMD/erpfiles.txt' , 'Criterion',  33, 'ExcludeNullBin', 'on', 'SEM',... 'on' );
%ERP = pop_savemyerp(ERP, 'erpname', 'gav', 'filename', 'gav.erp', 'filepath', '/home/schendan/ERPDATA/Color/EEG-ANAL', 'Warning',... 'on');

%ERP = pop_gaverager( 'ERPindex', 'Loadlist', [pathname_gav, 'erpfiles.txt'], 'Stdev', 'on', 'Warning', 'off' );
%            erpname = 'UnTaskM12_gav'; 
            pop_savemyerp(ERP, 'erpname', erpname, 'filename', fname_erp, 'warning', 'off')
%pop_savemyerp(ERP, 'erpname', 'UnTaskM12_ar_gav', 'filename', [erpname, '.erp'], 'filepath', pathname_gav, 'warning', 'off');
%FILTER GRAND AVERAGE
%ERP = pop_filterp( ERP,1:71 , 'Cutoff',30, 'Design', 'butter', 'Filter', 'lowpass', 'Order',2 ); 
 %           erpname = 'UnTaskM12_gav_lp30Hz';  % name for erpset menu
  %          fname_erp= fullfile(pathname_gav, [erpname '.erp']);  
   %         pop_savemyerp(ERP, 'erpname', erpname, 'filename', fname_erp, 'warning', 'off'); 
% LRP
clear ERP;  % Clear is to make sure that we start fresh for each subject with the EEG and ERP structures
ERP = pop_gaverager('ERPindex', 'Loadlist', [pathname_gav, 'lrpfiles.txt'], 'Stdev', 'on', 'Warning', 'off' );
            erpname = 'UnTaskM12_LRP_gav'; 
            fname_erp= fullfile(pathname_gav, [erpname '.erp']);  
            pop_savemyerp(ERP, 'erpname', erpname, 'filename', fname_erp, 'warning', 'off')
%FILTER GRAND AVERAGE LRP
ERP = pop_filterp( ERP,1:27 , 'Cutoff',30, 'Design', 'butter', 'Filter', 'lowpass', 'Order',2 ); 
            erpname = 'UnTaskM12_LRP_gav_lp30'; 
            fname_erp= fullfile(pathname_gav, [erpname '.erp']);  
            pop_savemyerp(ERP, 'erpname', erpname, 'filename', fname_erp, 'warning', 'off')


% RT-locked 1
%    clear EEG;  % Clear is to make sure that we start fresh for each subject with the EEG and ERP structures
clear ERP;  % Clear is to make sure that we start fresh for each subject with the EEG and ERP structures
ERP = pop_gaverager( 'ERPindex', 'Loadlist', [pathname_gav, 'erpfilesRTlock1.txt'], 'Stdev', 'on', 'Warning', 'off' );
            erpname = 'UnTaskM12RTlock1_gav'; 
            fname_erp= fullfile(pathname_gav, [erpname '.erp']);  
            pop_savemyerp(ERP, 'erpname', erpname, 'filename', fname_erp, 'warning', 'off')
%FILTER GRAND AVERAGE
ERP = pop_filterp( ERP, 1:71, 'Cutoff',30, 'Design', 'butter', 'Filter', 'lowpass', 'Order',2 );
            erpname = 'UnTaskM12RTlock1_gav_lp30Hz';  % name for erpset menu
            fname_erp= fullfile(pathname_gav, [erpname '.erp']);  
            pop_savemyerp(ERP, 'erpname', erpname, 'filename', fname_erp, 'warning', 'off'); 
% LRP
clear ERP;  % Clear is to make sure that we start fresh for each subject with the EEG and ERP structures
ERP = pop_gaverager('ERPindex', 'Loadlist', [pathname_gav, 'lrpfilesRTlock1.txt'], 'Stdev', 'on', 'Warning', 'off' );
            erpname = 'UnTaskM12RTlock1_gavLRP'; 
            fname_erp= fullfile(pathname_gav, [erpname '.erp']);  
            pop_savemyerp(ERP, 'erpname', erpname, 'filename', fname_erp, 'warning', 'off')
%FILTER GRAND AVERAGE LRP
ERP = pop_filterp( ERP, 1:27, 'Cutoff',30, 'Design', 'butter', 'Filter', 'lowpass', 'Order',2 );
            erpname = 'UnTaskM12RTlock1_gavLRP_lp30'; 
            fname_erp= fullfile(pathname_gav, [erpname '.erp']);  
            pop_savemyerp(ERP, 'erpname', erpname, 'filename', fname_erp, 'warning', 'off')          

% RT-locked 2
%    clear EEG;  % Clear is to make sure that we start fresh for each subject with the EEG and ERP structures
clear ERP;  % Clear is to make sure that we start fresh for each subject with the EEG and ERP structures
ERP = pop_gaverager( 'ERPindex', 'Loadlist', [pathname_gav, 'erpfilesRTlock2.txt'], 'Stdev', 'on', 'Warning', 'off' );
            erpname = 'UnTaskM12RTlock2_gav'; 
            fname_erp= fullfile(pathname_gav, [erpname '.erp']);  
            pop_savemyerp(ERP, 'erpname', erpname, 'filename', fname_erp, 'warning', 'off')
%FILTER GRAND AVERAGE
ERP = pop_filterp( ERP, 1:71, 'Cutoff',30, 'Design', 'butter', 'Filter', 'lowpass', 'Order',2 );
            erpname = 'UnTaskM12RTlock2_gav_lp30Hz';  % name for erpset menu
            fname_erp= fullfile(pathname_gav, [erpname '.erp']);  
            pop_savemyerp(ERP, 'erpname', erpname, 'filename', fname_erp, 'warning', 'off'); 
% LRP
clear ERP;  % Clear is to make sure that we start fresh for each subject with the EEG and ERP structures
ERP = pop_gaverager('ERPindex', 'Loadlist', [pathname_gav, 'lrpfilesRTlock2.txt'], 'Stdev', 'on', 'Warning', 'off' );
            erpname = 'UnTaskM12RTlock2_gavLRP'; 
            fname_erp= fullfile(pathname_gav, [erpname '.erp']);  
            pop_savemyerp(ERP, 'erpname', erpname, 'filename', fname_erp, 'warning', 'off')
%FILTER GRAND AVERAGE LRP
ERP = pop_filterp( ERP, 1:27, 'Cutoff',30, 'Design', 'butter', 'Filter', 'lowpass', 'Order',2 );
            erpname = 'UnTaskM12RTlock2_gavLRP_lp30'; 
            fname_erp= fullfile(pathname_gav, [erpname '.erp']);  
            pop_savemyerp(ERP, 'erpname', erpname, 'filename', fname_erp, 'warning', 'off')
end
    



%%%%%% UNUSED %%%%%%







%else
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RUN MULTIPLE STEPS WITHOUT LOADING AND SAVING: COPY LUCA'S SCRIPT HERE
% and add flag if statements (basically as below but without load and save.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Set the save_everything variable to 1 to save all of the intermediate files to the hard drive
% Set to save_everything variable to 0 to save only the initial and final dataset and ERPset for each subject
% Only when not running modular/load each step


%end                    % if using save_everything



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TO DO: Parms file with all options and flags, as well as garv parameters.
% Revise to read parms file and use variables for each parm at each step.
% Add channel interpolation
% Add ICA before GARV
% Add EEGLab artifact detection functions
