%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% * CHANGE * FLAGS for each experiment
% SELECT FLAGS, as needed for each phase of analysis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function std_flags

global expname pathname_all Windows Linux 
global save_everything mod ch64 CAR lrp binlisb
global os paraset import chanloc elist binlis eegrefch epoch addeye artif artif_all avg erprefch gavg meas
global allbins file1 file2 file3 set 
                      
expname = 'std9';
pathname_all = 'C:\Users\pzhao\Documents\MATLAB\standard9\'; % where parent folder is 

%Flags for choosing operating systems
Windows = 1; 
Linux = 0;

% Global flags determine how script runs
save_everything  = 0;   % Only used when NOT running modular
mod = 1;         % Run MODULAR, load and save each step
ch64 = 1;        % 64 channel, else 32 channel
binlisb = 0;     % default is 0; binlister option: Use bin # to label epochs, transfer to EEG structure checked; otherwise no transfer
CAR = 0;         % Common average reference, in addition to standard mastoid reference
lrp = 0;         % not implemented % Use for Lateralized Readiness Potential (LRP)
                  
                        %***********%
                        %* Stage 1 *%
                        %***********%
                        
os = 1;        %This only need run once
paraset = 1;   %This only need run once

% ERPLab Function Flags in sequence
import = 1;      %This only need run once
elist = 1;       % EventList
binlis =  1;     % Binlister
chanloc = 1;     % Add channel locations
epoch = 1;       % BinEpoch
addeye = 1;      % Add eye channels
artif = 1;       % Artifact Detection 

                %********************** Stage 2 *********************%
                %      please set clear = 0;
                %      modify the artif_S.. for each subject;
                %      change the flags at stage 1 equal to 0;
                %      change the flags at stage 2 equal to 1;
                %      then run MAIN.m again;
                %****************************************************%

artif_all = 1;   % after modify for each subjects, run them all
eegrefch = 1;    % Define reference channel for biosemi data, default M12, option CAR
avg = 1;         % NOT implemented separately
erprefch = 1;
meas = 1;        % 
gavg = 1;        % input required in CMD: 1 column list of subject .erp files with pathname in erpfiles.txt


%Other global para
allbins = 174; % Modify for your experiment: total # bins in bin descriptor file (bdf.txt command file). Default for color expt = 174
file1 = 'biosemi64xyz10-20.xyz';
file2 = 'garvparm.txt';
file3 = 'erpfiles.txt';


set = '.set';

fprintf('\n+++++++++++++++\n+ Setup Global and ERPLab Function Flags: done! ... \n+++++++++++++++\n\n');
