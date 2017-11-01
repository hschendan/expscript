%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Basic Filtering for ERP with Low Pass Pg. 36
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function std_erpfilt

%global nraw data_path subject ch64 sfx set
global M12 nraw pathname_all data_path subject CA ch64 all one s n

   
disp('ERP Filter: Working ...')

% currently, default load is armM: 
% M12 vs. CA not fully implemented; need to change below to load armM or arCA; 
if M12
    erp_ext = '_armMf';
    ref_type = 'MASTOIDS';
elseif CA
    erp_ext = '_arCAf';
    ref_type = 'COMMON AVERAGE';
else
    erp_ext = '_arf';
    ref_type = 'RECORDING REF';
end

if one
    % NOT IMPLEMENTED: to script copy one section from erprefch.m
end

if all   
    %for s=1:nraw %   
     for s=[18 28 35]
%    for s=20 % one subject quick solution
        sname = [data_path{s} subject{s} '_armM.erp'];
        if exist(sname, 'file')>0
            clear ERP;  % Clear is to make sure that we start fresh for each subject with the EEG and ERP structures
            if M12
                ERP = pop_loaderp('filename', [subject{s} '_armM.erp'] , 'filepath', data_path{s});
            elseif CA
                ERP = pop_loaderp('filename', [subject{s} '_arCA.erp'] , 'filepath', data_path{s});
            else
                ERP = pop_loaderp('filename', [subject{s} '_ar.erp'] , 'filepath', data_path{s});
            end
            % SAI
            ERP = pop_filterp( ERP,  1:65 , 'Cutoff',  40, 'Design', 'butter', 'Filter', 'lowpass', 'Order',  2 );
            % BIOSEMI
%           ERP = pop_filterp( ERP,  1:71 , 'Cutoff',  30, 'Design', 'butter', 'Filter', 'lowpass', 'Order',  2 );
%            else    % 32 channel
%                ERP = pop_filterp( ERP,  1:39 , 'Cutoff',  30, 'Design', 'butter', 'Filter', 'lowpass', 'Order',  2 );
%            end
     
            %ERP = pop_erpchanoperator( ERP, erpREFtext , 'ErrorMsg', 'popup' );
            % ERP = pop_erpchanoperator( ERP, [pathname_all 'ERPref64M12.txt'] , 'ErrorMsg', 'popup' );
            erpname = [subject{s} erp_ext];  % name for erpset menu
            fname_erp = fullfile(data_path{s}, [erpname '.erp']);
            pop_savemyerp(ERP, 'erpname', erpname, 'filename', fname_erp, 'Warning', 'off');
        else
            fprintf('\n *** WARNING: %s does not exist *** \n\n', sname);
        end
    end
fprintf('\n+++++++++++++++\n+ ERP Filter %s: done! ... \n+++++++++++++++\n\n',ref_type);
end

    
end