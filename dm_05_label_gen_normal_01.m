clc
clear 
close all;
%--------------------------------------------------------------------------
% Purpose: To plot EMG signals of Aggressive actions : specified files
%--------------------------------------------------------------------------
%% 
%  Location of the data directory in local system 
dirname = '/Users/vidyasagar/Documents/PR/EMG_PR_Ca03_DATASET';
% replace n with p in before *.txt to extract features for p files. 
%finally replace with t for test signal records
% Specify the file type in the data directory 
dirname1 = '/Users/vidyasagar/Documents/PR/EMG_PR_Ca03_DATASET/sub*';
count = 0;
    clear files;
     folders = dir(dirname1);
L = length(folders);  
NTrials = 15;
sub_inx = 2;
file_inx = 3;
% SegmLen = 200;
%%
head1 = sprintf('Directories Count:%d',L);
% disp(head1);
% disp(L);
for ix =  1:L
    sub_message = sprintf('Subject no.:%d',ix);
    disp(sub_message);
    subdirPath = ([dirname,'/',folders(ix).name,'/Normal/txt']);
    subdirFiles = ([dirname,'/',folders(ix).name,'/Normal/txt/*txt']);
    filesN = dir(subdirFiles);
%     subdirPath = ([dirname,files(1).name,'\Aggressive']);
%     subdirFiles = ([dirname,files(1).name,'\Aggressive\Handshaking.txt']);
%     files2 = dir(subdirFiles);
%--------------------------------------------------------------------------
% targetvec(count) = 1;
L2 = length(filesN);
nr_fl_ms = sprintf('No. of files:%d',L2);
% disp(nr_fl_ms);
for jx = 1:L2
%     display(jx);
%     display(count);
%     count = count + 1;
    fname = fullfile(subdirPath,'/',filesN(jx).name);
%     file_mess = sprintf([filesN(jx).name]);
    disp(filesN(jx).name);
    x1 = importdata(fname);
    [R,C] = size(x1);
    size_data = sprintf('Rows:%d, Cols:%d',R,C);
    disp(size_data);
    
    for lx = 1:NTrials
            count = count + 1;
            idata_full =[];
            label_nor_vec(count) = jx;
    end
end
end
 %%
 %%label_vec = 10+label_vec;
 save labels_nor.mat label_nor_vec;
 %%
 stem(label_nor_vec);
    
