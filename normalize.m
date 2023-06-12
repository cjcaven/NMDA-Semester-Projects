function normalization = normalize 

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