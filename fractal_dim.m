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

method=input('Katz(1) Higuchi(2) FBM(3): ');

subj_count=40; % set the subject count
        
for band=1:1:12
    
for subj=1:1:subj_count
    
load(strcat(num2str(subj),'.mat'));
eeg=EEG;
[s1,s2,s3]=size(eeg);
eeg=reshape(eeg,s1,s2*s3);
s3=1;

%~~~~~~~~~~~~~~~~~~~~~~~Bandpass FIR filtering~~~~~~~~~~~~~~~~~~~~~~~~~~~~%

switch band
    
    case 1
D=designfilt('bandpassfir','FilterOrder',20,'CutoffFrequency1',1,...
             'CutoffFrequency2',4,'SampleRate',200,'Window','hamming');       
    case 2
D=designfilt('bandpassfir','FilterOrder',20,'CutoffFrequency1',4,...                
             'CutoffFrequency2',8,'SampleRate',200,'Window','hamming');       
    case 3
D=designfilt('bandpassfir','FilterOrder',20,'CutoffFrequency1',8,...
             'CutoffFrequency2',10,'SampleRate',200,'Window','hamming');
    case 4
D=designfilt('bandpassfir','FilterOrder',20,'CutoffFrequency1',10,...
             'CutoffFrequency2',12,'SampleRate',200,'Window','hamming');
    case 5
D=designfilt('bandpassfir','FilterOrder',20,'CutoffFrequency1',8,...
             'CutoffFrequency2',13,'SampleRate',200,'Window','hamming');
    case 6
D=designfilt('bandpassfir','FilterOrder',20,'CutoffFrequency1',12,...
             'CutoffFrequency2',15,'SampleRate',200,'Window','hamming');
    case 7
D=designfilt('bandpassfir','FilterOrder',20,'CutoffFrequency1',15,...
             'CutoffFrequency2',18,'SampleRate',200,'Window','hamming');
    case 8
D=designfilt('bandpassfir','FilterOrder',20,'CutoffFrequency1',18,...
             'CutoffFrequency2',25,'SampleRate',200,'Window','hamming');
    case 9
D=designfilt('bandpassfir','FilterOrder',20,'CutoffFrequency1',25,...
             'CutoffFrequency2',30,'SampleRate',200,'Window','hamming');
    case 10
D=designfilt('bandpassfir','FilterOrder',20,'CutoffFrequency1',13,...
             'CutoffFrequency2',30,'SampleRate',200,'Window','hamming');
    case 11
D=designfilt('bandpassfir','FilterOrder',20,'CutoffFrequency1',30,...
             'CutoffFrequency2',40,'SampleRate',200,'Window','hamming');
    case 12

end

for ch=1:1:s1
    if band~=12
       eeg_filt(ch,:)=filter(D,eeg(ch,:));
    else
        eeg_filt(ch,:)=eeg(ch,:);
    end
end

switch method
        
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Katz~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
         
        case 1   
dist=zeros(s2-1,1);
d_ind=zeros(s2-1,1);
L_katz=zeros(s1,s3);
a=zeros(s1,s3);
d=zeros(s1,s3);
FD_Katz_all=zeros(s1,s3);
FD_Katz=zeros(s1,1);

for ch=1:1:s1                                                              
    for tr=1:1:s3                                                          
        for i=1:1:s2-1
            dist(i)=sqrt((eeg_filt(ch,i,tr)-eeg_filt(ch,i+1,tr))^2+1);
            d_ind(i)=sqrt((eeg_filt(ch,i,tr)-eeg_filt(ch,1,tr))^2+(i-1)^2);
        end
        L_katz(ch,tr)=sum(dist(:));
        a(ch,tr)=sum(dist(:))/(s2-1);
        d(ch,tr)=max(d_ind(:));
        FD_Katz_all(ch,tr)=(log10(L_katz(ch,tr)/a(ch,tr)))/...
                           (log10(d(ch,tr)/a(ch,tr)));
    end
    FD_Katz(ch)=sum(FD_Katz_all(ch,:));
    FDK_all(subj,ch)=FD_Katz(ch);
end
FDK{band}=FDK_all;
clear('eeg_filt')

%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Higuchi~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
   
        case 2
N=s2*s3;
kmax=200;

for ch=1:1:s1                                                         
    for tr=1:1:s3                                                       
        eeg_ind=eeg_filt(ch,:);
        for k=1:1:kmax
            x(ch,tr,k)=log(k);
            L_Higuchi_all=zeros(k,1);
            for m=1:1:k
                for j=1:1:fix((N-m)/k)
                    L_Higuchi_all_ind=abs(eeg_ind(m+j*k)-eeg_ind(m+(j-1)*k));
                    L_Higuchi_all(m,1)=L_Higuchi_all(m,1)+L_Higuchi_all_ind;
                end
                L_Higuchi_all(m,1)=L_Higuchi_all(m,1)*(N-1)/(k*k*fix((N-m)/k));
                Lm_Higuchi(ch,tr,m)=L_Higuchi_all(m,1);
            end
            L_Higuchi(ch,tr,k)=sum(Lm_Higuchi(ch,tr,:))/k;
            y(ch,tr,k)=log(L_Higuchi(ch,tr,k));
        end
        p=-polyfit(x(ch,tr,:),y(ch,tr,:),1);
        FD_Higuchi_all(ch,tr)=p(1);
    end
    FD_Higuchi(ch)=sum(FD_Higuchi_all(ch,:));
    FDH_all(subj,ch)=FD_Higuchi(ch);
end
FDH{band}=FDH_all;
clear('eeg_filt')

%~~~~~~~~~~~~~~~Fractional Brownian Motion (Hurst parameter)~~~~~~~~~~~~~~%

        case 3
for ch=1:1:s1                                                              
    for tr=1:1:s3  
        h=wfbmesti(eeg_filt(ch,:));
        Hurst_all1(ch,tr)=h(1);
        Hurst_all2(ch,tr)=h(2);
        Hurst_all3(ch,tr)=h(3);
    end
    H_par1(ch)=sum(Hurst_all1(ch,:));
    Hurst1(subj,ch)=H_par1(ch);
    H_par2(ch)=sum(Hurst_all2(ch,:));
    Hurst2(subj,ch)=H_par2(ch);
    H_par3(ch)=sum(Hurst_all3(ch,:));
    Hurst3(subj,ch)=H_par3(ch);
end
FBM1{band}=Hurst1;
FBM2{band}=Hurst2;
FBM3{band}=Hurst3;
clear('eeg_filt')

end  
end 
end
