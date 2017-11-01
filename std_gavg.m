%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% GRAND AVERAGE. Include standard deviation.
% FILTER GRAND AVERAGE. Default low pass 30 Hz (change to yours)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function std_gavg

global pathname_cmd expname pathname_gav file3 all one M12 CA

% Set ERP suffix: M12 for mean mastoids averaged ERPs, and CA for common
% averaged ERPs
if M12
    erp_extension = 'M12_gav';
    erp_LP_extension = 'M12_gavLp30';
    channels_to_filter = [1:71];
    % channels_to_filter = [1:65];  % SAI
elseif CA
    erp_extension = 'CA_gav';
    erp_LP_extension = 'CA_gavLp30';
    channels_to_filter = [1:71,74];
    %     channels_to_filter = [1:64,65]; % SAI
else % default recording reference
    erp_extension = '_gav';
    erp_LP_extension = '_gavLp30';
    channels_to_filter = [1:71];    
    % channels_to_filter = [1:65];  SAI
end

% Stimulus-locked
    clear EEG;  % Clear is to make sure that we start fresh for each subject with the EEG and ERP structures
    clear ERP;  % Clear is to make sure that we start fresh for each subject with the EEG and ERP structures
    ERP = pop_gaverager( [pathname_cmd, file3] , 'Criterion',  33, 'ExcludeNullBin', 'on', 'SEM', 'on' );
    
    
    erpname = [expname erp_extension];
    fname_erp = fullfile(pathname_gav, [erpname '.erp']);  
    pop_savemyerp(ERP, 'erpname', erpname, 'filename', fname_erp, 'warning', 'off');
   % Filter gav
    ERP = pop_filterp( ERP, channels_to_filter , 'Cutoff', 30, 'Design', 'butter', 'Filter', 'lowpass', 'Order', 2 ); 
    erpname = [expname erp_LP_extension];
    fname_erp= fullfile(pathname_gav, [erpname '.erp']);  
    pop_savemyerp(ERP, 'erpname', erpname, 'filename', fname_erp, 'warning', 'off'); 

fprintf('\n+++++++++++++++\n+ Grand Average(incl. std.): done! ... \n+++++++++++++++\n\n');
