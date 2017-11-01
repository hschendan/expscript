%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Measure ERPs and convert text output to .csv
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function std_meas

global pathname_cmd allbins pathname_meas

disp('Measuring ERPs ...')
% Measure all bins at all channels
% Save the results in a variable named "values" and in a file in the Measurement folder for the experiment

% MEAN AMPLITUDE
% std times
    values = pop_geterpvalues( {'Loadlist', [pathname_cmd, 'erpfiles.txt']}, [ 95 115], [1:allbins], 1:64, 'Baseline', 'pre', 'Binlabel', 'on', 'FileFormat', 'long', 'Filename', [pathname_meas '95-115_All.txt'], 'Fracreplace', 'NaN', 'InterpFactor', 1, 'Measure', 'meanbl', 'Resolution',6, 'Warning', 'off' );
    values = pop_geterpvalues( {'Loadlist', [pathname_cmd, 'erpfiles.txt']}, [ 120 140], [1:allbins], 1:64, 'Baseline', 'pre', 'Binlabel', 'on', 'FileFormat', 'long', 'Filename', [pathname_meas '120-140_All.txt'], 'Fracreplace', 'NaN', 'InterpFactor', 1, 'Measure', 'meanbl', 'Resolution',6, 'Warning', 'off' );
    values = pop_geterpvalues( {'Loadlist', [pathname_cmd, 'erpfiles.txt']}, [ 145 160], [1:allbins], 1:64, 'Baseline', 'pre', 'Binlabel', 'on', 'FileFormat', 'long', 'Filename', [pathname_meas '145-160_All.txt'], 'Fracreplace', 'NaN', 'InterpFactor', 1, 'Measure', 'meanbl', 'Resolution',6, 'Warning', 'off' );
    values = pop_geterpvalues( {'Loadlist', [pathname_cmd, 'erpfiles.txt']}, [ 200 299], [1:allbins], 1:64, 'Baseline', 'pre', 'Binlabel', 'on', 'FileFormat', 'long', 'Filename', [pathname_meas '200-299_All.txt'], 'Fracreplace', 'NaN', 'InterpFactor', 1, 'Measure', 'meanbl', 'Resolution',6, 'Warning', 'off' );
    values = pop_geterpvalues( {'Loadlist', [pathname_cmd, 'erpfiles.txt']}, [ 300 399], [1:allbins], 1:64, 'Baseline', 'pre', 'Binlabel', 'on', 'FileFormat', 'long', 'Filename', [pathname_meas '300-399_All.txt'], 'Fracreplace', 'NaN', 'InterpFactor', 1, 'Measure', 'meanbl', 'Resolution',6, 'Warning', 'off' );
    values = pop_geterpvalues( {'Loadlist', [pathname_cmd, 'erpfiles.txt']}, [ 400 499], [1:allbins], 1:64, 'Baseline', 'pre', 'Binlabel', 'on', 'FileFormat', 'long', 'Filename', [pathname_meas '400-499_All.txt'], 'Fracreplace', 'NaN', 'InterpFactor', 1, 'Measure', 'meanbl', 'Resolution',6, 'Warning', 'off' );
    values = pop_geterpvalues( {'Loadlist', [pathname_cmd, 'erpfiles.txt']}, [ 500 699], [1:allbins], 1:64, 'Baseline', 'pre', 'Binlabel', 'on', 'FileFormat', 'long', 'Filename', [pathname_meas '500-699_All.txt'], 'Fracreplace', 'NaN', 'InterpFactor', 1, 'Measure', 'meanbl', 'Resolution',6, 'Warning', 'off' );
    values = pop_geterpvalues( {'Loadlist', [pathname_cmd, 'erpfiles.txt']}, [ 700 899], [1:allbins], 1:64, 'Baseline', 'pre', 'Binlabel', 'on', 'FileFormat', 'long', 'Filename', [pathname_meas '700-899_All.txt'], 'Fracreplace', 'NaN', 'InterpFactor', 1, 'Measure', 'meanbl', 'Resolution',6, 'Warning', 'off' );
% Optional: Other times
    % P6/LPC
    values = pop_geterpvalues( {'Loadlist', [pathname_cmd, 'erpfiles.txt']}, [ 500 599], [1:allbins], 1:64, 'Baseline', 'pre', 'Binlabel', 'on', 'FileFormat', 'long', 'Filename', [pathname_meas '500-599_All.txt'], 'Fracreplace', 'NaN', 'InterpFactor', 1, 'Measure', 'meanbl', 'Resolution',6, 'Warning', 'off' );
    values = pop_geterpvalues( {'Loadlist', [pathname_cmd, 'erpfiles.txt']}, [ 600 899], [1:allbins], 1:64, 'Baseline', 'pre', 'Binlabel', 'on', 'FileFormat', 'long', 'Filename', [pathname_meas '600-899_All.txt'], 'Fracreplace', 'NaN', 'InterpFactor', 1, 'Measure', 'meanbl', 'Resolution',6, 'Warning', 'off' );
    % N3
    values = pop_geterpvalues( {'Loadlist', [pathname_cmd, 'erpfiles.txt']}, [ 232 450], [1:allbins], 1:64, 'Baseline', 'pre', 'Binlabel', 'on', 'FileFormat', 'long', 'Filename', [pathname_meas '232-450_All.txt'], 'Fracreplace', 'NaN', 'InterpFactor', 1, 'Measure', 'meanbl', 'Resolution',6, 'Warning', 'off' );
