%% EEG Fractal Analysis
% https://github.com/Dorsa-Arezooji/EEG-Fractal-Analysis
% Jan 2019

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


clear
clc

load('RESULTS_GROUP1.mat');
load('RESULTS_GROUP2.mat');

%% ttest2

ch=18; % set the number of channels
for b=1:1:12
    G1=RESULTS_G1{b};
    G2=RESULTS_G2{b};

    for i=1:1:ch
       [h(i),p(i),ci{i},stats(i)]=ttest2(G2(:,i),G1(:,i),0.05,'Both','unequal');
       res(i,1)=p(i);
       res(i,2)=h(i);
       res(i,3)=stats(i).tstat;
       res(i,4)=stats(i).df;
       results{b}=res;
    end
end
