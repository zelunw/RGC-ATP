Input files are raw timeseries .tif images saved by ScanImage. Each sample has a baseline 'pre' image and a 'post' treatment image that is aligned to the 'pre' by the following steps: 

1. Place the raw 'pre' .tif in a directory `/YourSampleName/pre`. Place the raw 'post' .tif in a directory `/YourSampleName/post`. Run `ProcessRaw.ipynb` in `/YourSampleName/pre` and `/YourSampleName/post`
    If directory contains multiple .tifs they will be concatenated in order of file last modified time
    Timeseries are registered using Suite2p (https://github.com/MouseLand/suite2p) 
    and placed in a new sub-directory `/registered0`

2. Run `RegisterPostToPre.ipynb` in directory `/YourSampleName/post/registered0`

3. Install and open Cellpose GUI (https://github.com/MouseLand/cellpose)
    Run Cellpose on `/YourSampleName/pre/registered0/reg_concat_chAvg_sliceAvg.tif` and `/YourSampleName/post/registered0/reg_concat_regToPre_sliceAvg_chAvg.tif` using `VglutTimelapseModel`
    Save Cellpose outputs `_cp_masks.png` and `_seg.npy` (Ctrl + N, Ctrl + S)

4. Open ImageJ-Fiji (https://imagej.net/software/fiji/) and open the following files:
    `/YourSampleName/pre/registered0/reg_concat_chAvg_sliceAvg.tif`
    `/YourSampleName/pre/registered0/reg_concat_chAvg_sliceAvg_cp_masks.png`
    `/YourSampleName/post/registered0/reg_concat_regToPre_sliceAvg_chAvg.tif`
    `/YourSampleName/post/registered0/reg_concat_regToPre_sliceAvg_chAvg_cp_masks.png`
    Run `MaskMergePrePost.ijm` in ImageJ-Fiji and save the output `TrackmateInput.tif` to `/YourSampleName/post/registered0/`
    Run the Trackmate plugin (https://imagej.net/plugins/trackmate/) in ImageJ-Fiji (Plugins -> Tracking -> TrackMate) using the 'Label image detector' and 'LAP Tracker'. Save the resulting `TrackmateInput.xml` and export Tracks as `export.csv` in `/YourSampleName/post/registered0/`

5. In `/YourSampleName/post/registered0/` create a file `delay.txt` containing the number of seconds elapsed between experimental manipulation and start of post-manipulation image acquisition. Run `MeasureSample.ipynb` in `/YourSampleName/post/registered0/`. Outputs are FRET (YFP/CFP) values of ROIs across time for:
- `Unmatched_FRET_PRE.csv` - 'pre' timelapse
- `Unmatched_FRET_POST.csv` - 'post' timelapse
- `Matched_FRET_PRE.csv` - 'pre' timelapse, plotting ROIs that have a matched ROI in corresponding 'post' timelapse
- `Matched_FRET_POST.csv` - 'post' timelapse, lotting ROIs that have a matched ROI in corresponding 'pre' timelapse





