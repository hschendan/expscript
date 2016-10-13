%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Create Bin based Epoch Pg. 19
% For ICA, re-reference before epoching; rereference non-epoched data
% To do: RTlock
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function std_epoch

global nraw data_path subject set

disp('Create Bin based Epoch: WORKING ...')

sfx = '_ebc';   %initialise sfx, please modify it yourself
x = 'p';

for s=1:nraw
    sname = [data_path{s} subject{s} sfx set];        
    if exist(sname, 'file')>0
        clear EEG;  % Clear is to make sure that we start fresh for each subject with the EEG and ERP structures
        % Load dataset
        EEG = pop_loadset('filename', [subject{s} sfx set], 'filepath', data_path{s});                
        % Extracts bin-based epochs (200 ms pre-stim, 900 ms post-stim. Baseline correction by pre-stim window)
        EEG = pop_epochbin( EEG , [-200.0  900.0],  'pre');               
        EEG.setname= [subject{s} sfx x];
        % Save dataset
        EEG = pop_saveset(EEG, 'filename', [EEG.setname set], 'filepath', data_path{s}); 
       
    else
        fprintf('\n *** WARNING: %s does not exist *** \n\n', sname);
    end
    
end

fprintf('\n+++++++++++++++\n+ Create Bin based Epoch: done! ... \n+++++++++++++++\n\n');

