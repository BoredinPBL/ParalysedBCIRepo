clc
clear

load('EEGsigs_subject0_session1_block4_imagined.mat')
prompt_times = csvread('prompt_imagined_sub0_session1_block4.csv');

sigs_max = length(EEG_data);
T = 1/Fs;
t = (1:sigs_max)*T;
%plot(EEG_data);

tidy_times = prompt_times(:,[1,2,4,5])-prompt_times(1,6);
EEG_data_filtered = preprocessor2(EEG_data,Fs,3,80,50,26,1);

plot(t(10000:(end-10000)),EEG_data_filtered(10000:(end-10000),:));

f_EEG = fft(EEG_data_filtered(10000:(end-10000)));

figure
plot(f_EEG);



