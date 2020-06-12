# EEG-Fractal-Analysis
A MATLAB code for fractal analysis and visualization of EEG signals

## How to Use
1. Save each subject's EEG recordings in a matrix named "EEG" then save it as a .mat file named "N.mat" (N={1, 2, .., subj_count}) in the working directory.
   ```
   Each subject's EEG recordings matrix: [c, e, t]
   c: number of channels
   e: epoc trains (points in time)
   t: number of trials
   ```
2. Set the subject count (subj_count) in "fractal_dim.m".
3. Run "fractal_dim.m" and select 1 for Katz FD (fractal dimension) 2 for Higuchi FD or 3 for Fractional Brownian Motion when prompted.
4. If you are comparing two groups of subjects, create a separate folder for each one, containing the EEG recordings of all of that group's subjects, and copy "fractal_dim.m" in each folder and run it.
5. Name the resulting matrices as "RESULTS_G1" and "RESULTS_G2" and save them as "RESULTS_GROUP1.mat" and "RESULTS_GROUP2.mat" respectively.
6. Set the number of channels in "statistical_results.m" and run.
7. Save the results matrix as "RESULTS.mat".
8. Add the ["eeglab"](https://github.com/sccn/eeglab) toolbox to MATLAB.
9. In the command line type `>> eeglab`.
10. Copy "Channels_loc.mat" to the working directory and run "topoplot_results.m".

**_The channel location matrix is availible [Channel_loc.mat](https://github.com/Dorsa-Arezooji/EEG-Fractal-Analysis/blob/master/Channel_loc.mat)_**
   ```
   Electrode Count: 18 (not counting the reference electrode)
   Electrode Locations: Fp1, Fp2, F3, F4, F7, F8, Fz, C3, C4, Cz, T3, T4, T5, T6, P3, P4, Pz, O1, O2 
   Reference Electrode: Cz
   Electrode Formation: 10-20 (international system)
   ```

## How it Works
Each subject's EEG recording is bandpass filtered into the following frequency bands:
  ```
  1. delta band (1-4Hz)
  2. theta band (4-8Hz)
  3. alpha I band (8-10Hz)
  4. alpha II band (10-12Hz)
  5. alpha band (8-13Hz)
  6. beta I band (12-15Hz)
  7. beta II band (15-18Hz)
  8. beta III band (18-25Hz)
  9. beta IV band (25-30Hz)
  10. beta band (13-30Hz)
  11. gamma band (30-40Hz)
  12. all frequency bands
  ```
Then, depending on the chosen method (Katz, Higuchi, Fractional Brownian Motion), the fractal dimension for each channel will be calculated in each frequncy band for each subject.
Next, the results from a t-test, comparing the results from the two groups, is used for the topoplots.

![katz FD](https://github.com/Dorsa-Arezooji/EEG-Fractal-Analysis/blob/master/images/Katz.png)
