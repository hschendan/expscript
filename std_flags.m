
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% * CHANGE * FLAGS for each experiment
% SELECT FLAGS, as needed for each phase of analysis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function std_flags

global expname pathname_all pathname_raw Windows Linux 
global save_everything mod ch64 copydata ca m12 CA M12 lrp binlisb erpfiles
global os_paraset import chanloc elist binlis eegrefch epoch addeye artif artif_all artif_one one all avg erprefch gavg meas
global allbins file1 file2 file3 set 
global n % STAGE 2 ONE
                      
expname = 'std11'; % Modify for your experiment: Your experiment name here, e.g., color, vishape, untask
pathname_all = 'C:\Users\pzhao\Documents\MATLAB\standard11\'; %% Modify for your experiment: where parent folder is 
pathname_raw = 'C:\Users\pzhao\Documents\MATLAB\ColorRawData\'; % where raw bdf is

allbins = 174;  %Modify for your experiment: total # bins in bin descriptor file (bdf.txt command file). Default for color expt = 174
file1 = 'biosemi64xyz10-20.xyz'; % Modify for your experiment: Choose 64 or 32 channel location file
file2 = 'garvparm.txt'; % Modify for your experiment 
file3 = 'erpfiles.txt'; % Modify for your experiment: subject .erp files for grand average gavg
set = '.set';

%Flags for choosing operating systems
Windows = 1; 
Linux = 0;

% Global flags determine how script runs
save_everything  = 0;   % Only used when NOT running modular; NOT IMPLEMENTED
mod = 0;         % Run MODULAR, load and save each step; NOT IMPLEMENTED
ch64 = 1;        % 64 channel, else 32 channel; NOT IMPLEMENTED


lrp = 0;         % not implemented % Use for Lateralized Readiness Potential (LRP)
binlisb = 1;     % default is 1; binlister option: Use bin # to label epochs, transfer to EEG structure checked; otherwise no transfer

                 %*****************************%
                 %          Stage 1            %
                 %  set 'clr' = 1 in 'MAIN.m'  %
                 %*****************************%
                 
      %*if run the following functions not in one go, need to set 'clr' = 0 after the first batch of functions.
              
% Preparation stage
erpfiles = 0;    % This only need run once: default = 0; when run os_paraset, create erpfiles.txt with all .erp filenames for input to gavg and meas; set to 0 if you manually modify erpfiles.txt or will over-write your erpfiles.txt
os_paraset = 1;  %This need always be 1
import = 0;      %This only need run once
copydata = 0;    % % Default flag is 0. optional to copy the raw data into a seperate folder

% ERPLab Function Flags in sequence
elist = 0;       % EventList
binlis = 0;     % Binlister
chanloc = 0;     % Add channel locations
epoch = 0;       % BinEpoch
addeye = 0;      % Add eye channels
artif = 0;       % Artifact Detection for each subject: GARV = Get Artifact Rejection Values. 

                 %********************** Stage 2 *********************%
                 %      set clr = 0 in 'MAIN.m';                      %
                 %      modify the artif_S.. for each subject;        %
		 %      keep os_paraset = 1 at all time;              %
                 %      change the flags at stage 1 equal to 0;       %
                 %      change the flags at stage 2 equal to 1;       %
                 %      then run MAIN.m again for singla subject      %
                 %****************************************************%
% MUST set either all or one to 1 when running stage 2 in order to avg or reref
all = 0;    % Use with artif_all; this is for all subjects in eegrefch, avg, erprefch
one = 1;    % Use with artif_one; this is for single subject in eegrefch, avg, erprefch
n=20; %modify here for the ONE subject you want % UNIVERSAL ONE

% To GARV and detect artifacts: Either run artif_all or artif_one but not both (never set both to 1).
% Once no more GARV to do, set both to 0.
artif_all = 0;   % (optional) after modify artif.m for each subject, mark artifacts for all subjects; set flag for all below to 1, if you want to avg or re-reference
artif_one = 1;   % run single subject; set flag for one below to 1, if you want to avg or re-reference

% Default flag must be 0 for eegrefch in standard processing order. 
eegrefch = 0;    % Define reference channel for EEGLab analysis of biosemi data, default M12, option CAR
m12 = 1;         % for average mastoids reference (for EEGs); Default
ca = 0;          % common average reference, in addition to standard mastoid reference (for EEGs); 

avg = 0;         % avg EEG to create .erp file; creates 4 ERP averages (ar, all, bad, and ar with extra info)

% When ready to re-reference: Default flag must be 1 for erpreref in standard processing order. 
erprefch = 1;    % default M12, option CAR.
M12 = 1;         % for average mastoids reference (for ERPs); Default
CA = 0;          % for common average reference (for ERPs); 

meas = 0;        % 
gavg = 0;        % input required in CMD: 1 column list of subject .erp files with pathname in erpfiles.txt

fprintf('\n+++++++++++++++\n+ Setup Global and ERPLab Function Flags: done! ... \n+++++++++++++++\n\n');
