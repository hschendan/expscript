function std_artif_all

% after modify the arti func for each subjects, run all of them

disp('After modify arti for each subject, now running artifact rejection for all subjects ...')

global subject

%for s=1:nraw % if want to run all subjects
% copy S # from here: for s= [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100]
for s= [1, 2, 5]; %please modify here for the subject you want to run or copy from above 2 lines
        fprintf('\n++++\n+ Begin artifact rejection for %s ... \n++++\n\n', subject{s}); 
        f = cell(1, length(s));
        f = strcat('std_artif_',subject{s});
        fd = str2func(f);
        fd(s);
end