%    values = pop_geterpvalues( {'Loadlist', [pathname_cmd, 'erpfiles.txt']}, [ 200 499], [1:allbins], 1:64, 'Baseline', 'pre', 'Binlabel', 'on', 'FileFormat', 'long', 'Filename', [pathname_meas '200-499_All.txt'], 'Fracreplace', 'NaN', 'InterpFactor', 1, 'Measure', 'meanbl', 'Resolution',6, 'Warning', 'off' );
%    values = pop_geterpvalues( {'Loadlist', [pathname_cmd, 'erpfiles.txt']}, [ 300 499], [1:allbins], 1:64, 'Baseline', 'pre', 'Binlabel', 'on', 'FileFormat', 'long', 'Filename', [pathname_meas '300-499_All.txt'], 'Fracreplace', 'NaN', 'InterpFactor', 1, 'Measure', 'meanbl', 'Resolution',6, 'Warning', 'off' );
%    values = pop_geterpvalues( {'Loadlist', [pathname_cmd, 'erpfiles.txt']}, [ 232 499], [1:allbins], 1:64, 'Baseline', 'pre', 'Binlabel', 'on', 'FileFormat', 'long', 'Filename', [pathname_meas '232-499_All.txt'], 'Fracreplace', 'NaN', 'InterpFactor', 1, 'Measure', 'meanbl', 'Resolution',6, 'Warning', 'off' );
%    values = pop_geterpvalues( {'Loadlist', [pathname_cmd, 'erpfiles.txt']}, [ 232 299], [1:allbins], 1:64, 'Baseline', 'pre', 'Binlabel', 'on', 'FileFormat', 'long', 'Filename', [pathname_meas '232-299_All.txt'], 'Fracreplace', 'NaN', 'InterpFactor', 1, 'Measure', 'meanbl', 'Resolution',6, 'Warning', 'off' );
%    values = pop_geterpvalues( {'Loadlist', [pathname_cmd, 'erpfiles.txt']}, [ 232 399], [1:allbins], 1:64, 'Baseline', 'pre', 'Binlabel', 'on', 'FileFormat', 'long', 'Filename', [pathname_meas '232-399_All.txt'], 'Fracreplace', 'NaN', 'InterpFactor', 1, 'Measure', 'meanbl', 'Resolution',6, 'Warning', 'off' );
%    values = pop_geterpvalues( {'Loadlist', [pathname_cmd, 'erpfiles.txt']}, [ 250 450], [1:allbins], 1:64, 'Baseline', 'pre', 'Binlabel', 'on', 'FileFormat', 'long', 'Filename', [pathname_meas '250-450_All.txt'], 'Fracreplace', 'NaN', 'InterpFactor', 1, 'Measure', 'meanbl', 'Resolution',6, 'Warning', 'off' );
    
% AREA AMPLITUDE 
% for negative regions
    % std times : N3
    values = pop_geterpvalues( {'Loadlist', [pathname_cmd, 'erpfiles.txt']}, [ 200 299], [1:allbins], 1:64, 'Baseline', 'pre', 'Binlabel', 'on', 'FileFormat', 'long', 'Filename', [pathname_meas '200-299_All_Narea.txt'], 'Fracreplace', 'NaN', 'InterpFactor', 1, 'Measure', 'arean', 'PeakOnset',  1, 'Resolution',6, 'Warning', 'off' );
    values = pop_geterpvalues( {'Loadlist', [pathname_cmd, 'erpfiles.txt']}, [ 300 399], [1:allbins], 1:64, 'Baseline', 'pre', 'Binlabel', 'on', 'FileFormat', 'long', 'Filename', [pathname_meas '300-399_All_Narea.txt'], 'Fracreplace', 'NaN', 'InterpFactor', 1, 'Measure', 'arean', 'PeakOnset',  1, 'Resolution',6, 'Warning', 'off' );
    values = pop_geterpvalues( {'Loadlist', [pathname_cmd, 'erpfiles.txt']}, [ 400 499], [1:allbins], 1:64, 'Baseline', 'pre', 'Binlabel', 'on', 'FileFormat', 'long', 'Filename', [pathname_meas '400-499_All_Narea.txt'], 'Fracreplace', 'NaN', 'InterpFactor', 1, 'Measure', 'arean', 'PeakOnset',  1, 'Resolution',6, 'Warning', 'off' );
    % Optional: Other times
    % N3
     values = pop_geterpvalues( {'Loadlist', [pathname_cmd, 'erpfiles.txt']}, [ 232 450], [1:allbins], 1:64, 'Baseline', 'pre', 'Binlabel', 'on', 'FileFormat', 'long', 'Filename', [pathname_meas '232-450_All_Narea.txt'], 'Fracreplace', 'NaN', 'InterpFactor', 1, 'Measure', 'arean', 'PeakOnset',  1, 'Resolution',6, 'Warning', 'off' );


