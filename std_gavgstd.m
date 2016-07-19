
function std_gavgstd

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% GRAND AVERAGE. Include standard deviation.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global pathname_cmd file3 pathname_gav

% Stimulus-locked
%    clear EEG;  % Clear is to make sure that we start fresh for each subject with the EEG and ERP structures
clear ERP;  % Clear is to make sure that we start fresh for each subject with the EEG and ERP structures
ERP = pop_gaverager('Loadlist', [pathname_cmd, file3] , 'Criterion',  33, 'ExcludeNullBin', 'on', 'SEM', 'on' );
%ERP = pop_gaverager( '/home/schendan/ERPDATA/Color/EEG-ANAL/CMD/erpfiles.txt' , 'Criterion',  33, 'ExcludeNullBin', 'on', 'SEM',... 'on' );
%ERP = pop_savemyerp(ERP, 'erpname', 'gav', 'filename', 'gav.erp', 'filepath', '/home/schendan/ERPDATA/Color/EEG-ANAL', 'Warning',... 'on');

%ERP = pop_gaverager( 'ERPindex', 'Loadlist', [pathname_gav, 'erpfiles.txt'], 'Stdev', 'on', 'Warning', 'off' );
%            erpname = 'UnTaskM12_gav'; 
pop_savemyerp(ERP, 'erpname', erpname, 'filename', fname_erp, 'warning', 'off')
%pop_savemyerp(ERP, 'erpname', 'UnTaskM12_ar_gav', 'filename', [erpname, '.erp'], 'filepath', pathname_gav, 'warning', 'off');
%FILTER GRAND AVERAGE
%ERP = pop_filterp( ERP,1:71 , 'Cutoff',30, 'Design', 'butter', 'Filter', 'lowpass', 'Order',2 ); 
 %           erpname = 'UnTaskM12_gav_lp30Hz';  % name for erpset menu
  %          fname_erp= fullfile(pathname_gav, [erpname '.erp']);  
   %         pop_savemyerp(ERP, 'erpname', erpname, 'filename', fname_erp, 'warning', 'off'); 
% LRP
clear ERP;  % Clear is to make sure that we start fresh for each subject with the EEG and ERP structures
ERP = pop_gaverager('ERPindex', 'Loadlist', [pathname_gav, 'lrpfiles.txt'], 'Stdev', 'on', 'Warning', 'off' );
            erpname = 'UnTaskM12_LRP_gav'; 
            fname_erp= fullfile(pathname_gav, [erpname '.erp']);  
            pop_savemyerp(ERP, 'erpname', erpname, 'filename', fname_erp, 'warning', 'off')
%FILTER GRAND AVERAGE LRP
ERP = pop_filterp( ERP,1:27 , 'Cutoff',30, 'Design', 'butter', 'Filter', 'lowpass', 'Order',2 ); 
            erpname = 'UnTaskM12_LRP_gav_lp30'; 
            fname_erp= fullfile(pathname_gav, [erpname '.erp']);  
            pop_savemyerp(ERP, 'erpname', erpname, 'filename', fname_erp, 'warning', 'off')


% RT-locked 1
%    clear EEG;  % Clear is to make sure that we start fresh for each subject with the EEG and ERP structures
clear ERP;  % Clear is to make sure that we start fresh for each subject with the EEG and ERP structures
ERP = pop_gaverager( 'ERPindex', 'Loadlist', [pathname_gav, 'erpfilesRTlock1.txt'], 'Stdev', 'on', 'Warning', 'off' );
            erpname = 'UnTaskM12RTlock1_gav'; 
            fname_erp= fullfile(pathname_gav, [erpname '.erp']);  
            pop_savemyerp(ERP, 'erpname', erpname, 'filename', fname_erp, 'warning', 'off')
%FILTER GRAND AVERAGE
ERP = pop_filterp( ERP, 1:71, 'Cutoff',30, 'Design', 'butter', 'Filter', 'lowpass', 'Order',2 );
            erpname = 'UnTaskM12RTlock1_gav_lp30Hz';  % name for erpset menu
            fname_erp= fullfile(pathname_gav, [erpname '.erp']);  
            pop_savemyerp(ERP, 'erpname', erpname, 'filename', fname_erp, 'warning', 'off'); 
% LRP
clear ERP;  % Clear is to make sure that we start fresh for each subject with the EEG and ERP structures
ERP = pop_gaverager('ERPindex', 'Loadlist', [pathname_gav, 'lrpfilesRTlock1.txt'], 'Stdev', 'on', 'Warning', 'off' );
            erpname = 'UnTaskM12RTlock1_gavLRP'; 
            fname_erp= fullfile(pathname_gav, [erpname '.erp']);  
            pop_savemyerp(ERP, 'erpname', erpname, 'filename', fname_erp, 'warning', 'off')
%FILTER GRAND AVERAGE LRP
ERP = pop_filterp( ERP, 1:27, 'Cutoff',30, 'Design', 'butter', 'Filter', 'lowpass', 'Order',2 );
            erpname = 'UnTaskM12RTlock1_gavLRP_lp30'; 
            fname_erp= fullfile(pathname_gav, [erpname '.erp']);  
            pop_savemyerp(ERP, 'erpname', erpname, 'filename', fname_erp, 'warning', 'off')          

% RT-locked 2
%    clear EEG;  % Clear is to make sure that we start fresh for each subject with the EEG and ERP structures
clear ERP;  % Clear is to make sure that we start fresh for each subject with the EEG and ERP structures
ERP = pop_gaverager( 'ERPindex', 'Loadlist', [pathname_gav, 'erpfilesRTlock2.txt'], 'Stdev', 'on', 'Warning', 'off' );
            erpname = 'UnTaskM12RTlock2_gav'; 
            fname_erp= fullfile(pathname_gav, [erpname '.erp']);  
            pop_savemyerp(ERP, 'erpname', erpname, 'filename', fname_erp, 'warning', 'off')
%FILTER GRAND AVERAGE
ERP = pop_filterp( ERP, 1:71, 'Cutoff',30, 'Design', 'butter', 'Filter', 'lowpass', 'Order',2 );
            erpname = 'UnTaskM12RTlock2_gav_lp30Hz';  % name for erpset menu
            fname_erp= fullfile(pathname_gav, [erpname '.erp']);  
            pop_savemyerp(ERP, 'erpname', erpname, 'filename', fname_erp, 'warning', 'off'); 
% LRP
clear ERP;  % Clear is to make sure that we start fresh for each subject with the EEG and ERP structures
ERP = pop_gaverager('ERPindex', 'Loadlist', [pathname_gav, 'lrpfilesRTlock2.txt'], 'Stdev', 'on', 'Warning', 'off' );
            erpname = 'UnTaskM12RTlock2_gavLRP'; 
            fname_erp= fullfile(pathname_gav, [erpname '.erp']);  
            pop_savemyerp(ERP, 'erpname', erpname, 'filename', fname_erp, 'warning', 'off')
%FILTER GRAND AVERAGE LRP
ERP = pop_filterp( ERP, 1:27, 'Cutoff',30, 'Design', 'butter', 'Filter', 'lowpass', 'Order',2 );
            erpname = 'UnTaskM12RTlock2_gavLRP_lp30'; 
            fname_erp= fullfile(pathname_gav, [erpname '.erp']);  
            pop_savemyerp(ERP, 'erpname', erpname, 'filename', fname_erp, 'warning', 'off')
end
    
