%%%%%%%%%%%%%%%%%%%%%%%%%
% Setting up parameters %
%%%%%%%%%%%%%%%%%%%%%%%%%

function std_paraset

global pathname_raw chloc64 pathname_cmd file1 artparm file2 
global rawdata nraw  subject pathname_anal 
global bdf data_path

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