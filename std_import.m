%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Import and translate BioSemi/Raw Data into EEGLab .set
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function std_import 

global nraw subject pathname_raw rawdata data_path sfx set
	
disp('Importing biosemi data.bdf into EEGLab and saving as EEGLab sets ...')  

%copy raw data from source to destination folder 'EEG-DATA'; 
source = 'C:\Users\pzhao\Documents\MATLAB\ColorRawData'; % ** Modify to yours ** %

sfx = '_'; %initial suffix

for s = 1:nraw
    
    if exist(rawdata{s}, 'file')== 0 
      copyfile([source '\' rawdata{s}],fullfile(pathname_raw));  
      fprintf('\n+++++++++++++++\n+ copy raw data %s to EEG-DATA folder... \n+++++++++++++++\n\n', rawdata{s});

    else
      fprintf('\n+++++++++++++++\n+ raw data %s already exist! \n+++++++++++++++\n\n', rawdata{s});
    end
end

fprintf('\n+++++++++++++++\n+ Copy %d raw data to EEG-DATA folder: done! ... \n+++++++++++++++\n\n', nraw);

for s=1:nraw
    if exist([subject{s} sfx set], 'file')== 0 || exist([subject{s} sfx '.fdt'], 'file')== 0
        fprintf('\n******\nProcessing subject %s\n******\n\n', subject{s});
        EEG = pop_biosig([pathname_raw rawdata{s}]);
        EEG = eeg_checkset( EEG );
        EEG = pop_saveset( EEG, 'filename', [subject{s} sfx set],'filepath', data_path{s});
        EEG = eeg_checkset( EEG );   
    else 
        fprintf('\n+++++++++++++++\n+ Processed data %s already exist! \n+++++++++++++++\n\n', [subject{s} sfx set]);
    end 
end

fprintf('\n+++++++++++++++\n+ (import) initial sfx = %s ... \n+++++++++++++++\n\n', sfx);

fprintf('\n+++++++++++++++\n+ Import: done! ... \n+++++++++++++++\n\n');
    