%%%%%%%%%%%%%%%%%%%%%%%%%
% Setting up parameters %
%%%%%%%%%%%%%%%%%%%%%%%%%

function std_paraset

global chloc64 pathname_cmd file1 artparm file2 
global rawdata nraw  subject pathname_anal 
global bdf data_path

rawdata = {'color_s01.1_A11F-Deci.bdf' 'color_S02_A12R-Deci.bdf' 'color_S03_B21R-Deci.bdf' 'color_S04_B22R-Deci.bdf' 'color_S05_A21R-Deci.bdf' 'color_S06_B12F-Deci.bdf' 'color_S07_A22R-Deci.bdf' 'color_S08_B11F-Deci.bdf' 'color_S09_A12F-Deci.bdf' 'color_S10_B22F-Deci.bdf' 'Color_S11_B21F-Deci.bdf' 'Color_S12_A11R-Deci.bdf' 'color_S13_B11R-Deci.bdf' 'Color_S14_A22F-Deci.bdf' 'color_S15_B12R-Deci.bdf' 'Color_S16_A21F-Deci.bdf' 'Color_S17_A11F-Deci.bdf' 'Color_S18_A12R-Deci.bdf' 'Color_S19_B21R-Deci.bdf' 'Color_S20_B22R-Deci.bdf' 'Color_S21_A21R-Deci.bdf' 'Color_S22_B12F-Deci.bdf' 'Color_S23_A22R-Deci.bdf' 'Color_S24_B11F-Deci.bdf' 'Color_S25_A12F-Deci.bdf' 'Color_S26_B22F-Deci.bdf' 'Color_S27_B21F-Deci.bdf' 'Color_S28_A11R-Deci.bdf' 'Color_S29_B11R-Deci.bdf' 'Color_S30_A22F-Deci.bdf' 'Color_S31_B12R-Deci.bdf' 'Color_S32_A21F-Deci.bdf' 'Color_S33_B22R_Replace_S04-Deci.bdf' 'Color_S34_A22F_Replace_14-Deci.bdf' 'Color_S35_B12R_Replace_S15-Deci.bdf' 'Color_S36_A11F-Deci512.bdf' 'Color_S37_A12R-Deci512.bdf' 'Color_S38_B21R-Deci512.bdf' 'Color_S39_B22R-Deci512.bdf' 'Color_S40_A21R-Deci512.bdf' 'Color_S41_B12F-Deci512.bdf' 'Color_S42_A22R-Deci512.bdf' 'Color_S43_B11F-Deci512.bdf' 'Color_S44_A12F-Deci512.bdf' 'Color_S45_B22F-Deci512.bdf' 'Color_S46_B21F-Deci512.bdf' 'Color_S47_A11R-Deci512.bdf' 'Color_S48_B11R-Deci512.bdf' 'Color_S49_A22F-Deci512.bdf' 'Color_S50_B12R-Deci512.bdf' 'Color_S51_A21F-Deci512.bdf' 'Color_S52_A22R_Replace_S42-Deci512.bdf' };
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
     
%copy 4 files:  from source to destination folder 'CMD'; 
source = 'C:\Users\pzhao\Documents\MATLAB\4Files';  % **Modify to yours ** %
copyfile(source,fullfile(pathname_cmd));
    
fprintf('\n+++++++++++++++\n+ Copy 4 files to CMD folder: done! ... \n+++++++++++++++\n\n');

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

data_path = cell(5,1);
for s = 1:nraw
    data_path(s) = cellstr([pathname_anal subject{s} '\']);  % Path to the folder containing the current subject's data
end

fprintf('\n+++++++++++++++\n+ Set up parameters: done! ... \n+++++++++++++++\n\n');