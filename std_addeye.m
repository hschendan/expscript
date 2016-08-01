%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Add Channels for Artifact Detection. Also Copy LE and Fp2 to end
% To do: RTlock
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function std_addeye

global nraw data_path subject ch64 sfx set

disp('Add eye channels ...')

fprintf('\n+++++++++++++++\n+ (addeye) Previous sfx = %s ... \n+++++++++++++++\n\n', sfx);


x = 'y';

for s=1:nraw
    sname = [data_path{s} subject{s} sfx set];        
    if exist(sname, 'file')>0
        disp('Add eye channels: WORKING ...')
        clear EEG;  % Clear is to make sure that we start fresh for each subject with the EEG structures
        EEG = pop_loadset('filename', [subject{s} sfx set], 'filepath', data_path{s});                
        % Add HEOG and Blink/VEOG channels, and Copy LE and Fp2 to below Copy LE and Fp2 to below VE/blink
        if ch64 % 64 channel cap            
            %EEG = pop_eegchanoperator( EEG, {  ' nch1 = ch1 label 1'   ' nch2 = ch2 label HE'   ' nch3 = ch3 label M2'   ' nch4 = ch4 label ns'   ' nch5 = ch5 label 1'   ' nch6 = ch6 label 2'   ' nch7 = ch7 label 3'   ' nch8 = ch8 label 4'   ' nch9 = ch9 label 5'   ' nch10 = ch10 label 6'   ' nch11 = ch11 label 7'   ' nch12 = ch12 label 8'   ' nch13 = ch13 label 9'   ' nch14 = ch14 label 10'   ' nch15 = ch15 label 11'   ' nch16 = ch16 label 12'   ' nch17 = ch17 label 13'   ' nch18 = ch18 label 14'   ' nch19 = ch19 label 15'   ' nch20 = ch20 label 16'   ' nch21 = ch21 label 17'   ' nch22 = ch22 label 18'   ' nch23 = ch23 label 19'   ' nch24 = ch24 label 20'   ' nch25 = ch25 label 21'   ' nch26 = ch26 label 22'   ' nch27 = ch27 label 23'   ' nch28 = ch28 label 24'   ' nch29 = ch29 label 25'   ' nch30 = ch30 label 26'   ' nch31 = ch31 label 27'   ' nch32 = ch32 label 28'   ' nch33 = ch33 label 29'   ' nch34 = ch34 label 30'   ' nch35 = ch35 label 31'   ' nch36 = ch36 label 32'   ' nch37 = ch37 label 33'   ' nch38 = ch38 label 34'   ' nch39 = ch39 label 35'   ' nch40 = ch40 label 36'   ' nch41 = ch41 label 37'   ' nch42 = ch42 label 38'   ' nch43 = ch43 label 39'   ' nch44 = ch44 label 40'   ' nch45 = ch45 label 41'   ' nch46 = ch46 label 42'   ' nch47 = ch47 label 43'   ' nch48 = ch48 label 44'   ' nch49 = ch49 label 45'   ' nch50 = ch50 label 46'   ' nch51 = ch51 label 47'   ' nch52 = ch52 label 48'   ' nch53 = ch53 label 49'   ' nch54 = ch54 label 50'   ' nch55 = ch55 label 51'   ' nch56 = ch56 label 52'   ' nch57 = ch57 label 53'   ' nch58 = ch58 label 54'   ' nch59 = ch59 label 55'   ' nch60 = ch60 label 56'   ' nch61 = ch61 label 57'   ' nch62 = ch62 label 58'   ' nch63 = ch63 label 59'   ' nch64 = ch64 label 60'   ' nch65 = ch65 label' 'ch70 = ch67 - ch66 label HEOG' 'Ch71 = ch1 - ch65 label VOG' '  });
            EEG = pop_eegchanoperator( EEG, { 'ch70 = ch65 - ch66 label HE' 'ch71 = ch34 - ch67 label VE' 'ch72 = ch34 label Fp2c' 'ch73 = ch67 label LEc'});
        else    % 32 channel cap
            EEG = pop_eegchanoperator( EEG, { 'ch38 = ch33 - ch34 label HE' 'ch39 = ch30 - ch35 label VE' 'ch40 = ch30 label Fp2c' 'ch41 = ch35 label LEc'});
        end    
        EEG.setname= [subject{s} sfx x];
        EEG = pop_saveset(EEG, 'filename', [EEG.setname set], 'filepath', data_path{s}); 
        
    else
        fprintf('\n *** WARNING: %s does not exist *** \n\n', sname);
    end    
    
end

sfx = [sfx x];
fprintf('\n+++++++++++++++\n+ Added eye channels: done! ... \n+++++++++++++++\n\n');

fprintf('\n+++++++++++++++\n+ (addeye)New sfx = %s ... \n+++++++++++++++\n\n', sfx);
