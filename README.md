# NMDA fMRI Project
Summer semester projects for the course, Neurocognitive Methods and Data Analysis.

Group organization can be found on Notion at the following link: [Task Management](https://www.notion.so/invite/8f8b13efde52269851b1f1c695d6d4aae8a45b33)


Project Breakdown
1) Before analysis, the data needs to be preprocessed. This involves (first) realignment, the script of which is an output from SPM. Then, we must coregister the images to the same space. SPM matches the tissues on its own, no need for additional input here. You only need one image as input. Next, you have segmentation (SPM function). After that, to account for variability in the anatomy of individual participants you should normalize the data. The final step in preprocessing is smoothing (Default: 8x8x8 FWHM (Gaussian smoothing kernel)).
2) After preprocessing, first-level analysis can be carried out. Contruct a design matrix for the GLM, find beta values, and then obtain your contrasts.
3) Finally, you can conduct the second-level analysis. Contrast regressors and carry out a t-test.

