function segement(anatimg, spmdir)

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
