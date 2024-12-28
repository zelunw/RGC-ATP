macro "MaskMergePrePost" {
	selectWindow("reg_concat_chAvg_sliceAvg_cp_masks.png");
	run("32-bit");
	selectWindow("reg_concat_regToPre_sliceAvg_chAvg_cp_masks.png");
	run("32-bit");
	
	run("Merge Channels...", "c1=reg_concat_chAvg_sliceAvg_cp_masks.png c2=reg_concat_chAvg_sliceAvg.tif create");
	rename("pre");
	
	run("Merge Channels...", "c1=reg_concat_regToPre_sliceAvg_chAvg_cp_masks.png c2=reg_concat_regToPre_sliceAvg_chAvg.tif create");
	run("Concatenate...", "open image1=pre image2=Composite");
	
	rename("TrackmateInput");
	run("glasbey_on_dark");
	Stack.setActiveChannels("01");
	Stack.setChannel(2);
	run("Grays");
	run("Enhance Contrast", "saturated=0.35");
	
	saveAs("Tiff");
}