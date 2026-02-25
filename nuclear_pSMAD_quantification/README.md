# nuclear pSMAD quantification process

This folder contains Image J Macros for nuclear pSMAD quantification 

First the maxium z-projections of all three channels are saved. [Step_1](https://github.com/yaeraw/Master_Thesis/blob/9c343efb3f33900cf990819fb2c15cc7c15bc6de/nuclear_pSMAD_quantification/1_save_z_project.ijm).

Nuclear ROIs are created semi automatically using Huangs threshold. [Step 2](https://github.com/yaeraw/Master_Thesis/blob/d24099025abe76abe7cd7c45c4b4cfe2d17f1857/nuclear_pSMAD_quantification/2_get_nuclear_ROI.ijm) 

These nuclear ROIs are then overlaid on all three channels and the user can pick, which ones to measure. [Step 3](https://github.com/yaeraw/Master_Thesis/blob/d24099025abe76abe7cd7c45c4b4cfe2d17f1857/nuclear_pSMAD_quantification/3_measure_pSMAD.ijm)