% PEAK ***** FILTERED ERPs only ***** NOTE: peak fails on null 0 trial bins so choose critical bins with > 0 trials. 
% UNCOMMENT values lines below IF MEASURING FILTERED ERPS and WANT PEAK MEASURED
    %P6
%    values = pop_geterpvalues( {'Loadlist', [pathname_cmd, 'erpfiles.txt']}, [ 500 699], [1:allbins], 1:64, 'Baseline', 'pre', 'Binlabel', 'on', 'FileFormat', 'long', 'Filename', [pathname_meas '500-699_Critf_Ppeak.txt'], 'Fracreplace', 'NaN', 'InterpFactor', 1, 'Measure', 'peakampbl', 'Neighborhood',  5, 'PeakOnset',  1, 'Peakpolarity', 'positive', 'Peakreplace', 'absolute', 'Resolution',6, 'Warning', 'off' );
%    values = pop_geterpvalues( {'Loadlist', [pathname_cmd, 'erpfiles.txt']}, [ 500 599], [1:allbins], 1:64, 'Baseline', 'pre', 'Binlabel', 'on', 'FileFormat', 'long', 'Filename', [pathname_meas '500-599_Critf_Ppeak.txt'], 'Fracreplace', 'NaN', 'InterpFactor', 1, 'Measure', 'peakampbl', 'Neighborhood',  5, 'PeakOnset',  1, 'Peakpolarity', 'positive', 'Peakreplace', 'absolute', 'Resolution',6, 'Warning', 'off' );
    % P1 N1
%    values = pop_geterpvalues( {'Loadlist', [pathname_cmd, 'erpfiles.txt']}, [ 95 115], [1:allbins], 1:64, 'Baseline', 'pre', 'Binlabel', 'on', 'FileFormat', 'long', 'Filename', [pathname_meas '95-115_Critf_Ppeak.txt'], 'Fracreplace', 'NaN', 'InterpFactor', 1, 'Measure', 'peakampbl', 'Neighborhood',  5, 'PeakOnset',  1, 'Peakpolarity', 'positive', 'Peakreplace', 'absolute', 'Resolution',6, 'Warning', 'off' );
%    values = pop_geterpvalues( {'Loadlist', [pathname_cmd, 'erpfiles.txt']}, [ 120 140], [1:allbins], 1:64, 'Baseline', 'pre', 'Binlabel', 'on', 'FileFormat', 'long', 'Filename', [pathname_meas '120-140_Critf_Ppeak.txt'], 'Fracreplace', 'NaN', 'InterpFactor', 1, 'Measure', 'peakampbl', 'Neighborhood',  5, 'PeakOnset',  1, 'Peakpolarity', 'positive', 'Peakreplace', 'absolute', 'Resolution',6, 'Warning', 'off' );
%    values = pop_geterpvalues( {'Loadlist', [pathname_cmd, 'erpfiles.txt']}, [ 145 160], [1:allbins], 1:64, 'Baseline', 'pre', 'Binlabel', 'on', 'FileFormat', 'long', 'Filename', [pathname_meas '145-160_Critf_Ppeak.txt'], 'Fracreplace', 'NaN', 'InterpFactor', 1, 'Measure', 'peakampbl', 'Neighborhood',  5, 'PeakOnset',  1, 'Peakpolarity', 'positive', 'Peakreplace', 'absolute', 'Resolution',6, 'Warning', 'off' );
%    values = pop_geterpvalues( {'Loadlist', [pathname_cmd, 'erpfiles.txt']}, [ 145 160], [1:allbins], 1:64, 'Baseline', 'pre', 'Binlabel', 'on', 'FileFormat', 'long', 'Filename', [pathname_meas '145-160_Critf_Npeak.txt'], 'Fracreplace', 'NaN', 'InterpFactor', 1, 'Measure', 'peakampbl', 'Neighborhood',  5, 'PeakOnset',  1, 'Peakpolarity', 'negative', 'Peakreplace', 'absolute', 'Resolution',6, 'Warning', 'off' );
    
    fprintf('\n+++++++++++++++\n+ Measure ERPs: done! ... \n+++++++++++++++\n\n');

% Convert to csv
    std_meas_conversion

