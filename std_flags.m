%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% * CHANGE * FLAGS for each experiment
% SELECT FLAGS, as needed for each phase of analysis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function std_flags

global expname Windows Linux 
global save_everything mod ch64 lrp binlisb
global os paraset import chanloc elist binlis eegrefch epoch addeye artif artif_all avg gavg meas
global allbins file1 file2 file3 set
%global erprefch

                        
expname = 'std8';

%Flags for choosing operating systems
Windows = 1; 
Linux = 0;

% Global flags determine how script runs
save_everything  = 0;   % Only used when NOT running modular
mod = 1;         % Run MODULAR, load and save each step
ch64 = 1;        % 64 channel, else 32 channel
lrp = 0;         %not implemented % Use for Lateralized Readiness Potential (LRP)
binlisb = 0;     % default is 1; binlister option: Use bin # to label epochs, transfer to EEG structure checked
                  
                        %***********%
                        %* Stage 1 *%
                        %***********%
                        
os = 0;        %This only need run once
paraset = 0;   %This only need run once

% ERPLab Function Flags in sequence
import = 0;      %This only need run once
elist = 0;       % EventList
binlis =  0;     % Binlister
chanloc = 0;     % Add channel locations
epoch = 0;       % BinEpoch
addeye = 0;      % Add eye channels
artif = 0;       % Artifact Detection 

                %********************** Stage 2 *********************%
                %      please set clear = 0;
                %      modify the artif_S.. for each subject;
                %      change the flags at stage 1 equal to 0;
                %      change the flags afterwards equal to 1;
                %      then run MAIN.m again;
                %****************************************************%

artif_all = 1;   % after modify for each subjects, run them all
eegrefch = 1;    % Define reference channel for biosemi data, default M12, option CAR
avg = 1;         % NOT implemented separately
%erprefch = 1;
meas = 1;        % 
gavg = 1;        % input required in CMD: 1 column list of subject .erp files with pathname in erpfiles.txt


%Other global para
allbins = 174; % color 174
file1 = 'biosemi64xyz10-20.xyz';
file2 = 'garvparm.txt';
file3 = 'erpfiles.txt';
%pathname_write = ??
%impexpsubject20 = ??

set = '.set';

fprintf('\n+++++++++++++++\n+ Setup Global and ERPLab Function Flags: done! ... \n+++++++++++++++\n\n');