%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% * CHANGE * FLAGS for each experiment
% SELECT FLAGS, as needed for each phase of analysis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function std_flags

global expname pathname_all pathname_raw Windows Linux 
global save_everything mod ch64 copydata ca m12 CA M12 lrp binlisb
global os_paraset import chanloc elist binlis eegrefch epoch addeye artif artif_all avg erprefch gavg meas
global allbins file1 file2 file3 set 
                      
expname = 'std11'; % Modify for your experiment: Your experiment name here, e.g., color, vishape, untask
pathname_all = 'C:\Users\pzhao\Documents\MATLAB\standard11\'; %% Modify for your experiment: where parent folder is 
pathname_raw = 'C:\Users\pzhao\Documents\MATLAB\ColorRawData\'; % where raw bdf is

allbins = 174;  %Modify for your experiment: total # bins in bin descriptor file (bdf.txt command file). Default for color expt = 174
file1 = 'biosemi64xyz10-20.xyz'; % Modify for your experiment: Choose 64 or 32 channel location file
file2 = 'garvparm.txt'; % Modify for your experiment 
file3 = 'erpfiles.txt'; % Modify for your experiment: subject .erp files for grand average gavg

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
os_paraset = 1;  %This only need to run once
import = 1;      %This only need run once
copydata = 0;    % % Default flag is 0. optional to copy the raw data into a seperate folder

% ERPLab Function Flags in sequence
elist = 1;       % EventList
binlis = 1;     % Binlister
chanloc = 1;     % Add channel locations
epoch = 1;       % BinEpoch
addeye = 1;      % Add eye channels
artif = 1;       % Artifact Detection for each subject: GARV = Get Artifact Rejection Values. 

                 %********************** Stage 2 *********************%
                 %      set clr = 0 in 'MAIN.m';                      %
                 %      modify the artif_S.. for each subject;        %
                 %      change the flags at stage 1 equal to 0;       %
                 %      change the flags at stage 2 equal to 1;       %
                 %      then run MAIN.m again;                        %
                 %****************************************************%

artif_all = 1;   % after modify artif.m for each subject, mark artifacts for all subjects and create 3 ERP averages (ar, all, bad)

% Default flag must be 0 for eegrefch in standard processing order. 
eegrefch = 0;    % Default flag = 0; Define reference channel for EEGLab analysis of biosemi data, default M12, option CAR
m12 = 0;         % for average mastoids reference (for EEGs); Default
ca = 0;          % common average reference, in addition to standard mastoid reference (for EEGs); 

avg = 1;         % Default flag must be 1 at second stage; NOTE: should be done also in artif to assess ERPs

% Default flag must be 1 for erpreref in standard processing order. 
erprefch = 1;    % default M12, option CAR.
M12 = 1;         % for average mastoids reference (for ERPs); Default
CA = 0;          % for common average reference (for ERPs); 

meas = 1;        % 
gavg = 1;        % input required in CMD: 1 column list of subject .erp files with pathname in erpfiles.txt

set = '.set';

fprintf('\n+++++++++++++++\n+ Setup Global and ERPLab Function Flags: done! ... \n+++++++++++++++\n\n');
