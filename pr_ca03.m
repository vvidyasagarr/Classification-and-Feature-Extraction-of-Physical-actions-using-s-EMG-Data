clc;
clear;
close all;

direc = dir('/Users/vidyasagar/Documents/PR/EMG_PR_Ca03_DATASET');
disp(direc);

subj1_normal_bow = importdata('/Users/vidyasagar/Documents/PR/EMG_PR_Ca03_DATASET/sub1/Normal/txt/Bowing.txt');
subj1_normal_clap = importdata('/Users/vidyasagar/Documents/PR/EMG_PR_Ca03_DATASET/sub1/Normal/txt/Clapping.txt');

subj2_normal_bow = importdata('/Users/vidyasagar/Documents/PR/EMG_PR_Ca03_DATASET/sub2/Normal/txt/Bowing.txt');
subj2_normal_clap = importdata('/Users/vidyasagar/Documents/PR/EMG_PR_Ca03_DATASET/sub2/Normal/txt/Clapping.txt');

subj3_normal_bow = importdata('/Users/vidyasagar/Documents/PR/EMG_PR_Ca03_DATASET/sub3/Normal/txt/Bowing.txt');
subj3_normal_clap = importdata('/Users/vidyasagar/Documents/PR/EMG_PR_Ca03_DATASET/sub3/Normal/txt/Clapping.txt');

subj4_normal_bow = importdata('/Users/vidyasagar/Documents/PR/EMG_PR_Ca03_DATASET/sub4/Normal/txt/Bowing.txt');
subj4_normal_clap = importdata('/Users/vidyasagar/Documents/PR/EMG_PR_Ca03_DATASET/sub4/Normal/txt/Clapping.txt');


bow = [subj1_normal_bow ; subj2_normal_bow ;subj3_normal_bow ; subj4_normal_bow ];
clap = [subj1_normal_clap ; subj2_normal_clap ; subj3_normal_clap ; subj4_normal_clap];

class1  = [bow  ones(40234,1)];
class2  = [clap  -1*ones(40425,1)];

Z=[class1;class2];

