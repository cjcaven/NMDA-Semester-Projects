function output = spm_preprocessing(funcimg, anatimg, spmdir)

% this function completes the followoing preprocessing steps:
%
% Realignment
% Coregistration
% Segmentation
% Normalisation
% Smoothing


% INPUT:  
% funcimg = filename of functional images 
% anatimg = filename of anatomical image
% spmdir = SPM12 directory 

% OUTPUT:
% output = structure with filenames and data


%% Output structure 
output = struct;

%% Step 1 Realignment (estimate and reslice)

disp('Step 1 - Realign all functional images to mean functional volumne');
spm('Defaults','fMRI')
spm_jobman('initcfg');
realign_estimate_reslice = struct;

realign_estimate_reslice.matlabbatch{1}.spm.spatial.realign.estwrite.data = {funcimg'};

% Realignment options
realign_estimate_reslice.matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.quality = 0.9;
realign_estimate_reslice.matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.sep = 4;
realign_estimate_reslice.matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.fwhm = 5;
realign_estimate_reslice.matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.rtm = 1;
realign_estimate_reslice.matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.interp = 2;
realign_estimate_reslice.matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.wrap = [0 0 0];
realign_estimate_reslice.matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.weight = '';
realign_estimate_reslice.matlabbatch{1}.spm.spatial.realign.estwrite.roptions.which = [2 1];
realign_estimate_reslice.matlabbatch{1}.spm.spatial.realign.estwrite.roptions.interp = 4;
realign_estimate_reslice.matlabbatch{1}.spm.spatial.realign.estwrite.roptions.wrap = [0 0 0];
realign_estimate_reslice.matlabbatch{1}.spm.spatial.realign.estwrite.roptions.mask = 1;
realign_estimate_reslice.matlabbatch{1}.spm.spatial.realign.estwrite.roptions.prefix = 'r';


% Run
spm_jobman('run', realign_estimate_reslice.matlabbatch);

disp('Step 1 - Done!');
disp('===================================================================');



 %% STEP 2 - COREGISTER STRUCTURAL IMAGE TO FIRST FUNCTIONAL IMAGE

 disp('Step 2 - Coregister anatomical image to first functional image  ');
 spm('Defaults','fMRI')
 spm_jobman('initcfg');
 coreg_estimate = struct;



 coreg_estimate.matlabbatch{1}.spm.spatial.coreg.estimate.ref = {meanfuncimg};
 coreg_estimate.matlabbatch{1}.spm.spatial.coreg.estimate.source = {anatimg};
 coreg_estimate.matlabbatch{1}.spm.spatial.coreg.estimate.other = {''};
 coreg_estimate.matlabbatch{1}.spm.spatial.coreg.estimate.eoptions.cost_fun = 'nmi';
 coreg_estimate.matlabbatch{1}.spm.spatial.coreg.estimate.eoptions.sep = [4 2];
 coreg_estimate.matlabbatch{1}.spm.spatial.coreg.estimate.eoptions.tol = [0.02 0.02 0.02 0.001 0.001 0.001 0.01 0.01 0.01 0.001 0.001 0.001];
 coreg_estimate.matlabbatch{1}.spm.spatial.coreg.estimate.eoptions.fwhm = [7 7];

 % Run
 spm_jobman('run',coreg_estimate.matlabbatch);
 disp('Step 2 - Done!');
 disp('===================================================================');

%% STEP 3 - SEGMENTATION OF COREGISTERED ANATOMICAL IMAGES 

disp('Step 3 - Segmentation of coregisteres anatomical image');
spm('Defaults','fMRI')
spm_jobman('initcfg');
segmentation = struct;

% Channel
segmentation.matlabbatch{1}.spm.spatial.preproc.channel.vols = {anatimg};
segmentation.matlabbatch{1}.spm.spatial.preproc.channel.biasreg = 0.001;
segmentation.matlabbatch{1}.spm.spatial.preproc.channel.biasfwhm = 60;
segmentation.matlabbatch{1}.spm.spatial.preproc.channel.write = [0 1];


% Tissue 
for t = 1:6
    segmentation.matlabbatch{1}.spm.spatial.preproc.tissue(t).tpm = {[spmdir 'tpm' filesep 'TPM.nii,' num2str(t)]};
    segmentation.matlabbatch{1}.spm.spatial.preproc.tissue(t).ngaus = 1;
    segmentation.matlabbatch{1}.spm.spatial.preproc.tissue(t).native = [1 0]; % tissue(6) native = [0 0]
    segmentation.matlabbatch{1}.spm.spatial.preproc.tissue(t).warped = [0 0];
end

segmentation.matlabbatch{1}.spm.spatial.preproc.tissue(3).ngaus = 2;
segmentation.matlabbatch{1}.spm.spatial.preproc.tissue(4).ngaus = 3;
segmentation.matlabbatch{1}.spm.spatial.preproc.tissue(5).ngaus = 4;
segmentation.matlabbatch{1}.spm.spatial.preproc.tissue(6).ngaus = 2;

% Warp 
segmentation.matlabbatch{1}.spm.spatial.preproc.warp.mrf = 1;
segmentation.matlabbatch{1}.spm.spatial.preproc.warp.cleanup = 1;
segmentation.matlabbatch{1}.spm.spatial.preproc.warp.reg = [0 0.001 0.5 0.05 0.2];
segmentation.matlabbatch{1}.spm.spatial.preproc.warp.affreg = 'mni';
segmentation.matlabbatch{1}.spm.spatial.preproc.warp.fwhm = 0;
segmentation.matlabbatch{1}.spm.spatial.preproc.warp.samp = 3;
segmentation.matlabbatch{1}.spm.spatial.preproc.warp.write = [0 1];
segmentation.matlabbatch{1}.spm.spatial.preproc.warp.vox = NaN;
segmentation.matlabbatch{1}.spm.spatial.preproc.warp.bb = [NaN NaN NaN
                                              NaN NaN NaN];


% Run 
spm_jobman('run', segmentation.matblabbatch)



disp('Step 3 - done!');
disp('===================================================================');

%% STEP 4 - NORMALIZATION 

disp('Step 4 - Normalization')
spm('defaults','fmri');
spm_jobman('initcfg');
normalization = struct;

cd(anatdir)
deffieldimg = dir('y*.nii'); 

normalization.matlabbatch{1}.spm.spatial.normalise.write.subj.def = {deffieldimg};
normalization.matlabbatch{1}.spm.spatial.normalise.write.subj.resample = {funcimg};

normalization.matlabbatch{1}.spm.spatial.normalise.write.woptions.bb = [-78 -112 -70
                                                          78 76 85];
normalization.matlabbatch{1}.spm.spatial.normalise.write.woptions.vox = [3 3 3];
normalization.matlabbatch{1}.spm.spatial.normalise.write.woptions.interp = 4;
normalization.matlabbatch{1}.spm.spatial.normalise.write.woptions.prefix = 'w';

% Run 
spm_jobman('run', normalization.matblabbatch);


disp('Step 4 - done!');
disp('===================================================================');

%% STEP 5 - SMOOTHING 

disp('Step 5 - Smoothing')
spm('defaults','fmri');
spm_jobman('initcfg');
smoothing = struct;

cd(funcdir)
normalizedimg = dir('wf*.img');
smoothing.matlabbatch{1}.spm.spatial.smooth.data = {normalizedimg};

smoothing.matlabbatch{1}.spm.spatial.smooth.fwhm = [6 6 6];
smoothing.matlabbatch{1}.spm.spatial.smooth.dtype = 0;
smoothing.matlabbatch{1}.spm.spatial.smooth.im = 0;
smoothing.matlabbatch{1}.spm.spatial.smooth.prefix = 's';


% Run 
spm_jobman('run', smoothing.matlabbatch);


disp('Step 5 - done!');
disp('===================================================================');

 
