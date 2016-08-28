%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Choose OPERATING SYSTEM & user's Paths & create folders
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function std_os

global Windows Linux
global pathname_all pathname_anal pathname_cmd pathname_gav pathname_meas

if Windows

    addpath(genpath(pathname_all));  %add folder and subfolders to the path
    cd(pathname_all); % change the current folder to parent folder
    
    %add & save 4 new folders to the path
    fname = {'EEG-ANAL','CMD', 'Grand', 'Measure'};  
    for s = 1: numel(fname)      
        if exist(fullfile(pathname_all, fname{s}), 'dir') == 0    %if any of 4 folders does not exist
           mkdir(pathname_all, fname{s});              % then create      
        end
    end
    
    fprintf('\n+++++++++++++++\n+ Create 4 folders: done! ... \n+++++++++++++++\n\n');
    
    % Common paths: Should be the same for all Schendan Team Experiments
    
    pathname_anal  = strcat(pathname_all,fname{1},'\'); 
    pathname_cmd  = strcat(pathname_all, fname{2},'\');
    % %pathname_savg = strcat(pathname_all,'SessionAvg\');
    pathname_gav = strcat(pathname_all, fname{3},'\');
    pathname_meas = strcat(pathname_all,fname{4},'\');
     
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

