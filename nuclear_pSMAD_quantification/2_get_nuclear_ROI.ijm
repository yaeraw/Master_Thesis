macro "Get_ROI [F3]"{
 msg = "select image, then click \"OK\".";
 waitForUser("pick", msg);
 id=getImageID();
 selectImage(id);
 // Get the name (title) of the current image
 name = getTitle(); 
 // Output path for saving the ROIs
 output = "D:/260120_pSMAD15/transformed_Images/ROI/"
 //run("Enhance Contrast", "saturated=0.2")
 //run("Duplicate...", "title=[duplicate.TIF]");
 //run("ROI Manager...");
 //run("Gaussian Blur...", "sigma=3");
 //run("Invert")
 //setAutoThreshold("Huang");

 //setAutoThreshold("Huang");
 //setOption("BlackBackground", false);
 //run("Convert to Mask");
 //run("Watershed");
 //run("Analyze Particles...", "size=70-1000 circularity=0-1.00 show=Outlines exclude clear record add");
 //selectWindow("duplicate.TIF");
 //close();
 //selectWindow("Drawing of duplicate.TIF");
 //close();
 selectImage(id);
 roiManager("Show All with labels");
 roiManager("Show All");
 // Save the ROIs using the name of the image
 roiManager("Save", output+name+"_roi.zip");
}