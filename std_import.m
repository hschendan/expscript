%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Import and translate BioSemi/Raw Data into EEGLab .set
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function std_import 

global nraw subject pathname_raw rawdata pathname_anal
	
disp('Importing biosemi data.bdf into EEGLab and saving as EEGLab sets ...')  

%copy raw data from source to destination folder 'EEG-DATA'; 
source = 'C:\Users\pzhao\Documents\MATLAB\ColorRawData'; % Modify yours
copyfile(source,fullfile(pathname_raw));   
fprintf('\n+++++++++++++++\n+ Copy %d raw data to EEG-DATA folder: done! ... \n+++++++++++++++\n\n', nraw);

for s=1:nraw
    fprintf('\n******\nProcessing subject %s\n******\n\n', subject{s});
    EEG = pop_biosig([pathname_raw rawdata{s}]);
    EEG = eeg_checkset( EEG );
    data_path = [pathname_anal subject{s} '\'];  % Path to the folder containing the current subject's data
    EEG = pop_saveset( EEG, 'filename', [subject{s} '.set'],'filepath', data_path);
    EEG = eeg_checkset( EEG );   
end
   
fprintf('\n+++++++++++++++\n+ Import: done! ... \n+++++++++++++++\n\n');
    