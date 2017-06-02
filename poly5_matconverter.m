clear
clc

EEGsigs_subject0_session1_block4_imagined = TMSi.Poly5.read('EEGsigs_subject0_session1_block4-imagined.Poly5');

Fs = EEGsigs_subject0_session1_block4_imagined.sample_rate;
EEG_data = [EEGsigs_subject0_session1_block4_imagined.samples]';
running_time = EEGsigs_subject0_session1_block4_imagined.time;
timeofstudy = EEGsigs_subject0_session1_block4_imagined.date;
channel_names = EEGsigs_subject0_session1_block4_imagined.channels;



n_max = length(channel_names);
channel_names_alone = [];
for n = 1:n_max
    channel = string(channel_names{1,n}.name);
    channel_names_alone = [channel_names_alone, channel];
end

channel_names = channel_names_alone;


save('EEGsigs_subject0_session1_block4_imagined','channel_names','EEG_data','Fs','running_time','timeofstudy')