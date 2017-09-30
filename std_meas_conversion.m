%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Convert ERP measurement files into .csv
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function std_meas_conversion

global pathname_meas ch64

channels=[64,32];
disp('Converting .txt measurements to .csv...')
dirs = dir(pathname_meas);
counter=1;

col_labs={};
for i = 1:length(dir(pathname_meas));
    
    if strfind(dirs(i).name,'All.txt');
        datas = readtable(dirs(i).name,'delimiter','\t');
        ncols = (height(datas)/std_erp_count)  ;      
        for j = 1:(ncols)
            if counter < channels(2-ch64)
                col_labs{j}={strcat(char(datas(j,'chlabel').chlabel),'_',int2str((counter)))};
                counter=counter+1;
            else
                col_labs{j}={strcat(char(datas(j,'chlabel').chlabel),'_',int2str((counter)))};
                counter = 1;
            end
        end
    
    % create new matrix - participant x electrode
    transposed_column = transpose(table2cell(datas(:,'value')));
    newTable = reshape(transposed_column,ncols, std_erp_count);
    newTable = transpose(newTable);
    newTable = array2table(newTable);
%     newTable.Properties.VariableNames={transpose(col_labs)};
    disp('Writing measurements to .csv file...')
    writetable(newTable,[pathname_meas strcat(dirs(i).name(1:length(dirs(i).name)-3),'csv')],'Delimiter',',');

    end
end

%     fprintf('\n+++++++++++++++\n+ No files to move: exiting! ... \n+++++++++++++++\n\n');


%     for i = 1:length(dir(pathname_meas,txtfiles))
%     dir
% end



    fprintf('\n+++++++++++++++\n+ Measure ERPs: done! ... \n+++++++++++++++\n\n');
