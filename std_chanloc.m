%%%%%%%%%%%%%%%%%%%%%%%%%
% Add Channel Locations %
%%%%%%%%%%%%%%%%%%%%%%%%%
function std_chanloc

global nraw data_path subject ch64 pathname_cmd file1

for s=1:nraw
    sname = [data_path{s} subject{s} '.set'];        
    if exist(sname, 'file')>0
        disp('Add channel locations: WORKING! ...')
        clear EEG;  % Clear is to make sure that we start fresh for each subject with the EEG structures
        EEG = pop_loadset('filename', [subject{s} '.set'], 'filepath', data_path{s});                
        if ch64 % 64 channel cap            
            %EEG=pop_chanedit(EEG, 'load',{'/home/schendan/ERPDATA/Color/EEG-ANAL/CMD/biosemi64xyz10-20.xyz' 'filetype' 'xyz'});
            EEG = pop_chanedit(EEG, 'load', { [pathname_cmd file1] 'filetype' 'xyz'});
            %EEG=pop_chanedit(EEG, 'load', { chloc, 'filetype' 'xyz'});
            %chloc = {'biosemi64xyz10-20.xyz'};  % Not implemented: filename of channel location file, script default is matlab xyz format
            %EEG=pop_chanedit(EEG, 'load', { [pathname_cmd chloc] 'filetype' 'xyz'});
            fprintf('\n++++\n+ Adding 64 channel locations for %s ... \n++++\n\n', subject{s} );
        else % 32 channel cap           EEG.setname= [subject{s} '_ebec'];
            EEG = pop_chanedit(EEG, 'load', { [pathname_cmd file1] 'filetype' 'xyz'});
            fprintf('\n++++\n+ Adding 32 channel locations for %s ... \n++++\n\n', subject{s} );
        end
        EEG.setname= [subject{s} '_c'];
        EEG = pop_saveset(EEG, 'filename', [EEG.setname '.set'], 'filepath', data_path{s});   
        fprintf('\n++++\n+ Saving channel locations dataset for %s ... \n++++\n\n', subject{s} );
    else
        fprintf('\n *** WARNING: %s does not exist *** \n\n', sname);
    end
end

fprintf('\n+++++++++++++++\n+ Add Channel Locations: done! ... \n+++++++++++++++\n\n');