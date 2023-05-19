%% fMRI DATA ANALYSIS 
% 
% 
% 

%% INITIALIZATION 

datadir = '/Users/denisekittelmann/Documents/MATLAB/MoAEpilot/'; 
cd(datadir)
spmdir = '/Users/denisekittelmann/Documents/MATLAB/spm12/'; 

addpath(spmdir)
spm('Defaults','fMRI')


% structural image path
anatdir = [datadir 'sM00223' filesep]; 
cd(anatdir)
anatimg = dir('s*.img'); 

% functional images data path 
funcdir = [datadir 'fM00223' filesep]; 
cd(funcdir)
funcimg = dir('f*.img'); 


%% PREPROCESSING 

fprintf('PREPROCESSING')
fprintf('================================================================ \n')















