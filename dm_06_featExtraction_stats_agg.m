clc
clear 
close all;
%--------------------------------------------------------------------------
% Purpose: To plot EMG signals of Normal actions : specified files
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

sub_inx = 2;
file_inx = 3;
Nsegments = 15;
Target=[ ];
% SegmLen = 200;
%%
head1 = sprintf('Directories Count:%d',L);
disp(head1);
% disp(L);
for ix =  1:L
    sub_message = sprintf('Subject no.:%d',ix);
    disp(sub_message);
    subdirPath = ([dirname,'/',folders(ix).name,'/Aggressive/txt']);
    subdirFiles = ([dirname,'/',folders(ix).name,'/Aggressive/txt/*txt']);
    filesN = dir(subdirFiles);
%     subdirPath = ([dirname,files(1).name,'\Normal']);
%     subdirFiles = ([dirname,files(1).name,'\Normal\Handshaking.txt']);
%     files2 = dir(subdirFiles);
%--------------------------------------------------------------------------
% targetvec(count) = 1;
L2 = length(filesN);
nr_fl_ms = sprintf('No. of files:%d',L2);
 disp(nr_fl_ms);
for jx = 1:L2
% display(jx);
%     display(count);
%     count = count + 1;
    fname = fullfile(subdirPath,'/',filesN(jx).name);
%     file_mess = sprintf([filesN(jx).name]);
    disp(filesN(jx).name);
    x1 = importdata(fname);
    [R,C] = size(x1);
    size_data = sprintf('Rows:%d, Cols:%d',R,C);
    disp(size_data);
   [Mrows Mcols] = size(x1);
    SegmLen = floor(Mrows/Nsegments);
%     disp(size(x1,1));
%         datav = x1(:,cx);
%         if jx == 1
%         Nsegments = floor(size(x1,1)/SegmLen);
%         end

        for lx = 1:Nsegments
            count = count + 1;
            idata_full =[];
%             count = count+1;
            for cx = 1:Mcols
%                 if lx < Nsegments
        pattern = x1((lx-1)*SegmLen+1:lx*SegmLen,cx);
         for sx = 1:3
             seg_emg = pattern((sx-1)*floor(SegmLen/3)+1:(sx)*floor(SegmLen/3));
%--------------------------------------------------------------------------        
        % AR coefficients 
%          idata = wavenergy(seg_emg,3);

%          idata = MyWavenergy(seg_emg,Levels,motherWL);  
%--------------------------------------------------------------------------
        % Energy Values
%         idata = sum(abs(seg_emg).^2);
%--------------------------------------------------------------------------      
%             else
%         seg_emg = datav((Nsegments-1)*SegmLen+1:end);
%          idata = arcov(seg_emg,10);
          idata = statmeasure_vec(seg_emg);
%             end        
%         idata = Feature_Construction_1(datav,6);
        idata_full = [idata_full idata(:)'];
         end
            end
%                  stem(idata_full);
%                  drawnow; pause(0.1); 
        idata_agg_set(count,:) = idata_full(:)';
        Target=[Target;rem(count,20)+1];
        end
        
end
end
 %%
 Z=[idata_agg_set Target];
disp('Size of the feature matrix:');
disp(size(idata_agg_set));
    
%%
plot(idata_agg_set([1,32],:)','s-')
%%
save feat_stats_02_03_agg.mat  idata_agg_set;