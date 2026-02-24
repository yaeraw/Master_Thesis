setBatchMode(true);

output = "D:/260120_pSMAD15/transformed_Images/";
File.makeDirectory(output);

// store original image IDs
n = nImages;
ids = newArray(n);
for (i = 0; i < n; i++) {
    selectImage(i + 1);
    ids[i] = getImageID();
}

// process images
for (i = 0; i < ids.length; i++) {

    if (!isOpen(ids[i])) continue;

    selectImage(ids[i]);
    rawName = getTitle();

    // --- sanitize filename ---
    name = rawName;
    name = replace(name, ".lif", "");
    name = replace(name, "/", "_");
    name = replace(name, "\\", "_");
    name = replace(name, " ", "_");
    name = replace(name, ":", "");
    name = replace(name, "-", "_");

    getDimensions(w, h, channels, slices, frames);
    if (channels < 2 || slices < 2) continue;

    run("Split Channels");

    for (c = 1; c <= channels; c++) {

        chanWin = "C" + c + "-" + rawName;
        if (!isOpen(chanWin)) continue;

        selectWindow(chanWin);
        run("Z Project...", "projection=[Sum Slices]");

        projWin = "SUM_" + chanWin;
        selectWindow(projWin);

        saveAs("TIFF", output + "C" + c + "_SUM_" + name + ".tif");
        close();

        selectWindow(chanWin);
        close();
    }
}

setBatchMode(false);


