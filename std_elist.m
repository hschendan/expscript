%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Creates ERPLab Eventlist %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function std_elist

global nraw data_path subject sfx set

disp('Using ERPLab to Create EEG Eventlist (Basic) in EEGLab file ...')

  x = 'e';

  fprintf('\n+++++++++++++++\n+ (elist) previous sfx = %s ... \n+++++++++++++++\n\n', sfx);
  
for s=1:nraw
    clear EEG;  % Clear is to make sure that we start fresh for each subject with the EEG structures
    sname = [data_path{s} subject{s} sfx set];       
    if exist(sname, 'file')>0
        
        % Load dataset
        fprintf('\n++++\n+ Loading dataset for %s ... \n++++\n\n', subject{s} );
        EEG = pop_loadset('filename', [subject{s} sfx set], 'filepath', data_path{s});                
        
      
        % Creates basic EVENTLIST (Option 1)
        fprintf('\n++++\n+ Creating basic EVENTLIST (Option 1) for %s ... \n++++\n\n', subject{s} );
        EEG = pop_creabasiceventlist(EEG, 'AlphanumericCleaning', 'on', 'BoundaryNumeric', { -99 }, 'BoundaryString', { 'boundary' }, 'Eventlist', [data_path{s} subject{s} sfx x '_list.txt'], 'Warning', 'on' );               
        
        % Advanced event list editing (Option 2)
        %EEG  = pop_editeventlist( EEG , 'AlphanumericCleaning', 'on', 'BoundaryNumeric', { -99}, 'BoundaryString', { 'boundary' }, 'ExportEL', [data_path{s} subject{s} '_e_list.txt'], 'SendEL2', 'EEG&Text', 'UpdateEEG', 'on', 'Warning', 'on' );
        %EEG  = pop_overwritevent( EEG, 'code' ); 
       
        % Save dataset
        fprintf('\n++++\n+ Saving EVENTLIST (Option 1) dataset for %s ... \n++++\n\n', subject{s} );
        
       
        EEG.setname = [subject{s} sfx x]; % name for the dataset menu
        EEG = pop_saveset(EEG, 'filename', [EEG.setname set], 'filepath', data_path{s}); 
        
    else
        fprintf('\n *** WARNING: %s does not exist *** \n\n', sname);
        fprintf('\n *** Skip all processing for this subject *** \n\n');
    end
end

sfx = [sfx x];


fprintf('\n+++++++++++++++\n+ (elist) New sfx = %s ... \n+++++++++++++++\n\n', sfx);

fprintf('\n++++++++++++++++++++++++++++++\n+ Import event info (Basic) into ERPLab from EEGLab: done! ... \n++++++++++++++++++++++++++++++\n\n');

 