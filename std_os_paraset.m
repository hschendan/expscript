function std_os_paraset

global Windows Linux
global pathname_all pathname_anal pathname_cmd pathname_gav pathname_meas pathname_beh

global pathname_raw chloc64 file1 artparm file2 
global rawdata nraw  subject 
global bdf data_path

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Choose OPERATING SYSTEM & user's Paths & create folders
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if Windows

    addpath(genpath(pathname_all));  %add folder and subfolders to the path
    cd(pathname_all); % change the current folder to parent folder
    
    %add & save 5 new folders to the path
    fname = {'EEG-ANAL','CMD', 'Grand', 'Measure', 'BEH-ANAL'};  
    for s = 1: numel(fname)      
        if exist(fullfile(pathname_all, fname{s}), 'dir') == 0    %if any of 4 folders does not exist
           mkdir(pathname_all, fname{s});              % then create      
        end
    end

        
    fprintf('\n+++++++++++++++\n+ Create folders: done! ... \n+++++++++++++++\n\n');
    
    % Common paths: Should be the same for all Schendan Team Experiments
    
    pathname_anal  = strcat(pathname_all,fname{1},'\'); 
    pathname_cmd  = strcat(pathname_all, fname{2},'\');
    % %pathname_savg = strcat(pathname_all,'SessionAvg\');
    pathname_gav = strcat(pathname_all, fname{3},'\');
    pathname_meas = strcat(pathname_all,fname{4},'\');
    pathname_beh = strcat(pathname_all,fname{5},'\'); 
        
    if exist(fullfile(pathname_beh, 'BLO/'), 'dir') == 0 
        mkdir(pathname_beh, 'BLO/'); 
    end  
    if exist(fullfile(pathname_beh, 'RT/'), 'dir') == 0 
        mkdir(pathname_beh, 'RT/'); 
    end
    
    % WINDOWS END

fprintf('\n+++++++++++++++++++++++\n+ Choose OS & users path: done! ... \n+++++++++++++++++++++++\n\n');     

end

%%%%%%%%%

if Linux

    %Common paths: Should be the same for all Schendan Team Experiments
    %pathname_raw  = '...../EEG-DATA/');  %where original biosemi or raw datafiles are
    pathname_anal  = strcat(pathname_all,'EEG-ANAL/'); %where intermediate data and analysis command files are
    pathname_cmd  = strcat(pathname_anal,'CMD/');
    % pathname_savg = strcat(pathname_anal,'SessionAvg/'); % UNCOMMENT if needed: only for multi-session experiments
    pathname_gav = strcat(pathname_anal,'GRAND/');
    pathname_meas = strcat(pathname_anal,'MEASURE/');
    %LINUX END 
end

%%%%%%%%%%%%%%%%%%%%%%%%%
% Setting up parameters %
%%%%%%%%%%%%%%%%%%%%%%%%%

list = dir(fullfile([pathname_raw '*.bdf']));
sname = {list.name};
expression =  'color_s'; % modify to the string which precede the sequence number in the file name of your experiment
replace = '';
sname_rearranged = regexprep(sname, expression, replace, 'ignorecase'); 
[sname_rearranged_sorted, idx_sorted] = sort(sname_rearranged);

rawdata = sname(idx_sorted) % please check if it gives the right sequence for your experiment

nraw = length(rawdata); % number of BioSemi bdf or raw datafiles, based on number of files defined as rawdata

% filenames to create in EEGLab for each subject (when translating from raw/biosemi to EEGLab

subject = cellstr(num2str([1:nraw].','S%02d')); % create subject array from S01 to S52
for s = 1:nraw; 
    if exist(fullfile(pathname_anal, subject{s}), 'dir') == 7 %if any of 52 folders exist
        fprintf('\n+++++++++++++++ subfolder %s already exist+++++++++++++++\n\n',subject{s});   
    elseif exist(fullfile(pathname_anal, subject{s}), 'dir') == 0 % if any of 52 folders does not exist   
        mkdir(fullfile(pathname_anal), subject{s}); % then create the new folder
        fprintf('\n+++++++++++++++ subfolder %s created +++++++++++++++\n\n', subject{s});
    end
end
    
fprintf('\n+++++++++++++++\n+ Create %d subjects subfolders: done! ... \n+++++++++++++++\n\n', nraw);
     
%copy 3 files:  from source to destination folder 'CMD'; 
source = 'C:\Users\pzhao\Documents\MATLAB\3Files';  % **Modify to yours ** %
copyfile(source,fullfile(pathname_cmd));
fprintf('\n+++++++++++++++\n+ Copy 3 files to CMD folder: done! ... \n+++++++++++++++\n\n');

%create erpfiles.txt
fileID = fopen([pathname_cmd 'erpfiles.txt'], 'w');
for s = 1:nraw
    fprintf(fileID, '%s\n', [pathname_anal subject{s} '\' subject{s} '_ar.erp']);
end
fclose(fileID);
fprintf('\n+++++++++++++++\n+ Creating erpfiles.txt to CMD folder: done! ... \n+++++++++++++++\n\n');

data_path = cell(5,1);
for s = 1:nraw
    data_path(s) = cellstr([pathname_anal subject{s} '\']);  % Path to the folder containing the current subject's data
end

chloc64 = strcat(pathname_cmd, file1);  % Not implemented: filename of channel location file, script default is matlab xyz format
artparm = load(strcat(pathname_cmd, file2));  
%artparmRT = load('garvparm2.txt'); 
% * CHANGE * replace with # bins in bin descriptor file for this experiment

    
% * CHANGE * filename of bdf file for each experiment, depending on whether 
% bin descriptor file = bdf
% (A) same bdf for all subjects or 
% (B) each subject or group has a different bdf file
% UNCOMMENT A or B, and specify filename(s) for each experiment

% (A) same bdf for all subjects
bdf = cellstr(repmat('bdf.txt', nraw, 1)); % create an array of 52 strings {'bdf.txt' 'bdf.txt' ...}

% (B) each subject or group has a different bdf file
% bdf = {'inny-test.txt' 'inny-test.txt' 'inny-test.txt' 'inny-test.txt' 'inny-test.txt' 'inny-test.txt' 'inyn-test.txt' 'inyn-test.txt' 'inyn-test.txt' 'inyn-test.txt' 'inyn-test.txt' 'inyn-test.txt' 'otny-test.txt' 'otny-test.txt' 'otny-test.txt' 'otny-test.txt' 'otny-test.txt' 'otny-test.txt' 'otyn-test.txt' 'otyn-test.txt' 'otyn-test.txt' 'otyn-test.txt' 'otyn-test.txt' 'otyn-test.txt'}; % B: Different bdf all/some subjects 

fprintf('\n+++++++++++++++\n+ Set up parameters: done! ... \n+++++++++++++++\n\n');



