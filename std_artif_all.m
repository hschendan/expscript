function std_artif_all

% after modify the arti func for each subjects, run all of them

disp('After modify arti for each subject, now running artifact rejection for all subjects ...')

global nraw subject eegrefch avg erprefch meas gavg

for s=1:nraw
        fprintf('\n++++\n+ Begin artifact rejection for %s ... \n++++\n\n', subject{s}); 
        f = cell(1, nraw);
        f = strcat('std_artif_',subject{s});
        fd = str2func(f);
        fd(s);
end

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
    
