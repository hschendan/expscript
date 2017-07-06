diary('C:\Users\pzhao\Documents\MATLAB\standard11\diary11.txt'); %***Modify to yours ***%

disp('After modify arti for each subject, now running artifact rejection for a single subject ...')

global subject n

n=2; %modify here for the subject you want

fprintf('\n++++\n+ Begin artifact rejection for %s ... \n++++\n\n', subject{n}); 
f = strcat('std_artif_',subject{n});
fd = str2func(f);
fd(n);