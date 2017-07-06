function std_artif_T(s)
  
global data_path subject ch64 artparm set expname

sfx = '_ebcpy'; % initialise sfx, please modify it yourself
x = 'a';

fprintf('\n+++++++++++++++\n+ (artif_T) Previous sfx = %s ... \n+++++++++++++++\n\n', sfx);

    sname = [data_path{s} subject{s} sfx set];       
    if  exist(sname, 'file')>0               
        clear EEG;  % Clear is to make sure that we start fresh for each subject with the EEG and ERP structures
    %clear ERP;  % Clear is to make sure that we start fresh for each subject with the EEG and ERP structures
        EEG = pop_loadset('filename', [subject{s} sfx set], 'filepath', data_path{s});                
    %TO DO: Detect artifacts for current dataset. Adjust parameter values after EEG in function
    % Artifact detection notes: 
    % BLINK & HEOG: Step-like. Test window = [-100 898] ms; Threshold = TODO uV; Window width = 400 ms (use default or TODO); Window step = 10 ms; Channels = 65 (Blink); Flags to be activated = 1 & 3
         if ch64 % 64 channel cap            
% AUTOMATIC read of parameters from garvparm.txt which needs to be modified to set the parameters
EEG = pop_artextval( EEG, 'Channel', [1:71], 'Flag',  2, 'Review', 'off', 'Threshold', [ artparm(s,1) artparm(s,2)], 'Twindow', [-200 900]); %Voltage threshold
EEG = pop_artstep( EEG , 'Channel',  71, 'Flag', 3, 'Review', 'off', 'Threshold',  artparm(s,3), 'Twindow', [ -200 900], 'Windowsize',  artparm(s,4), 'Windowstep',  artparm(s,5) ); % step-like artifacts VEOG
EEG = pop_artstep( EEG , 'Channel',  70, 'Flag',  4, 'Review', 'off', 'Threshold',  artparm(s,6), 'Twindow', [ -200 900], 'Windowsize',  artparm(s,7), 'Windowstep',  artparm(s,8) ); % step-like artifacts HEOG
EEG = pop_artstep( EEG , 'Channel',  [1:64,68:69], 'Flag',  5, 'Review', 'off', 'Threshold',  artparm(s,9), 'Twindow', [ -200 900], 'Windowsize',  artparm(s,10), 'Windowstep',  artparm(s,11) ); % step-like artifacts other chans
EEG = pop_artmwppth( EEG , 'Channel',  [1:64,68:69], 'Flag',  6, 'Review', 'off', 'Threshold',  artparm(s,12), 'Twindow', [ -200 900], 'Windowsize',  artparm(s,13), 'Windowstep',  artparm(s,14) ); % P2P ALL
EEG = pop_artmwppth( EEG , 'Channel',  71, 'Flag',  7, 'Review', 'off', 'Threshold',  artparm(s,15), 'Twindow', [ -200 900], 'Windowsize',  artparm(s,16), 'Windowstep',  artparm(s,17) ); % P2P VOG           
EEG = pop_artdiff( EEG , 'Channel',  [1:64,68:69], 'Flag',  8, 'Review', 'off', 'Threshold',  artparm(s,18), 'Twindow', [ -200 900] ); %Extreme spikiness, eg. muscle

% MANUAL entry of parameters here.
% Threshold must be LOWER than above garvparm.txt to catch more artif trials.
% Change any parameters below and add/delete artif function lines, as needed.
% Channels specified one or multiple, such as [11:20] for channels 11 through 20. Use to detect artifacts at 1
% channel or a set of nearby or similarly affected channels. GARV excel
% template has example of how to quickly create new function lines. Copy
% and paste lines from excel to add to this artif for each subject.
%  Some below duplicate garvparms.txt (e.g., eye channels) so can be
% deleted, unless you need to use to detect a few unusual trials.

