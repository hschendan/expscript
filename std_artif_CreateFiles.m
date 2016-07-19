function std_artif_CreateFiles

global nraw subject

% open template file for artifact detection
fidIn = fopen('C:\Users\pzhao\Documents\MATLAB\Standard\std_artif_T.m');

% read in file
tline = fgets(fidIn);
index = 1; 
while ischar(tline)
    data{index} = tline;
    tline = fgets(fidIn);         
    index = index + 1;
end

% replace first row
for s=1:nraw
    data{1,1} = strcat('function std_artif_', subject{s},'(s)');
    name = strcat('std_artif_',subject{s},'.m');
    fidOut = fopen(name,'w');

% write to new function file and save
for L = data
    fprintf(fidOut,'%s\n', L{1,1});
end
end

fclose(fidIn);
fclose(fidOut);
    