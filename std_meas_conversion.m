%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Convert ERP measurement files into .csv
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function std_meas_conversion

global pathname_meas ch64

disp('Converting .txt measurements to .csv...')
dirs = dir(pathname_meas);

for i = 1:length(dir(pathname_meas));    
    if strfind(dirs(i).name,'.txt');
        datas = readtable(dirs(i).name,'delimiter','\t');
        ncols = (height(datas)/std_erp_count);
        channels=[64,32];
        counter=1;
        bin_num=1;
        col_labs=cell(1, ncols);
        for j = 1:(ncols)
            if counter < channels(2-ch64)
                if isvarname(char(datas(j,'chlabel').chlabel))
                    col_labs{j}=strcat(char(datas(j,'chlabel').chlabel),'_',int2str((bin_num)));
                else
                    col_labs{j}=strcat('e',int2str(datas(j,'chlabel').chlabel),'_',int2str((bin_num)));
                end
                counter=counter+1; 
          
            else
                if isvarname(char(datas(j,'chlabel').chlabel))
                    col_labs{j}=strcat(char(datas(j,'chlabel').chlabel),'_',int2str((bin_num)));
                else
                    col_labs{j}=strcat('e',int2str(datas(j,'chlabel').chlabel),'_',int2str((bin_num)));
                end
                counter = 1;
                bin_num=bin_num+1;
            end
        end   
    % create new matrix - participant x electrode
    transposed_column = transpose(table2cell(datas(:,'value')));
    newTable = reshape(transposed_column,ncols, std_erp_count);
    newTable = array2table(transpose(newTable),'VariableNames',col_labs);
    disp('Writing measurements to .csv file...')
    writetable(newTable,[pathname_meas strcat(dirs(i).name(1:length(dirs(i).name)-3),'csv')],'Delimiter',',');
    end
end

    fprintf('\n+++++++++++++++\n+ ERP measurement conversion to .csv: done! ... \n+++++++++++++++\n\n');
