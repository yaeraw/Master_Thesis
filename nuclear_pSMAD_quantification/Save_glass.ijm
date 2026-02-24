setBatchMode(true);

output = "D:/260120_pSMAD15/transformed_Images/";

// store original image IDs
n = nImages;
ids = newArray(n);
for (i = 0; i < n; i++) {
    selectImage(i + 1);
    ids[i] = getImageID();
}

// process images
for (i = 0; i < ids.length; i++) {

    // if image was already closed, skip
    if (!isOpen(ids[i])) continue;

    selectImage(ids[i]);
    name = getTitle();

    getDimensions(w, h, channels, slices, frames);
    if (channels < 2) {
        print("Skipping single-channel image: " + name);
        continue;
    }

    run("Split Channels");

    // save split channels
    for (c = 1; c <= channels; c++) {
        win = "C" + c + "-" + name;
        if (isOpen(win)) {
            selectWindow(win);
            saveAs("TIFF", output + "C" + c + "_" + name);
            close();
        }
    }

    // DO NOT try to reselect original image
}

setBatchMode(false);

