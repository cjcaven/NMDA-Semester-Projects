Before analysis, one should first clean up the data to reduce the amount of noise acquired during the collection process. This preprocessing of the data is divided into four main steps:

### Step 1: Realignment
Even though the participant lays as still as possible in the scanner, there is still minimal movement that occurs. This can slightly skew the image scans, so we want to correct this by "straightening out" the scans so they all line up again. Think of it like students stacking their tests together after taking an exam- they are piled on the same spot of the desk, but aren't perfectly in-line with one another. Realigning is like picking up the tests altogether and tapping them on the desk so that the edges match up to create a neat stack.

If the scans are not realigned, strong signal changes can be artificially induced into the data. This is because, for example, voxels along the edges of the skull could fall outside of the cranium in some scans but inside of it in others. If this is the case, the change in the voxel's acitivy from 0 to any level of activity will be represented as a strong signal change. This signal change will be time-locked to the event causing movement, e.g., button-pressing, and could overwrite any effect of interest.
_*Keep in mind that strong artifacts (interpolation effects) along the edges of tissue can indicate lower-quality data, even after performing realignment._

To correct for motion, realignment relies on the brightness differences between single images (volumes). An algorithm uses the shape of the head to infer the likely rotation activity of the head, based on what activity minimizes the brightness differences. This results in a Motion Parameter. The Motion Parameter can then be used to interpolate and adjust (reslice) the images.

### Step 2: Coregistration
Since the functional images are not in the same space as the structural images, the images should be coregistered to the same space. You can specify a coregistration job in the SPM batch editor. You can use the mean fMRI scan from the realignment as a reference image, and set the structural image as the source image. 

### Step 3: Normalization
To account for variability within the individual anatomy of multiple participants, all individual brains should be transformed to a standard space. 

### Step 4: Segmentation

