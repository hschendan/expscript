%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Create Bin based Epoch Pg. 19
% For ICA, re-reference before epoching; rereference non-epoched data
% To do: RTlock
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function std_epoch

global nraw data_path subject CAR RTlock

disp('Create Bin based Epoch: WORKING ...')
    
for s=1:nraw
    sname = [data_path{s} subject{s} '_cebM12.set'];        
    if exist(sname, 'file')>0
        clear EEG;  % Clear is to make sure that we start fresh for each subject with the EEG and ERP structures
        % Load dataset
        EEG = pop_loadset('filename', [subject{s} '_cebM12.set'], 'filepath', data_path{s});                
        % Extracts bin-based epochs (200 ms pre-stim, 900 ms post-stim. Baseline correction by pre-stim window)
        EEG = pop_epochbin( EEG , [-200.0  900.0],  'pre');               
        EEG.setname= [subject{s} '_cebM12e'];
        % Save dataset
        EEG = pop_saveset(EEG, 'filename', [EEG.setname '.set'], 'filepath', data_path{s}); 
        if CAR
            sname = [data_path{s} subject{s} '_cebCAR.set'];        
            if exist(sname, 'file')>0
                clear EEG;  % Clear is to make sure that we start fresh for each subject with the EEG structures
                EEG = pop_loadset('filename', [subject{s} '_cebCAR.set'], 'filepath', data_path{s}); 
                EEG = pop_epochbin( EEG , [-200.0  900.0],  'pre');               
                EEG.setname= [subject{s} '_cebCARe'];
                EEG = pop_saveset(EEG, 'filename', [EEG.setname '.set'], 'filepath', data_path{s}); 
            else
                fprintf('\n *** WARNING: %s does not exist *** \n\n', sname);
            end
        end
    else
        fprintf('\n *** WARNING: %s does not exist *** \n\n', sname);
    end
    % RT lock ERP
    if RTlock
        sname = [data_path{s} subject{s} '_RT_cebM12.set'];        
        if exist(sname, 'file')>0
            disp('Create Bin based Epoch for RT-locked: WORKING ...')
            clear EEG;  % Clear is to make sure that we start fresh for each subject with the EEG structures
            EEG = pop_loadset('filename', [subject{s} '_RT_cebM12.set'], 'filepath', data_path{s});                
            EEG = pop_epochbin( EEG , [-1100.0  500.0],  [-1100 -1000]);               
            EEG.setname= [subject{s} '_RT_cebM12e'];
            EEG = pop_saveset(EEG, 'filename', [EEG.setname '.set'], 'filepath', data_path{s});    
            if CAR
                data_path{s} = [pathname_anal subject{s} '\'];  % Path to the folder containing the current subject's data
                sname = [data_path{s} subject{s} '_RT_cebCAR.set'];        
                if exist(sname, 'file')>0
                    clear EEG;  % Clear is to make sure that we start fresh for each subject with the EEG structures
                    EEG = pop_loadset('filename', [subject{s} '_RT_cebCAR.set'], 'filepath', data_path{s}); 
                    EEG = pop_epochbin( EEG , [-1100.0  500.0],  [-1100 -1000]);               
                    EEG.setname= [subject{s} '_RT_cebCARe'];
                    EEG= pop_saveset(EEG, 'filename', [EEG.setname '.set'], 'filepath', data_path{s}); 
                else
                    fprintf('\n *** WARNING: %s does not exist *** \n\n', sname);
                end            
        else
            fprintf('\n *** WARNING: %s does not exist *** \n\n', sname);
        end
    end
    end
end

fprintf('\n+++++++++++++++\n+ Create Bin based Epoch: done! ... \n+++++++++++++++\n\n');
