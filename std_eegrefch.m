function std_eegrefch

global m12 nraw data_path subject ch64 set ca s n all one

sfx = '_ebcpya';   %initialise sfx, please modify it yourself

disp('EEG Reference: WORKING ...')

if one
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Reference to average of M1 and M2 (average mastoids) for EEG % 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if m12             
       x = 'aM';   
       sname = [data_path{n} subject{n} sfx set];        
       if exist(sname, 'file')>0
            clear EEG;  % Clear is to make sure that we start fresh for each subject with the EEG structures
            EEG = pop_loadset('filename', [subject{n} sfx set], 'filepath', data_path{n});
            if ch64 % 64 channel cap
                EEG = pop_reref( EEG, [68 69],'keepref','on'); % reference to mean of M1 and M2
            else    % 32 channel cap
                EEG = pop_reref( EEG, [36 37],'keepref','on');
            end
            EEG.setname= [subject{n} sfx x];
            EEG = pop_saveset(EEG, 'filename', [EEG.setname set], 'filepath', data_path{n});
        else
            fprintf('\n *** WARNING: %s does not exist *** \n\n', sname);
        end
    end
    
    fprintf('\n+++++++++++++++\n+ Re-Referenced to M1&M2 for EEG: done! ... \n+++++++++++++++\n\n');
 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Reference to common average for EEG %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    if ca           
        x = 'ca';  
        sname = [data_path{n} subject{n} sfx set];        
        if exist(sname, 'file')>0
            clear EEG;  % Clear is to make sure that we start fresh for each subject with the EEG structures
            EEG = pop_loadset('filename', [subject{n} sfx set], 'filepath', data_path{n}); 
            EEG = pop_reref( EEG, []); % Common average reference,
             %EEG = pop_reref( EEG, [],'exclude',[65:67] ); % Common average reference for 64 ch, exclude HE1, HE2, LE
            EEG.setname= [subject{n} sfx x];
            EEG= pop_saveset(EEG, 'filename', [EEG.setname '.set'], 'filepath', data_path{n}); 
        else
        fprintf('\n *** WARNING: %s does not exist *** \n\n', sname);
        end
    end
   
    fprintf('\n+++++++++++++++\n+ Re-Referenced to common average for EEG: done! ... \n+++++++++++++++\n\n');
    
end


if all

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Reference to average of M1 and M2 (average mastoids) for EEG % 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    if m12             
    x = 'aM';   
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
    
    fprintf('\n+++++++++++++++\n+ Re-Referenced to M1&M2 for EEG: done! ... \n+++++++++++++++\n\n');
    end
 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Reference to common average for EEG %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if ca           
    x = 'ca';  
    for s=1:nraw
        sname = [data_path{s} subject{s} sfx set];        
        if exist(sname, 'file')>0
            clear EEG;  % Clear is to make sure that we start fresh for each subject with the EEG structures
            EEG = pop_loadset('filename', [subject{s} sfx set], 'filepath', data_path{s}); 
            EEG = pop_reref( EEG, []); % Common average reference,
             %EEG = pop_reref( EEG, [],'exclude',[65:67] ); % Common average reference for 64 ch, exclude HE1, HE2, LE
            EEG.setname= [subject{s} sfx x];
            EEG= pop_saveset(EEG, 'filename', [EEG.setname '.set'], 'filepath', data_path{s}); 
        else
        fprintf('\n *** WARNING: %s does not exist *** \n\n', sname);
        end
    end
   
    fprintf('\n+++++++++++++++\n+ Re-Referenced to common average for EEG: done! ... \n+++++++++++++++\n\n');
    
end 
end
    