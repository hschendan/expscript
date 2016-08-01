function std_artif_all

% after modify the arti func for each subjects, run all of them

disp('After modify arti for each subject, now running artifact rejection for all subjects ...')

global nraw subject sfx x

fprintf('\n+++++++++++++++\n+ (artif_all) Previous sfx = %s ... \n+++++++++++++++\n\n', sfx);

x = 'a';

for s=1:nraw
        fprintf('\n++++\n+ Begin artifact rejection for %s ... \n++++\n\n', subject{s}); 
        f = cell(1, nraw);
        f = strcat('std_artif_',subject{s});
        fd = str2func(f);
        fd(s);
end

sfx = [sfx x];

fprintf('\n+++++++++++++++\n+ (artif_all) New sfx = %s ... \n+++++++++++++++\n\n', sfx);
