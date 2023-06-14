function coregistration(meanfuncimg, anatimg)

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