EEG = pop_artextval( EEG, 'Channel', [1], 'Flag',  2, 'Review', 'off', 'Threshold', [-125 125], 'Twindow', [-200 900]); %Voltage threshold
EEG = pop_artextval( EEG, 'Channel', [2], 'Flag',  2, 'Review', 'off', 'Threshold', [-125 125], 'Twindow', [-200 900]); %Voltage threshold
EEG = pop_artextval( EEG, 'Channel', [3], 'Flag',  2, 'Review', 'off', 'Threshold', [-125 125], 'Twindow', [-200 900]); %Voltage threshold
EEG = pop_artextval( EEG, 'Channel', [4], 'Flag',  2, 'Review', 'off', 'Threshold', [-125 125], 'Twindow', [-200 900]); %Voltage threshold
EEG = pop_artextval( EEG, 'Channel', [5], 'Flag',  2, 'Review', 'off', 'Threshold', [-125 125], 'Twindow', [-200 900]); %Voltage threshold
EEG = pop_artextval( EEG, 'Channel', [6], 'Flag',  2, 'Review', 'off', 'Threshold', [-125 125], 'Twindow', [-200 900]); %Voltage threshold
EEG = pop_artextval( EEG, 'Channel', [7], 'Flag',  2, 'Review', 'off', 'Threshold', [-125 125], 'Twindow', [-200 900]); %Voltage threshold
EEG = pop_artextval( EEG, 'Channel', [8:10], 'Flag',  2, 'Review', 'off', 'Threshold', [-125 125], 'Twindow', [-200 900]); %Voltage threshold
EEG = pop_artextval( EEG, 'Channel', [11:20], 'Flag',  2, 'Review', 'off', 'Threshold', [-125 125], 'Twindow', [-200 900]); %Voltage threshold
EEG = pop_artextval( EEG, 'Channel', [21:30], 'Flag',  2, 'Review', 'off', 'Threshold', [-125 125], 'Twindow', [-200 900]); %Voltage threshold
EEG = pop_artextval( EEG, 'Channel', [31:32], 'Flag',  2, 'Review', 'off', 'Threshold', [-125 125], 'Twindow', [-200 900]); %Voltage threshold
EEG = pop_artextval( EEG, 'Channel', [33], 'Flag',  2, 'Review', 'off', 'Threshold', [-125 125], 'Twindow', [-200 900]); %Voltage threshold
EEG = pop_artextval( EEG, 'Channel', [34], 'Flag',  2, 'Review', 'off', 'Threshold', [-125 125], 'Twindow', [-200 900]); %Voltage threshold
EEG = pop_artextval( EEG, 'Channel', [35], 'Flag',  2, 'Review', 'off', 'Threshold', [-125 125], 'Twindow', [-200 900]); %Voltage threshold
EEG = pop_artextval( EEG, 'Channel', [36], 'Flag',  2, 'Review', 'off', 'Threshold', [-125 125], 'Twindow', [-200 900]); %Voltage threshold
EEG = pop_artextval( EEG, 'Channel', [37], 'Flag',  2, 'Review', 'off', 'Threshold', [-125 125], 'Twindow', [-200 900]); %Voltage threshold
EEG = pop_artextval( EEG, 'Channel', [38], 'Flag',  2, 'Review', 'off', 'Threshold', [-125 125], 'Twindow', [-200 900]); %Voltage threshold
EEG = pop_artextval( EEG, 'Channel', [39], 'Flag',  2, 'Review', 'off', 'Threshold', [-125 125], 'Twindow', [-200 900]); %Voltage threshold
EEG = pop_artextval( EEG, 'Channel', [40], 'Flag',  2, 'Review', 'off', 'Threshold', [-125 125], 'Twindow', [-200 900]); %Voltage threshold
EEG = pop_artextval( EEG, 'Channel', [41], 'Flag',  2, 'Review', 'off', 'Threshold', [-125 125], 'Twindow', [-200 900]); %Voltage threshold
EEG = pop_artextval( EEG, 'Channel', [42], 'Flag',  2, 'Review', 'off', 'Threshold', [-125 125], 'Twindow', [-200 900]); %Voltage threshold
EEG = pop_artextval( EEG, 'Channel', [43:50], 'Flag',  2, 'Review', 'off', 'Threshold', [-125 125], 'Twindow', [-200 900]); %Voltage threshold
EEG = pop_artextval( EEG, 'Channel', [51:60], 'Flag',  2, 'Review', 'off', 'Threshold', [-125 125], 'Twindow', [-200 900]); %Voltage threshold
EEG = pop_artextval( EEG, 'Channel', [61:64], 'Flag',  2, 'Review', 'off', 'Threshold', [-125 125], 'Twindow', [-200 900]); %Voltage threshold
EEG = pop_artextval( EEG, 'Channel', [65:66], 'Flag',  2, 'Review', 'off', 'Threshold', [-125 125], 'Twindow', [-200 900]); %Voltage threshold
EEG = pop_artextval( EEG, 'Channel', [67], 'Flag',  2, 'Review', 'off', 'Threshold', [-125 125], 'Twindow', [-200 900]); %Voltage threshold
EEG = pop_artextval( EEG, 'Channel', [68:69], 'Flag',  2, 'Review', 'off', 'Threshold', [-125 125], 'Twindow', [-200 900]); %Voltage threshold
EEG = pop_artextval( EEG, 'Channel', [70], 'Flag',  2, 'Review', 'off', 'Threshold', [-125 125], 'Twindow', [-200 900]); %Voltage threshold
EEG = pop_artextval( EEG, 'Channel', [71], 'Flag',  2, 'Review', 'off', 'Threshold', [-125 125], 'Twindow', [-200 900]); %Voltage threshold

