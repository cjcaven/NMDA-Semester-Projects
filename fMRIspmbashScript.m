%% fMRI DATA ANALYSIS BATCH SCRIPT
% 
% fMRI data analysis using Matlab with spm 
% 

%% INITIALIZATION 

datadir = '/Users/denisekittelmann/Documents/MATLAB/MoAEpilot/'; 
cd(datadir)
spmdir = '/Users/denisekittelmann/Documents/MATLAB/spm12/'; 

addpath(spmdir)

% structural image path
anatdir = [datadir 'sM00223' filesep]; 
cd(anatdir)
anatimg = dir('s*.img'); 

% functional images data path 
funcdir = [datadir 'fM00223' filesep]; 
cd(funcdir)
funcimg = dir('f*.img'); 
meanfuncimg = dir('m*.img');


%% PREPROCESSING 

disp('PREPROCESSING')
disp('================================================================')

preproc_data = spm_preprocessing(funcimg, anatimg, spmdir);

% check coregistration and segmentation 

spm_check_registration()
disp('PREPROCESSING DONE!')
disp('================================================================')


%% 








