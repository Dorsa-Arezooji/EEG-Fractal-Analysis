# EEG-Fractal-Analysis
A MATLAB script for fractal analysis and visualization of EEG signals

* Electrode Count: 18 (not counting the reference electrode)
* Electrode Locations: Fp1, Fp2, F3, F4, F7, F8, Fz, C3, C4, Cz, T3, T4, T5, T6, P3, P4, Pz, O1, O2 (Cz: reference electrode)
**_The channel location matrix is availible [Channel_loc.mat](https://github.com/Dorsa-Arezooji/EEG-Fractal-Analysis/blob/master/Channel_loc.mat)_**
* Electrode Formation: 10-20 (international system)

## Application
* 
## Data
Each subject's EEG recordings is saved in a matrix: [c, e, t]
* c: channels (default:18)
* e: epoc trains (points in time)
* t: trials

## EEG Preprocessing
Bandpass FIR filters:
1. delta band (1-4Hz)
2.theta band (4-8Hz)
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
    
m

## Fractal Dimensions

* **Katz**

* **Higuchi**

* **Fractional Brownian Motion (Hurst parameter)**

## Box Plots

## Acknowledgements
