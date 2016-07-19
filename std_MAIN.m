%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                    % 
%         Script Template            %
%                                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Save Command Window output text to a created file (specify yours)
diary('C:\Users\pzhao\Documents\MATLAB\Standard\diary.txt');

% Clear memory and the command window
clear all
clc
disp('Setting up...')

global mod import chanloc elist binlis refch epoch addeye artif artif_all avg gavg
global meas lp xRTlock1 xRTlock2 xRTlock3  bo xRTlock4

%need to run eeglab first
eeglab



% Set up Global flags & ERP flags
std_flags;

% Choose Operating systems & user's paths (modify 'pathname_all' to yours)
std_os; 

% set up parameters
std_paraset;

%MODULES BELOW: Load and save each step
if mod
    std_mod; 
end

%Import and translate BioSemi/Raw Data into EEGLab .set only once.
if import
    std_import
end

% Add Channel Locations
if chanloc  
   std_chanloc
end

% Creates ERP Eventlist
if elist 
   std_elist
end

% Assign bins (Binlister);ADD RT OUTPUT FLAGS
if binlis
   std_binlis
end

%Reference to mean of bilateral mastoids & CAR
if refch
   std_refch 
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

if artif_all
    std_artif_all
end

%Average ERP
if avg
    std_avg 
end

%GRAND AVERAGE. Include standard deviation.
if gavg
    std_gavg 
end

%Measure ERPs
if meas
    std_meas
end

%Basic Filtering for ERP with Low Pass 
if lp
    std_lp
end

if xRTlock1
    std_xRTlock1
end

if xRTlock2
    std_xRTlock2
end

if xRTlock3
    std_xRTlock3
end

if bo
    std_bo
end

if xRTlock4
    std_gavgstd
end
    