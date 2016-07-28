%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                               % 
%         Script Template - standard stream                     %
%                                                               %                                            
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Stream order: elist -> binlis ->chanloc -> epoch -> addeye -> artif -> eegrefch(opt.)-> avg -> erprefch -> meas -> gavg(with lp)

% Save Command Window output text to a created file 
diary('C:\Users\pzhao\Documents\MATLAB\standard8\diary8.txt'); %***Modify to yours ***%

clr = 0; % This need to be set to 0 at stage 2 below, otherwise, you have to assign the sfx manually in artif_all.m

if clr
    std_clear;
end

global os paraset mod import elist binlis chanloc epoch  addeye artif artif_all eegrefch avg gavg meas 

%need to run eeglab first
eeglab

% Set up Global flags & ERP flags
std_flags;

% Choose Operating systems & user's paths (modify 'pathname_all' to yours)
if os
    std_os; 
end

% set up parameters
if paraset
    std_paraset;
end

%MODULES BELOW: Load and save each step
if mod
    std_mod; 
end

%Import and translate BioSemi/Raw Data into EEGLab .set only once.
if import
    std_import
end

% Creates ERP Eventlist
if elist 
   std_elist
end

% Assign bins (Binlister);ADD RT OUTPUT FLAGS
if binlis
   std_binlis
end

% Add Channel Locations
if chanloc  
   std_chanloc
end

%Create Bin based Epoch
if epoch
   std_epoch
end

%Add Channels for Artifact Detection. Also Copy LE and Fp2 to end
if addeye
   std_addeye
end

%Artifact Detection & artifact-free average
if artif
   std_artif
end

                %********************** Stage 2 ********************%
                %      please set 'clr' to  0;                      %
                %      modify the artif_S.. for each subject;       %
                %      change the flags at stage 1 equal to 0;      %
                %      change the flags afterwards equal to 1;      %
                %      then run MAIN.m again;                       %
                %***************************************************%

if artif_all
    std_artif_all
end

%Reference to mean of bilateral mastoids & CAR
if eegrefch
   std_eegrefch 
end

%Average ERP
if avg
    std_avg 
end

% ERPrefch
% if erprefch
%    std_erprefch
% end

%Measure ERPs
if meas
    std_meas
end

%GRAND AVERAGE. Include standard deviation.
if gavg
    std_gavg 
end
    