%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Measure ERPs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function std_meas

global pathname_cmd allbins pathname_meas

disp('Measuring ERPs ...')
% Measure the mean amplitude in all bins at all channels
% Save the results in a variable named "values" and in a file in the Measurement folder for the experiment
    values = pop_geterpvalues( {'Loadlist', [pathname_cmd, 'erpfiles.txt']}, [ 95 115], [1:allbins], 1:64, 'Baseline', 'pre', 'Binlabel', 'on', 'FileFormat', 'long', 'Filename', [pathname_meas '95-115_All.txt'], 'Fracreplace', 'NaN', 'InterpFactor', 1, 'Measure', 'meanbl', 'Resolution',6, 'Warning', 'off' );
    values = pop_geterpvalues( {'Loadlist', [pathname_cmd, 'erpfiles.txt']}, [ 120 140], [1:allbins], 1:64, 'Baseline', 'pre', 'Binlabel', 'on', 'FileFormat', 'long', 'Filename', [pathname_meas '120-140_All.txt'], 'Fracreplace', 'NaN', 'InterpFactor', 1, 'Measure', 'meanbl', 'Resolution',6, 'Warning', 'off' );
    values = pop_geterpvalues( {'Loadlist', [pathname_cmd, 'erpfiles.txt']}, [ 145 160], [1:allbins], 1:64, 'Baseline', 'pre', 'Binlabel', 'on', 'FileFormat', 'long', 'Filename', [pathname_meas '145-160_All.txt'], 'Fracreplace', 'NaN', 'InterpFactor', 1, 'Measure', 'meanbl', 'Resolution',6, 'Warning', 'off' );
    values = pop_geterpvalues( {'Loadlist', [pathname_cmd, 'erpfiles.txt']}, [ 200 299], [1:allbins], 1:64, 'Baseline', 'pre', 'Binlabel', 'on', 'FileFormat', 'long', 'Filename', [pathname_meas '200-299_All.txt'], 'Fracreplace', 'NaN', 'InterpFactor', 1, 'Measure', 'meanbl', 'Resolution',6, 'Warning', 'off' );
    values = pop_geterpvalues( {'Loadlist', [pathname_cmd, 'erpfiles.txt']}, [ 300 399], [1:allbins], 1:64, 'Baseline', 'pre', 'Binlabel', 'on', 'FileFormat', 'long', 'Filename', [pathname_meas '300-399_All.txt'], 'Fracreplace', 'NaN', 'InterpFactor', 1, 'Measure', 'meanbl', 'Resolution',6, 'Warning', 'off' );
    values = pop_geterpvalues( {'Loadlist', [pathname_cmd, 'erpfiles.txt']}, [ 400 499], [1:allbins], 1:64, 'Baseline', 'pre', 'Binlabel', 'on', 'FileFormat', 'long', 'Filename', [pathname_meas '400-499_All.txt'], 'Fracreplace', 'NaN', 'InterpFactor', 1, 'Measure', 'meanbl', 'Resolution',6, 'Warning', 'off' );
    values = pop_geterpvalues( {'Loadlist', [pathname_cmd, 'erpfiles.txt']}, [ 500 699], [1:allbins], 1:64, 'Baseline', 'pre', 'Binlabel', 'on', 'FileFormat', 'long', 'Filename', [pathname_meas '500-699_All.txt'], 'Fracreplace', 'NaN', 'InterpFactor', 1, 'Measure', 'meanbl', 'Resolution',6, 'Warning', 'off' );
    values = pop_geterpvalues( {'Loadlist', [pathname_cmd, 'erpfiles.txt']}, [ 700 899], [1:allbins], 1:64, 'Baseline', 'pre', 'Binlabel', 'on', 'FileFormat', 'long', 'Filename', [pathname_meas '700-899_All.txt'], 'Fracreplace', 'NaN', 'InterpFactor', 1, 'Measure', 'meanbl', 'Resolution',6, 'Warning', 'off' );

    fprintf('\n+++++++++++++++\n+ Measure ERPs: done! ... \n+++++++++++++++\n\n');
    % Convert to csv
    std_meas_conversion

