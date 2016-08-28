
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Artifact Detection & artifact-free average
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function  std_artif 

global nraw subject sfx

disp('Artifact detection: starting ...')

fprintf('\n+++++++++++++++\n+ (artif) Previous sfx = %s ... \n+++++++++++++++\n\n', sfx);


for s=1:nraw

    if exist(['std_artif_' subject{s} '.m'], 'file') % check if each subjects' artifect function exist
       fprintf('\n+++++++++++++++\n+ std_artif_%s already exist! \n+++++++++++++++\n\n', subject{s}); 
    else
        std_artif_CreateFiles; 
        fprintf('\n+++++++++++++++\n+ std_artif_%s created! \n+++++++++++++++\n\n', subject{s});
    end
end

fprintf('\n+++++++++++++++\n+ Create artifact detection file for each subject: done...\n+++++++++++++++\n\n')
    
% run subjects' arti functions, you may need to modify the functions before run this
fprintf('\n+++++++++++++++\n+ Please modify the arti func for each subject before run artif_all ... \n+++++++++++++++\n\n');  


