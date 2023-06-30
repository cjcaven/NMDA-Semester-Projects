function smoothing

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
