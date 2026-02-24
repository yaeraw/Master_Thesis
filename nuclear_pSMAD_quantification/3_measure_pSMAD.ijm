setBatchMode(false); // MUST be false for interaction

imgDir = "D:/260120_pSMAD15/transformed_Images/repeat/";
roiDir = "D:/260120_pSMAD15/transformed_Images/ROI/";
outDir = imgDir + "Measurements/";

File.makeDirectory(outDir);

roiList = getFileList(roiDir);

for (i = 0; i < roiList.length; i++) {

    if (!endsWith(roiList[i], "_roi.zip")) continue;

    c1Name = replace(roiList[i], "_roi.zip", "");
    c2Name = replace(c1Name, "C1_", "C2_");
    c3Name = replace(c1Name, "C1_", "C3_");

    c1Path = imgDir + c1Name;
    c2Path = imgDir + c2Name;
    c3Path = imgDir + c3Name;

    if (!File.exists(c1Path) || !File.exists(c2Path) || !File.exists(c3Path)) {
        print("Missing channel for: " + c1Name);
        continue;
    }

    open(c1Path);
    open(c2Path);
    open(c3Path);
    run("Tile");
    
    // display-only contrast enhancement
	selectWindow(c1Name);
	run("Enhance Contrast", "saturated=0.35");
	
	selectWindow(c2Name);
	run("Enhance Contrast", "saturated=0.35");

    roiManager("Reset");
	roiManager("Open", roiDir + roiList[i]);
	
	// show ROIs on all channels
	selectWindow(c1Name);
	roiManager("Show All");
	
	selectWindow(c2Name);
	roiManager("Show All");
	
	selectWindow(c3Name);
	roiManager("Show All");
	
	// let user select ROIs
	waitForUser(
	    "Select ROIs",
	    "ROIs are shown on all channels.\n" +
	    "Select the ROIs to measure in the ROI Manager\n" +
	    "(Ctrl / Shift + click), then click OK"
	);

    // measure selected ROIs in C3
    selectWindow(c3Name);
    roiManager("Measure");

    base = replace(c1Name, ".tif", "");
    saveAs("Results", outDir + base + "flat_control.csv");

    close("*");
    roiManager("Reset");
    run("Clear Results");
}

