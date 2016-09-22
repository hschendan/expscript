function std_artif_S52(s)
  

global data_path subject ch64 artparm sfx set



x = 'a';



fprintf('\n+++++++++++++++\n+ (artif_T) Previous sfx = %s ... \n+++++++++++++++\n\n', sfx);



    sname = [data_path{s} subject{s} sfx set];       

    if  exist(sname, 'file')>0               

        clear EEG;  % Clear is to make sure that we start fresh for each subject with the EEG and ERP structures

    %clear ERP;  % Clear is to make sure that we start fresh for each subject with the EEG and ERP structures

        EEG = pop_loadset('filename', [subject{s} sfx set], 'filepath', data_path{s});                

    %TO DO: Detect artifacts for current dataset. Adjust parameter values after EEG in function

    % Artifact detection notes: 

    % BLINK & HEOG: Step-like. Test window = [-100 898] ms; Threshold = TODO uV; Window width = 400 ms (use default or TODO); Window step = 10 ms; Channels = 65 (Blink); Flags to be activated = 1 & 3

         if ch64 % 64 channel cap            

            EEG = pop_artextval( EEG, 'Channel', [1:64,70:71], 'Flag',  2, 'Review', 'off', 'Threshold', [ artparm(s,1) artparm(s,2)], 'Twindow', [-200 900]); %Voltage threshold

            EEG = pop_artstep( EEG , 'Channel',  71, 'Flag', 3, 'Review', 'off', 'Threshold',  artparm(s,3), 'Twindow', [ -200 900], 'Windowsize',  artparm(s,4), 'Windowstep',  artparm(s,5) ); % step-like artifacts VEOG

            EEG = pop_artstep( EEG , 'Channel',  70, 'Flag',  4, 'Review', 'off', 'Threshold',  artparm(s,6), 'Twindow', [ -200 900], 'Windowsize',  artparm(s,7), 'Windowstep',  artparm(s,8) ); % step-like artifacts HEOG

            EEG = pop_artstep( EEG , 'Channel',  1:64, 'Flag',  5, 'Review', 'off', 'Threshold',  artparm(s,9), 'Twindow', [ -200 900], 'Windowsize',  artparm(s,10), 'Windowstep',  artparm(s,11) ); % step-like artifacts other chans

            EEG = pop_artmwppth( EEG , 'Channel',  1:64, 'Flag',  6, 'Review', 'off', 'Threshold',  artparm(s,12), 'Twindow', [ -200 900], 'Windowsize',  artparm(s,13), 'Windowstep',  artparm(s,14) ); % P2P ALL

            EEG = pop_artmwppth( EEG , 'Channel',  71, 'Flag',  7, 'Review', 'off', 'Threshold',  artparm(s,15), 'Twindow', [ -200 900], 'Windowsize',  artparm(s,16), 'Windowstep',  artparm(s,17) ); % P2P VOG           

            EEG = pop_artdiff( EEG , 'Channel',  1:64, 'Flag',  8, 'Review', 'off', 'Threshold',  artparm(s,18), 'Twindow', [ -200 900] ); %Extreme spikiness

            EEG = pop_artextval( EEG, 'Channel', [32], 'Flag',  2, 'Review', 'off', 'Threshold', [100 200], 'Twindow', [-200 900]); %Voltage threshold

            EEG = pop_artextval( EEG, 'Channel', [34], 'Flag',  2, 'Review', 'off', 'Threshold', [100 150], 'Twindow', [-200 900]); %Voltage threshold

            EEG = pop_artextval( EEG, 'Channel', [55], 'Flag',  2, 'Review', 'off', 'Threshold', [150 200], 'Twindow', [-200 900]); %Voltage threshold

            EEG = pop_artextval( EEG, 'Channel', [58], 'Flag',  2, 'Review', 'off', 'Threshold', [100 200], 'Twindow', [-200 900]); %Voltage threshold

            EEG = pop_artextval( EEG, 'Channel', [14], 'Flag',  2, 'Review', 'off', 'Threshold', [100 200], 'Twindow', [-200 900]); %Voltage threshold

            EEG = pop_artextval( EEG, 'Channel', [17], 'Flag',  2, 'Review', 'off', 'Threshold', [100 200], 'Twindow', [-200 900]); %Voltage threshold

            EEG = pop_artextval( EEG, 'Channel', [63], 'Flag',  2, 'Review', 'off', 'Threshold', [100 200], 'Twindow', [-200 900]); %Voltage threshold

            EEG = pop_artextval( EEG, 'Channel', [4], 'Flag',  2, 'Review', 'off', 'Threshold', [100 200], 'Twindow', [-200 900]); %Voltage threshold

         else    % 32 channel cap: TO check

            EEG = pop_artextval( EEG, 'Channel', [1:32,38:39], 'Flag',  2, 'Review', 'off', 'Threshold', [ artparms(s,1) artparms(s,2)], 'Twindow', [-200 900]); %Voltage threshold

            EEG = pop_artstep( EEG , 'Channel',  39, 'Flag',  3, 'Review', 'off', 'Threshold',  artparms(s,3), 'Twindow', [ -200 900], 'Windowsize',  artparms(s,4), 'Windowstep',  artparms(s,5) ); % step-like artifacts VEOG

            EEG = pop_artstep( EEG , 'Channel',  38, 'Flag',  4, 'Review', 'off', 'Threshold',  artparms(s,6), 'Twindow', [ -200 900], 'Windowsize',  artparms(s,7), 'Windowstep',  artparms(s,8) ); % step-like artifacts HEOG

            EEG = pop_artstep( EEG , 'Channel',  1:32, 'Flag',  5, 'Review', 'off', 'Threshold',  artparms(s,9), 'Twindow', [ -200 900], 'Windowsize',  artparms(s,10), 'Windowstep',  artparms(s,11) ); % step-like artifacts other chans

            EEG = pop_artmwppth( EEG , 'Channel',  1:32, 'Flag',  6, 'Review', 'off', 'Threshold',  artparms(s,12), 'Twindow', [ -200 900], 'Windowsize',  artparms(s,13), 'Windowstep',  artparms(s,14) ); % P2P ALL

            EEG = pop_artmwppth( EEG , 'Channel',  39, 'Flag',  7, 'Review', 'off', 'Threshold',  artparms(s,15), 'Twindow', [ -200 900], 'Windowsize',  artparms(s,16), 'Windowstep',  artparms(s,17) ); % P2P VOG           

            EEG = pop_artdiff( EEG , 'Channel',  1:32, 'Flag',  8, 'Review', 'off', 'Threshold',  artparms(s,18), 'Twindow', [ -200 900] ); %Extreme spikiness

         end    

        

        EEG.setname= [subject{s} sfx x];

        

        EEG = pop_saveset(EEG, 'filename', [EEG.setname set], 'filepath', data_path{s});   

        % Export ar info          

        EEG = pop_exporteegeventlist(EEG, [data_path{s}, subject{s} '_EEG_ar.txt']);

        pop_summary_AR_eeg_detection(EEG, [data_path{s}, subject{s} '_EEG_arTab.txt']);  % Save ar Table

        values = pop_rt2text(EEG, 'arfilter', 'on', 'eventlist',  1, 'filename', [data_path{s} EEG.setname '_arRT.txt'], 'header','on', 'listformat', 'basic' );

        values = pop_rt2text(EEG, 'arfilter', 'on', 'eventlist',  1, 'filename', [data_path{s} EEG.setname '_arRTs.txt'], 'header','on', 'listformat', 'itemized' );

    % ERP = pop_averager( EEG, 'Criterion', 'good', 'Stdev', 'on');

    % erpname = [subject{s} 'M12_ar'];  % name for erpset menu

    % fname_erp= fullfile(data_path{s}, [erpname '.erp']);

    % pop_savemyerp(ERP, 'erpname', erpname, 'filename', fname_erp, 'warning', 'off');  

   

    else

            fprintf('\n *** WARNING: %s does not exist *** \n\n', sname);

    end

    

    fprintf('\n+++++++++++++++\n+ Artifact detection for %s : done! ... \n+++++++++++++++\n\n', subject{s});
