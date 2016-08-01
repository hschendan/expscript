%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% GRAND AVERAGE. Include standard deviation.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function std_gavg

global pathname_cmd expname pathname_gav file3

% Stimulus-locked
    clear EEG;  % Clear is to make sure that we start fresh for each subject with the EEG and ERP structures
    clear ERP;  % Clear is to make sure that we start fresh for each subject with the EEG and ERP structures
    ERP = pop_gaverager( [pathname_cmd, file3] , 'Criterion',  33, 'ExcludeNullBin', 'on', 'SEM', 'on' );
    erpname = [expname 'M12_gav'];
    fname_erp = fullfile(pathname_gav, [erpname '.erp']);  
    pop_savemyerp(ERP, 'erpname', erpname, 'filename', fname_erp, 'warning', 'off');
   % Filter gav
    ERP = pop_filterp( ERP, 1:71 , 'Cutoff', 30, 'Design', 'butter', 'Filter', 'lowpass', 'Order', 2 ); 
    erpname = [expname 'M12_gavLp30'];
    fname_erp= fullfile(pathname_gav, [erpname '.erp']);  
    pop_savemyerp(ERP, 'erpname', erpname, 'filename', fname_erp, 'warning', 'off'); 

fprintf('\n+++++++++++++++\n+ Grand Average(incl. std.): done! ... \n+++++++++++++++\n\n');