EEG = pop_artstep( EEG , 'Channel', [1], 'Flag', 5, 'Review', 'off', 'Threshold',  50, 'Twindow', [ -200 900], 'Windowsize',  400, 'Windowstep',  10 ); % step-like artifacts
EEG = pop_artstep( EEG , 'Channel', [2], 'Flag', 5, 'Review', 'off', 'Threshold',  50, 'Twindow', [ -200 900], 'Windowsize',  400, 'Windowstep',  10 ); % step-like artifacts
EEG = pop_artstep( EEG , 'Channel', [3], 'Flag', 5, 'Review', 'off', 'Threshold',  50, 'Twindow', [ -200 900], 'Windowsize',  400, 'Windowstep',  10 ); % step-like artifacts
EEG = pop_artstep( EEG , 'Channel', [4], 'Flag', 5, 'Review', 'off', 'Threshold',  50, 'Twindow', [ -200 900], 'Windowsize',  400, 'Windowstep',  10 ); % step-like artifacts
EEG = pop_artstep( EEG , 'Channel', [5], 'Flag', 5, 'Review', 'off', 'Threshold',  50, 'Twindow', [ -200 900], 'Windowsize',  400, 'Windowstep',  10 ); % step-like artifacts
EEG = pop_artstep( EEG , 'Channel', [6], 'Flag', 5, 'Review', 'off', 'Threshold',  50, 'Twindow', [ -200 900], 'Windowsize',  400, 'Windowstep',  10 ); % step-like artifacts
EEG = pop_artstep( EEG , 'Channel', [7], 'Flag', 5, 'Review', 'off', 'Threshold',  50, 'Twindow', [ -200 900], 'Windowsize',  400, 'Windowstep',  10 ); % step-like artifacts
EEG = pop_artstep( EEG , 'Channel', [8:10], 'Flag', 5, 'Review', 'off', 'Threshold',  50, 'Twindow', [ -200 900], 'Windowsize',  400, 'Windowstep',  10 ); % step-like artifacts
EEG = pop_artstep( EEG , 'Channel', [11:20], 'Flag', 5, 'Review', 'off', 'Threshold',  50, 'Twindow', [ -200 900], 'Windowsize',  400, 'Windowstep',  10 ); % step-like artifacts
EEG = pop_artstep( EEG , 'Channel', [21:30], 'Flag', 5, 'Review', 'off', 'Threshold',  50, 'Twindow', [ -200 900], 'Windowsize',  400, 'Windowstep',  10 ); % step-like artifacts
EEG = pop_artstep( EEG , 'Channel', [31:32], 'Flag', 5, 'Review', 'off', 'Threshold',  50, 'Twindow', [ -200 900], 'Windowsize',  400, 'Windowstep',  10 ); % step-like artifacts
EEG = pop_artstep( EEG , 'Channel', [33], 'Flag', 5, 'Review', 'off', 'Threshold',  50, 'Twindow', [ -200 900], 'Windowsize',  400, 'Windowstep',  10 ); % step-like artifacts
EEG = pop_artstep( EEG , 'Channel', [34], 'Flag', 5, 'Review', 'off', 'Threshold',  50, 'Twindow', [ -200 900], 'Windowsize',  400, 'Windowstep',  10 ); % step-like artifacts
EEG = pop_artstep( EEG , 'Channel', [35], 'Flag', 5, 'Review', 'off', 'Threshold',  50, 'Twindow', [ -200 900], 'Windowsize',  400, 'Windowstep',  10 ); % step-like artifacts
EEG = pop_artstep( EEG , 'Channel', [36], 'Flag', 5, 'Review', 'off', 'Threshold',  50, 'Twindow', [ -200 900], 'Windowsize',  400, 'Windowstep',  10 ); % step-like artifacts
EEG = pop_artstep( EEG , 'Channel', [37], 'Flag', 5, 'Review', 'off', 'Threshold',  50, 'Twindow', [ -200 900], 'Windowsize',  400, 'Windowstep',  10 ); % step-like artifacts
EEG = pop_artstep( EEG , 'Channel', [38], 'Flag', 5, 'Review', 'off', 'Threshold',  50, 'Twindow', [ -200 900], 'Windowsize',  400, 'Windowstep',  10 ); % step-like artifacts
EEG = pop_artstep( EEG , 'Channel', [39], 'Flag', 5, 'Review', 'off', 'Threshold',  50, 'Twindow', [ -200 900], 'Windowsize',  400, 'Windowstep',  10 ); % step-like artifacts
EEG = pop_artstep( EEG , 'Channel', [40], 'Flag', 5, 'Review', 'off', 'Threshold',  50, 'Twindow', [ -200 900], 'Windowsize',  400, 'Windowstep',  10 ); % step-like artifacts
EEG = pop_artstep( EEG , 'Channel', [41], 'Flag', 5, 'Review', 'off', 'Threshold',  50, 'Twindow', [ -200 900], 'Windowsize',  400, 'Windowstep',  10 ); % step-like artifacts
EEG = pop_artstep( EEG , 'Channel', [42], 'Flag', 5, 'Review', 'off', 'Threshold',  50, 'Twindow', [ -200 900], 'Windowsize',  400, 'Windowstep',  10 ); % step-like artifacts
EEG = pop_artstep( EEG , 'Channel', [43:50], 'Flag', 5, 'Review', 'off', 'Threshold',  50, 'Twindow', [ -200 900], 'Windowsize',  400, 'Windowstep',  10 ); % step-like artifacts
EEG = pop_artstep( EEG , 'Channel', [51:60], 'Flag', 5, 'Review', 'off', 'Threshold',  50, 'Twindow', [ -200 900], 'Windowsize',  400, 'Windowstep',  10 ); % step-like artifacts
EEG = pop_artstep( EEG , 'Channel', [61:64], 'Flag', 5, 'Review', 'off', 'Threshold',  50, 'Twindow', [ -200 900], 'Windowsize',  400, 'Windowstep',  10 ); % step-like artifacts
EEG = pop_artstep( EEG , 'Channel', [65:66], 'Flag', 5, 'Review', 'off', 'Threshold',  50, 'Twindow', [ -200 900], 'Windowsize',  400, 'Windowstep',  10 ); % step-like artifacts
EEG = pop_artstep( EEG , 'Channel', [67], 'Flag', 5, 'Review', 'off', 'Threshold',  50, 'Twindow', [ -200 900], 'Windowsize',  400, 'Windowstep',  10 ); % step-like artifacts
EEG = pop_artstep( EEG , 'Channel', [68:69], 'Flag', 5, 'Review', 'off', 'Threshold',  50, 'Twindow', [ -200 900], 'Windowsize',  400, 'Windowstep',  10 ); % step-like artifacts
EEG = pop_artstep( EEG , 'Channel', [70], 'Flag', 5, 'Review', 'off', 'Threshold',  50, 'Twindow', [ -200 900], 'Windowsize',  400, 'Windowstep',  10 ); % step-like artifacts
EEG = pop_artstep( EEG , 'Channel', [71], 'Flag', 5, 'Review', 'off', 'Threshold',  50, 'Twindow', [ -200 900], 'Windowsize',  400, 'Windowstep',  10 ); % step-like artifacts

