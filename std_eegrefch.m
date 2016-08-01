%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Reference to mean of bilateral mastoids & CAR % 
% To DO: Add RTlock                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function std_eegrefch

global nraw data_path  subject ch64 sfx set 

disp('EEG Reference: WORKING ...')

fprintf('\n+++++++++++++++\n+ (eegrefch) previous sfx = %s ... \n+++++++++++++++\n\n', sfx);

x = 'M12';

for s=1:nraw
    sname = [data_path{s} subject{s} sfx set];        
    if exist(sname, 'file')>0
        clear EEG;  % Clear is to make sure that we start fresh for each subject with the EEG structures
        EEG = pop_loadset('filename', [subject{s} sfx set], 'filepath', data_path{s});
        if ch64 % 64 channel cap
            EEG = pop_reref( EEG, [68 69],'keepref','on'); % reference to mean of M1 and M2
        else    % 32 channel cap
            EEG = pop_reref( EEG, [36 37],'keepref','on');
        end
        EEG.setname= [subject{s} sfx x];
        EEG = pop_saveset(EEG, 'filename', [EEG.setname set], 'filepath', data_path{s});
    else
        fprintf('\n *** WARNING: %s does not exist *** \n\n', sname);
    end
end

sfx = [sfx x];


fprintf('\n+++++++++++++++\n+ (eegrefch) New sfx = %s ... \n+++++++++++++++\n\n', sfx);

fprintf('\n+++++++++++++++\n+ Re-Referenced to M12: done! ... \n+++++++++++++++\n\n');