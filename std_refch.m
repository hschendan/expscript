%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Reference to mean of bilateral mastoids & CAR % 
% To DO: Add RTlock                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function std_refch

global nraw data_path  subject ch64 CAR

disp('Reference: WORKING ...')

for s=1:nraw
    sname = [data_path{s} subject{s} '_ceb.set'];        
    if exist(sname, 'file')>0
        clear EEG;  % Clear is to make sure that we start fresh for each subject with the EEG structures
        EEG = pop_loadset('filename', [subject{s} '_ceb.set'], 'filepath', data_path{s});
        if ch64 % 64 channel cap
            EEG = pop_reref( EEG, [68 69],'keepref','on'); % reference to mean of M1 and M2
        else    % 32 channel cap
            EEG = pop_reref( EEG, [36 37],'keepref','on');
        end
        EEG.setname= [subject{s} '_cebM12'];
        EEG = pop_saveset(EEG, 'filename', [EEG.setname '.set'], 'filepath', data_path{s}); 
        if CAR
            clear EEG;  % Clear is to make sure that we start fresh for each subject with the EEG structures
            EEG = pop_loadset('filename', [subject{s} '_ceb.set'], 'filepath', data_path{s}); 
            EEG = pop_reref( EEG, []); % Common average reference,
             %EEG = pop_reref( EEG, [],'exclude',[65:67] ); % Common average reference for 64 ch, exclude HE1, HE2, LE
            EEG.setname= [subject{s} '_cebCAR'];
            EEG= pop_saveset(EEG, 'filename', [EEG.setname '.set'], 'filepath', data_path{s}); 
        end
    else
        fprintf('\n *** WARNING: %s does not exist *** \n\n', sname);
    end
end

fprintf('\n+++++++++++++++\n+ Re-Referenced to M12 and CAR: done! ... \n+++++++++++++++\n\n');