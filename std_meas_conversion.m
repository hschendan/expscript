%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Convert ERP measurement files into .csv
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function std_meas_conversion

global pathname_meas ch64

disp('Converting .txt measurements to .csv...')
dirs = dir(pathname_meas);

for i = 1:length(dir(pathname_meas));    
    if strfind(dirs(i).name,'All.txt');
        datas = readtable(dirs(i).name,'delimiter','\t');
        ncols = (height(datas)/std_erp_count);
        channels=[64,32];
        counter=1;
        bin_num=1;
        col_labs=cell(1, ncols);
        for j = 1:(ncols)
            if counter < channels(2-ch64)
                col_labs{j}=strcat(datas(j,'chlabel').chlabel,'_',int2str((bin_num)));
                counter=counter+1;
            else
                col_labs{j}=strcat(datas(j,'chlabel').chlabel,'_',int2str((bin_num)));
                counter = 1;
                bin_num=bin_num+1;
            end
        end
    % create new matrix - participant x electrode
    transposed_column = transpose(table2cell(datas(:,'value')));
    newTable = reshape(transposed_column,ncols, std_erp_count);
    newTable = array2table(transpose(newTable));
    % Change column names
    for new_column_names = 1:length(col_labs)
        newTable.Properties.VariableNames(new_column_names)=col_labs{new_column_names};
    end 
    disp('Writing measurements to .csv file...')
    writetable(newTable,[pathname_meas strcat(dirs(i).name(1:length(dirs(i).name)-3),'csv')],'Delimiter',',');
    end
end

    fprintf('\n+++++++++++++++\n+ ERP measurement conversion to .csv: done! ... \n+++++++++++++++\n\n');
