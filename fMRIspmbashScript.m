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

preprocessing_steps = input('Choose your preprocessing steps: ');

for i = 1:length(preprocessing_steps)
   
    switch i

        case 1
            realign_estimate(funcimg)

        case 2
            coregistration(meanfuncimg, anatim)

        case 3
            segment(anatimg, spmdir)

        case 4
            normalization

        case 5
            smoothing

 disp('PREPROCESSING DONE!')
 disp('================================================================')

    end
end

spm_check_registration()