EEG = pop_artmwppth( EEG , 'Channel',  [1], 'Flag',  6, 'Review', 'off', 'Threshold', 150, 'Twindow', [ -200 900], 'Windowsize',  200, 'Windowstep',  50 ); % P2P
EEG = pop_artmwppth( EEG , 'Channel',  [2], 'Flag',  6, 'Review', 'off', 'Threshold', 150, 'Twindow', [ -200 900], 'Windowsize',  200, 'Windowstep',  50 ); % P2P
EEG = pop_artmwppth( EEG , 'Channel',  [3], 'Flag',  6, 'Review', 'off', 'Threshold', 150, 'Twindow', [ -200 900], 'Windowsize',  200, 'Windowstep',  50 ); % P2P
EEG = pop_artmwppth( EEG , 'Channel',  [4], 'Flag',  6, 'Review', 'off', 'Threshold', 150, 'Twindow', [ -200 900], 'Windowsize',  200, 'Windowstep',  50 ); % P2P
EEG = pop_artmwppth( EEG , 'Channel',  [5], 'Flag',  6, 'Review', 'off', 'Threshold', 150, 'Twindow', [ -200 900], 'Windowsize',  200, 'Windowstep',  50 ); % P2P
EEG = pop_artmwppth( EEG , 'Channel',  [6], 'Flag',  6, 'Review', 'off', 'Threshold', 150, 'Twindow', [ -200 900], 'Windowsize',  200, 'Windowstep',  50 ); % P2P
EEG = pop_artmwppth( EEG , 'Channel',  [7], 'Flag',  6, 'Review', 'off', 'Threshold', 150, 'Twindow', [ -200 900], 'Windowsize',  200, 'Windowstep',  50 ); % P2P
EEG = pop_artmwppth( EEG , 'Channel',  [8:10], 'Flag',  6, 'Review', 'off', 'Threshold', 150, 'Twindow', [ -200 900], 'Windowsize',  200, 'Windowstep',  50 ); % P2P
EEG = pop_artmwppth( EEG , 'Channel',  [11:20], 'Flag',  6, 'Review', 'off', 'Threshold', 150, 'Twindow', [ -200 900], 'Windowsize',  200, 'Windowstep',  50 ); % P2P
EEG = pop_artmwppth( EEG , 'Channel',  [21:30], 'Flag',  6, 'Review', 'off', 'Threshold', 150, 'Twindow', [ -200 900], 'Windowsize',  200, 'Windowstep',  50 ); % P2P
EEG = pop_artmwppth( EEG , 'Channel',  [31:32], 'Flag',  6, 'Review', 'off', 'Threshold', 150, 'Twindow', [ -200 900], 'Windowsize',  200, 'Windowstep',  50 ); % P2P
EEG = pop_artmwppth( EEG , 'Channel',  [33], 'Flag',  6, 'Review', 'off', 'Threshold', 150, 'Twindow', [ -200 900], 'Windowsize',  200, 'Windowstep',  50 ); % P2P
EEG = pop_artmwppth( EEG , 'Channel',  [34], 'Flag',  6, 'Review', 'off', 'Threshold', 150, 'Twindow', [ -200 900], 'Windowsize',  200, 'Windowstep',  50 ); % P2P
EEG = pop_artmwppth( EEG , 'Channel',  [35], 'Flag',  6, 'Review', 'off', 'Threshold', 150, 'Twindow', [ -200 900], 'Windowsize',  200, 'Windowstep',  50 ); % P2P
EEG = pop_artmwppth( EEG , 'Channel',  [36], 'Flag',  6, 'Review', 'off', 'Threshold', 150, 'Twindow', [ -200 900], 'Windowsize',  200, 'Windowstep',  50 ); % P2P
EEG = pop_artmwppth( EEG , 'Channel',  [37], 'Flag',  6, 'Review', 'off', 'Threshold', 150, 'Twindow', [ -200 900], 'Windowsize',  200, 'Windowstep',  50 ); % P2P
EEG = pop_artmwppth( EEG , 'Channel',  [38], 'Flag',  6, 'Review', 'off', 'Threshold', 150, 'Twindow', [ -200 900], 'Windowsize',  200, 'Windowstep',  50 ); % P2P
EEG = pop_artmwppth( EEG , 'Channel',  [39], 'Flag',  6, 'Review', 'off', 'Threshold', 150, 'Twindow', [ -200 900], 'Windowsize',  200, 'Windowstep',  50 ); % P2P
EEG = pop_artmwppth( EEG , 'Channel',  [40], 'Flag',  6, 'Review', 'off', 'Threshold', 150, 'Twindow', [ -200 900], 'Windowsize',  200, 'Windowstep',  50 ); % P2P
EEG = pop_artmwppth( EEG , 'Channel',  [41], 'Flag',  6, 'Review', 'off', 'Threshold', 150, 'Twindow', [ -200 900], 'Windowsize',  200, 'Windowstep',  50 ); % P2P
EEG = pop_artmwppth( EEG , 'Channel',  [42], 'Flag',  6, 'Review', 'off', 'Threshold', 150, 'Twindow', [ -200 900], 'Windowsize',  200, 'Windowstep',  50 ); % P2P
EEG = pop_artmwppth( EEG , 'Channel',  [43:50], 'Flag',  6, 'Review', 'off', 'Threshold', 150, 'Twindow', [ -200 900], 'Windowsize',  200, 'Windowstep',  50 ); % P2P
EEG = pop_artmwppth( EEG , 'Channel',  [51:60], 'Flag',  6, 'Review', 'off', 'Threshold', 150, 'Twindow', [ -200 900], 'Windowsize',  200, 'Windowstep',  50 ); % P2P
EEG = pop_artmwppth( EEG , 'Channel',  [61:64], 'Flag',  6, 'Review', 'off', 'Threshold', 150, 'Twindow', [ -200 900], 'Windowsize',  200, 'Windowstep',  50 ); % P2P
EEG = pop_artmwppth( EEG , 'Channel',  [65:66], 'Flag',  6, 'Review', 'off', 'Threshold', 150, 'Twindow', [ -200 900], 'Windowsize',  200, 'Windowstep',  50 ); % P2P
EEG = pop_artmwppth( EEG , 'Channel',  [67], 'Flag',  6, 'Review', 'off', 'Threshold', 150, 'Twindow', [ -200 900], 'Windowsize',  200, 'Windowstep',  50 ); % P2P
EEG = pop_artmwppth( EEG , 'Channel',  [68:69], 'Flag',  6, 'Review', 'off', 'Threshold', 150, 'Twindow', [ -200 900], 'Windowsize',  200, 'Windowstep',  50 ); % P2P
EEG = pop_artmwppth( EEG , 'Channel',  [70], 'Flag',  6, 'Review', 'off', 'Threshold', 150, 'Twindow', [ -200 900], 'Windowsize',  200, 'Windowstep',  50 ); % P2P
EEG = pop_artmwppth( EEG , 'Channel',  [71], 'Flag',  6, 'Review', 'off', 'Threshold', 150, 'Twindow', [ -200 900], 'Windowsize',  200, 'Windowstep',  50 ); % P2P

