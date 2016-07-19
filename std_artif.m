
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Artifact Detection & artifact-free average
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function  std_artif

disp('Artifact detection: Working ...')

if exist('std_artif_S52.m', 'file')== 0 % check if the last subjects' artifect function exist
    
    std_artif_CreateFiles; 
    
else
    
    fprintf('\n+++++++++++++++\n+ Create artifact detection file for each subject: done...\n+++++++++++++++\n\n')
    
end  % run subjects' arti functions, you may need to modify the functions before run this
    
  fprintf('\n+++++++++++++++\n+ Please modify the arti func for each subjects, then run artif_all ... \n+++++++++++++++\n\n');  


