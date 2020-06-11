%% EEG Fractal Analysis
% https://github.com/Dorsa-Arezooji/EEG-Fractal-Analysis

% HOW TO USE:
% 1. Save each subject's EEG recordings in a matrix named "EEG" then save it as a .mat
%    file named "N.mat" (N={1, 2, .., subj_count}) in the working directory.
% 2. Set the subject count (subj_count) in "fractal_dim.m".
% 3. Run "fractal_dim.m" and select 1 for Katz FD (fractal dimension) 2 for Higuchi FD
%    or 3 for Fractional Brownian Motion when prompted.
% 4. If you are comparing two groups of subjects, create a separate folder for each
%    one, containing the EEG recordings of all of that group's subjects, and copy
%    "fractal_dim.m" in each folder and run it.
% 5. Name the resulting matrices as "RESULTS_G1" and "RESULTS_G2" and save them as 
%    "RESULTS_GROUP1.mat" and "RESULTS_GROUP2.mat" respectively.
% 6. Set the number of channels in "statistical_results.m" and run.
% 7. Save the results matrix as "RESULTS.mat".
% 8. Add the "eeglab" (https://github.com/sccn/eeglab) toolbox to MATLAB.
% 9. In the command line type "eeglab".
% 10.  Copy "Channels_loc.mat" to the working directory and run "topoplot_results.m".


close all
clear
clc

load('RESULTS.mat');
load('Channel_loc.mat');

t=results;
figure;
    subplot(3,4,1)
    topoplot(t{1}(:,3),Channel_loc,'conv','on','style','map','numcontour',20);
    title('\delta band(1-4Hz)')
    colorbar
    subplot(3,4,2)
    topoplot(t{2}(:,3),Channel_loc,'conv','on','style','map','numcontour',20);
    title('\theta band(4-8Hz)')
    colorbar
    subplot(3,4,3)
    topoplot(t{3}(:,3),Channel_loc,'conv','on','style','map','numcontour',20);
    title('\alpha I band(8-10Hz)')
    colorbar
    subplot(3,4,4)
    topoplot(t{4}(:,3),Channel_loc,'conv','on','style','map','numcontour',20);
    title('\alpha II band(10-12Hz)')
    colorbar
    subplot(3,4,5)
    topoplot(t{5}(:,3),Channel_loc,'conv','on','style','map','numcontour',20);
    title('\alpha band(8-13Hz)')
    colorbar
    subplot(3,4,6)
    topoplot(t{6}(:,3),Channel_loc,'conv','on','style','map','numcontour',20);
    title('\beta I band(12-15Hz)')
    colorbar
    subplot(3,4,7)
    topoplot(t{7}(:,3),Channel_loc,'conv','on','style','map','numcontour',20);
    title('\beta II band(15-18Hz)')
    colorbar
    subplot(3,4,8)
    topoplot(t{8}(:,3),Channel_loc,'conv','on','style','map','numcontour',20);
    title('\beta III band(18-25Hz)')
    colorbar
    subplot(3,4,9)
    topoplot(t{9}(:,3),Channel_loc,'conv','on','style','map','numcontour',20);
    title('\beta IV band(25-30Hz)')
    colorbar
    subplot(3,4,10)
    topoplot(t{10}(:,3),Channel_loc,'conv','on','style','map','numcontour',20);
    title('\beta band(13-30Hz)')
    colorbar
    subplot(3,4,11)
    topoplot(t{11}(:,3),Channel_loc,'conv','on','style','map','numcontour',20);
    title('\gamma band(30-40Hz)')
    colorbar
    subplot(3,4,12)
    topoplot(t{12}(:,3),Channel_loc,'conv','on','style','map','numcontour',20);
    title('all frequency bands')
    colorbar