EEG = pop_artdiff( EEG , 'Channel',  [1], 'Flag',  8, 'Review', 'off', 'Threshold',  100, 'Twindow', [ -200 900] ); %Extreme spikiness, eg. muscle
EEG = pop_artdiff( EEG , 'Channel',  [2], 'Flag',  8, 'Review', 'off', 'Threshold',  100, 'Twindow', [ -200 900] ); %Extreme spikiness, eg. muscle
EEG = pop_artdiff( EEG , 'Channel',  [3], 'Flag',  8, 'Review', 'off', 'Threshold',  100, 'Twindow', [ -200 900] ); %Extreme spikiness, eg. muscle
EEG = pop_artdiff( EEG , 'Channel',  [4], 'Flag',  8, 'Review', 'off', 'Threshold',  100, 'Twindow', [ -200 900] ); %Extreme spikiness, eg. muscle
EEG = pop_artdiff( EEG , 'Channel',  [5], 'Flag',  8, 'Review', 'off', 'Threshold',  100, 'Twindow', [ -200 900] ); %Extreme spikiness, eg. muscle
EEG = pop_artdiff( EEG , 'Channel',  [6], 'Flag',  8, 'Review', 'off', 'Threshold',  100, 'Twindow', [ -200 900] ); %Extreme spikiness, eg. muscle
EEG = pop_artdiff( EEG , 'Channel',  [7], 'Flag',  8, 'Review', 'off', 'Threshold',  100, 'Twindow', [ -200 900] ); %Extreme spikiness, eg. muscle
EEG = pop_artdiff( EEG , 'Channel',  [8:10], 'Flag',  8, 'Review', 'off', 'Threshold',  100, 'Twindow', [ -200 900] ); %Extreme spikiness, eg. muscle
EEG = pop_artdiff( EEG , 'Channel',  [11:20], 'Flag',  8, 'Review', 'off', 'Threshold',  100, 'Twindow', [ -200 900] ); %Extreme spikiness, eg. muscle
EEG = pop_artdiff( EEG , 'Channel',  [21:30], 'Flag',  8, 'Review', 'off', 'Threshold',  100, 'Twindow', [ -200 900] ); %Extreme spikiness, eg. muscle
EEG = pop_artdiff( EEG , 'Channel',  [31:32], 'Flag',  8, 'Review', 'off', 'Threshold',  100, 'Twindow', [ -200 900] ); %Extreme spikiness, eg. muscle
EEG = pop_artdiff( EEG , 'Channel',  [33], 'Flag',  8, 'Review', 'off', 'Threshold',  100, 'Twindow', [ -200 900] ); %Extreme spikiness, eg. muscle
EEG = pop_artdiff( EEG , 'Channel',  [34], 'Flag',  8, 'Review', 'off', 'Threshold',  100, 'Twindow', [ -200 900] ); %Extreme spikiness, eg. muscle
EEG = pop_artdiff( EEG , 'Channel',  [35], 'Flag',  8, 'Review', 'off', 'Threshold',  100, 'Twindow', [ -200 900] ); %Extreme spikiness, eg. muscle
EEG = pop_artdiff( EEG , 'Channel',  [36], 'Flag',  8, 'Review', 'off', 'Threshold',  100, 'Twindow', [ -200 900] ); %Extreme spikiness, eg. muscle
EEG = pop_artdiff( EEG , 'Channel',  [37], 'Flag',  8, 'Review', 'off', 'Threshold',  100, 'Twindow', [ -200 900] ); %Extreme spikiness, eg. muscle
EEG = pop_artdiff( EEG , 'Channel',  [38], 'Flag',  8, 'Review', 'off', 'Threshold',  100, 'Twindow', [ -200 900] ); %Extreme spikiness, eg. muscle
EEG = pop_artdiff( EEG , 'Channel',  [39], 'Flag',  8, 'Review', 'off', 'Threshold',  100, 'Twindow', [ -200 900] ); %Extreme spikiness, eg. muscle
EEG = pop_artdiff( EEG , 'Channel',  [40], 'Flag',  8, 'Review', 'off', 'Threshold',  100, 'Twindow', [ -200 900] ); %Extreme spikiness, eg. muscle
EEG = pop_artdiff( EEG , 'Channel',  [41], 'Flag',  8, 'Review', 'off', 'Threshold',  100, 'Twindow', [ -200 900] ); %Extreme spikiness, eg. muscle
EEG = pop_artdiff( EEG , 'Channel',  [42], 'Flag',  8, 'Review', 'off', 'Threshold',  100, 'Twindow', [ -200 900] ); %Extreme spikiness, eg. muscle
EEG = pop_artdiff( EEG , 'Channel',  [43:50], 'Flag',  8, 'Review', 'off', 'Threshold',  100, 'Twindow', [ -200 900] ); %Extreme spikiness, eg. muscle
EEG = pop_artdiff( EEG , 'Channel',  [51:60], 'Flag',  8, 'Review', 'off', 'Threshold',  100, 'Twindow', [ -200 900] ); %Extreme spikiness, eg. muscle
EEG = pop_artdiff( EEG , 'Channel',  [61:64], 'Flag',  8, 'Review', 'off', 'Threshold',  100, 'Twindow', [ -200 900] ); %Extreme spikiness, eg. muscle
EEG = pop_artdiff( EEG , 'Channel',  [68:69], 'Flag',  8, 'Review', 'off', 'Threshold',  100, 'Twindow', [ -200 900] ); %Extreme spikiness, eg. muscle
         else    % 32 channel cap: TO check
            EEG = pop_artextval( EEG, 'Channel', [1:32,38:39], 'Flag',  2, 'Review', 'off', 'Threshold', [ artparms(s,1) artparms(s,2)], 'Twindow', [-200 900]); %Voltage threshold
            EEG = pop_artstep( EEG , 'Channel',  39, 'Flag',  3, 'Review', 'off', 'Threshold',  artparms(s,3), 'Twindow', [ -200 900], 'Windowsize',  artparms(s,4), 'Windowstep',  artparms(s,5) ); % step-like artifacts VEOG
            EEG = pop_artstep( EEG , 'Channel',  38, 'Flag',  4, 'Review', 'off', 'Threshold',  artparms(s,6), 'Twindow', [ -200 900], 'Windowsize',  artparms(s,7), 'Windowstep',  artparms(s,8) ); % step-like artifacts HEOG
            EEG = pop_artstep( EEG , 'Channel',  1:32, 'Flag',  5, 'Review', 'off', 'Threshold',  artparms(s,9), 'Twindow', [ -200 900], 'Windowsize',  artparms(s,10), 'Windowstep',  artparms(s,11) ); % step-like artifacts other chans
            EEG = pop_artmwppth( EEG , 'Channel',  1:32, 'Flag',  6, 'Review', 'off', 'Threshold',  artparms(s,12), 'Twindow', [ -200 900], 'Windowsize',  artparms(s,13), 'Windowstep',  artparms(s,14) ); % P2P ALL
            EEG = pop_artmwppth( EEG , 'Channel',  39, 'Flag',  7, 'Review', 'off', 'Threshold',  artparms(s,15), 'Twindow', [ -200 900], 'Windowsize',  artparms(s,16), 'Windowstep',  artparms(s,17) ); % P2P VOG           
            EEG = pop_artdiff( EEG , 'Channel',  1:32, 'Flag',  8, 'Review', 'off', 'Threshold',  artparms(s,18), 'Twindow', [ -200 900] ); %Extreme spikiness
         end    
        pop_eegplot( EEG, 1, 1, 1);
        EEG.setname= [subject{s} sfx x];
        
        EEG = pop_saveset(EEG, 'filename', [EEG.setname set], 'filepath', data_path{s});   
        % Export ar info          
        EEG = pop_exporteegeventlist(EEG, [data_path{s}, subject{s} '_EEG_ar.txt']);
        pop_summary_AR_eeg_detection(EEG, [data_path{s}, subject{s} '_EEG_arTab.txt']);  % Save ar Table
        values = pop_rt2text(EEG, 'arfilter', 'on', 'eventlist',  1, 'filename', [data_path{s} EEG.setname '_arRT.txt'], 'header','on', 'listformat', 'basic' );
        values = pop_rt2text(EEG, 'arfilter', 'on', 'eventlist',  1, 'filename', [data_path{s} EEG.setname '_arRTs.txt'], 'header','on', 'listformat', 'itemized' );
                [EEG, tprej, acce, rej, histoflags ] = pop_summary_AR_eeg_detection(EEG,'none');
        % Create table of EEG, to get bins   
        nbins = struct2table(EEG.EVENTLIST.bdf);
        % Create total trials
        acce = transpose(acce);
        rej = transpose(rej);
        ttrials = acce + rej;
        % Create table 
        T = table(nbins.namebin,nbins.description, ttrials, acce,rej);
        % Rename columns
        T.Properties.VariableNames={'Bin','Desc','Total','Acce','Rej'};
        % Write into spreadsheet
%         writetable(T,strcat( data_path{s},subject{s},'.xlsx'),'sheet',subject{s})
        writetable(T,strcat(expname, '_trials_perbin.xlsx'),'sheet',subject{s})
        % ERP = pop_averager( EEG, 'Criterion', 'good', 'Stdev', 'on');
        
        
    % ERP = pop_averager( EEG, 'Criterion', 'good', 'Stdev', 'on');
    % erpname = [subject{s} 'M12_ar'];  % name for erpset menu
    % fname_erp= fullfile(data_path{s}, [erpname '.erp']);
    % pop_savemyerp(ERP, 'erpname', erpname, 'filename', fname_erp, 'warning', 'off');  
   
    else
            fprintf('\n *** WARNING: %s does not exist *** \n\n', sname);
    end
    
    fprintf('\n+++++++++++++++\n+ Artifact detection for %s : done! ... \n+++++++++++++++\n\n', subject{s});