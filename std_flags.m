%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% * CHANGE * FLAGS for each experiment
% SELECT FLAGS, as needed for each phase of analysis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function std_flags

global expname Windows Linux
global save_everything mod ch64 CAR RTlock lrp binlisb xRTlock1 xRTlock2 xRTlock3 xRTlock4
global import chanloc elist binlis refch epoch addeye artif artif_all avg gavg meas lp bo
global allbins file1 file2 file3
%global pathname_write impexpsubject20

expname = 'std';

%Flags for choosing operating systems
Windows = 1; 
Linux = 0;

% Global flags determine how script runs
save_everything  = 0; % Only used when NOT running modular
mod = 1; % Run MODULAR, load and save each step
ch64 = 1; % 64 channel, else 32 channel
CAR = 1;    % In addition  to mean mastoid reference M12, also create CAR ref
RTlock = 0; % default 0; not implemented for refch and from addeye onwards % run parts for response locked ERPs, needed for LRP
lrp = 0; %not implemented % Use for Lateralized Readiness Potential (LRP)
binlisb = 1; % default is 1; binlister option: Use bin # to label epochs, transfer to EEG structure checked
xRTlock1 = 0; % AVERAGING % RT locked 1
xRTlock2 = 0; % AVERAGING % RT locked 2
xRTlock3 = 0; % AVERAGING % RT locked 3
xRTlock4 = 0; % AVERAGING % RT locked 4
bo = 0; %Bin Operations

% ERPLab Function Flags in sequence
import = 0; % run alone first then never again (also helpful for some subjects with specific file problems)
chanloc = 0;   % Add channel locations
elist = 0;  % EventList
binlis =  0; % Binlister
refch = 0;  % Define reference channel for biosemi data, default M12, option CAR
epoch = 0;  % BinEpoch
addeye = 0; % Add eye channels
artif = 0; % Artifact Detection 
artif_all = 1; % after modify for each subjects, run them all
avg = 1; % NOT implemented separately
gavg = 1;   % input required in CMD: 1 column list of subject .erp files with pathname in erpfiles.txt
meas = 1; % 
lp = 1; % not checked that it works but should work


%Other global para
allbins = 174; % color 174
file1 = 'biosemi64xyz10-20.xyz';
file2 = 'garvparm.txt';
file3 = 'erpfiles.txt';
%pathname_write = ??
%impexpsubject20 = ??

fprintf('\n+++++++++++++++\n+ Setup Global and ERPLab Function Flags: done! ... \n+++++++++++++++\n\n');