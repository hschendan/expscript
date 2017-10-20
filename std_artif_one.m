function std_artif_one

% after modify the arti func for a subject, run the artifact rejection

disp('After modify arti for each subject, now running artifact rejection for a single subject ...')

global subject n

% n=1; % modify here for the subject you want (this is now set in flags.m)

fprintf('\n++++\n+ Begin artifact rejection for %s ... \n++++\n\n', subject{n}); 
f = strcat('std_artif_',subject{n});
fd = str2func(f);
fd(n);
