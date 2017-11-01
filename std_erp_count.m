%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Count ERPs from erpfiles.txt
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function n = std_erp_count
% erp_count
%   Counts number of valid ERP files in erpfiles.txt

global pathname_cmd

filename=[pathname_cmd, 'erpfiles.txt'];
fid=fopen(filename);
n = 0;
tline = fgetl(fid);
while ischar(tline);
  tline = fgetl(fid);
  n = n+1;

end
end

