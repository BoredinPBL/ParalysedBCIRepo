clear
clc

block = 'EEGsigsimagined_subjectpilotYY_session20170602_block2';
block_name = strcat(block, '.Poly5');

%time_marker_name = 'EEGsigsimagined_subjectpilotYY_session20170602_block2_timemarker2.txt';
time_marker_name = strcat(block,'_timemarker.txt');
prompt_start_time_marker = dlmread(time_marker_name);

x = TMSi.Poly5.read(block_name);

Fs = x.sample_rate;
EEG_data = [x.samples]';
running_time = x.time;
timeofstudy = x.date;
channel_names = x.channels;



n_max = length(channel_names);
channel_names_alone = [];
for n = 1:n_max
    channel = string(channel_names{1,n}.name);
    channel_names_alone = [channel_names_alone, channel];
end

channel_names = channel_names_alone;


save(strcat(block,'.mat'),'channel_names','EEG_data','Fs','running_time','timeofstudy','prompt_start_time_marker')