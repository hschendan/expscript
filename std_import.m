%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Import and translate BioSemi/Raw Data into EEGLab .set
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function std_import 

global copydata pathname_all nraw subject pathname_raw rawdata data_path set
	
disp('Importing biosemi data.bdf into EEGLab and saving as EEGLab sets ...')  

sfx = '_';

if copydata  % it is optional to copy data to a folder%
    
    fname = 'EEG-DATA-COPY';
    if exist(fullfile(pathname_all, fname, 'dir')) == 0    %if the folder does not exist
       mkdir(pathname_all, fname);              % then create new folder in parent folder      
    end
    
    pathname_copy  = strcat(pathname_all, fname,'\');     % where raw bdfs are copied
    
    for s = 1:nraw
        if exist(rawdata{s}, 'file')== 0 
            copyfile([pathname_raw rawdata{s}],fullfile(pathname_copy));  
            fprintf('\n+++++++++++++++\n+ copy raw data %s to EEG-DATA folder... \n+++++++++++++++\n\n', rawdata{s});
        else
            fprintf('\n+++++++++++++++\n+ raw data %s already exist! \n+++++++++++++++\n\n', rawdata{s});
        end
    end
    
    fprintf('\n+++++++++++++++\n+ Copy %d raw data to the folder EEG-DATA-COPY: done! ... \n+++++++++++++++\n\n', nraw);
end 

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

fprintf('\n+++++++++++++++\n+ Import: done! ... \n+++++++++++++++\n\n');
    