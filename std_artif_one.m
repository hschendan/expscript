function std_artif_one

% after modify the arti func for a subject, run the artifact rejection

disp('After modify arti for each subject, now running artifact rejection for a single subject ...')

global subject eegrefch avg erprefch meas gavg n

n=1; %modify here for the subject you want

fprintf('\n++++\n+ Begin artifact rejection for %s ... \n++++\n\n', subject{n}); 
f = strcat('std_artif_',subject{n});
fd = str2func(f);
fd(n);

% Optional: For EEGLab processing only; NOT part of standard ERP processing. NOTE: NEVER RE-REFERENCE TWICE.
if eegrefch
   std_eegrefch 
end

%Average ERP
if avg
    std_avg 
end

%ERPrefch: NOTE: NEVER RE-REFERENCE TWICE.
if erprefch
    std_erprefch
end

%Measure ERPs
if meas
    std_meas
end

%GRAND AVERAGE. Include standard deviation.
if gavg
    std_gavg 
end
