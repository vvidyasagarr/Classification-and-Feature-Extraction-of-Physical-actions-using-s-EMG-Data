clc;
clear;
close all;

normal_features();
aggressive_features();
normal_label();
aggressive_label();

accuracies=[zeros(18,10)];
sample_data = Binary_Classification(1,4);
two_class_Accuracy=multikNN(sample_data(:,1:48),sample_data(:,49),[1 4]);
accuracies=[zeros(18,10)];

n=1:20;
for i=2:19
 alpha=[];
 alpha= nchoosek(n,i);
 a=alpha(1:floor(size(alpha,1)/10):size(alpha,1),:);

 for j=1:10
 sample_data= Multiple_Classification(a(j,:));
 accuracies(i-1,j)=multikNN(sample_data(:,1:48),sample_data(:,49),a(j,:));
  end
 
end
mean_accuracies=mean(accuracies,2);

%Plotting the Accuracies.
figure;
plot(mean_accuracies,'b','LineWidth',1.5);
hold on;
h=plot(mean_accuracies,'rs');
set(h,'MarkerFaceColor',get(h,'Color'));
hold off;
title('Accuracy plots');

function normal_features()
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
    subdirPath = ([dirname,'/',folders(ix).name,'/Normal/txt']);
    subdirFiles = ([dirname,'/',folders(ix).name,'/Normal/txt/*txt']);
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
        idata_nor_set(count,:) = idata_full(:)';
        Target=[Target;rem(count,20)+1];
        end
        
end
end
 %%
 Z=[idata_nor_set Target];
disp('Size of the feature matrix:');
disp(size(idata_nor_set));
    
%%
figure;
plot(idata_nor_set([1,32],:)','s-')
%%
save Features_Normal.mat idata_nor_set;
end

function aggressive_features()
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
figure;
plot(idata_agg_set([1,32],:)','s-')
%%
save Features_Aggressive.mat  idata_agg_set;
end

function[sample_data] =Binary_Classification(class_label1,class_label2)
load('Features_Normal.mat');
load('labels_Normal.mat');
load('Features_Aggressive.mat');
load('labels_Aggressive.mat');

Targs=[label_nor_vec label_aggressive_vec]';
X=[idata_nor_set;idata_agg_set];
stem(Targs);
TrainingData=[X Targs];
locs=[];

locs = find(Targs == class_label1 | Targs == class_label2);
sample_data = TrainingData(locs,:);
end


function normal_label()
dirname = '/Users/vidyasagar/Documents/PR/EMG_PR_Ca03_DATASET';
dirname1 = '/Users/vidyasagar/Documents/PR/EMG_PR_Ca03_DATASET/sub*';
count = 0;
    clear files;
     folders = dir(dirname1);
L = length(folders);  
NTrials = 15;
sub_inx = 2;
file_inx = 3;

head1 = sprintf('Directories Count:%d',L);

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
 
 label_nor_vec = label_nor_vec;
 save labels_Normal.mat label_nor_vec;
 figure;
 stem(label_nor_vec);
end

function aggressive_label()
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
    subdirPath = ([dirname,'/',folders(ix).name,'/Aggressive/txt']);
    subdirFiles = ([dirname,'/',folders(ix).name,'/Aggressive/txt/*txt']);
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
            label_aggressive_vec(count) = jx;
    end
end
end
 %%
 label_aggressive_vec = 10+label_aggressive_vec;
 save labels_Aggressive.mat label_aggressive_vec;
 %%
 figure;
 stem(label_aggressive_vec);
end


function[sample_data] =Multiple_Classification(classes)
load('Features_Normal.mat');
load('labels_Normal.mat');
load('Features_Aggressive.mat');
load('labels_Aggressive.mat');

Targs=[label_nor_vec label_aggressive_vec]';
X=[idata_nor_set;idata_agg_set];
stem(Targs);
TrainingData=[X Targs];
locs=[];

for i=1:size(classes,2)
locs = [locs find(Targs == classes(i))];
end

sample_data = TrainingData(locs,:);
end

function validationAccuracy = multikNN(predictors,response,class_vec)

classificationKNN = fitcknn(...
    predictors, ...
    response, ...
    'Distance', 'Euclidean', ...
    'Exponent', [], ...
    'NumNeighbors', 3, ...
    'DistanceWeight', 'Equal', ...
    'Standardize', true, ...
    'ClassNames', class_vec);

trainedClassifier.ClassificationKNN = classificationKNN;
trainedClassifier.About = 'This struct is a trained model exported from Classification Learner R2018b.';
trainedClassifier.HowToPredict = sprintf('To make predictions on a new predictor column matrix, X, use: \n  yfit = c.predictFcn(X) \nreplacing ''c'' with the name of the variable that is this struct, e.g. ''trainedModel''. \n \nX must contain exactly 2 columns because this model was trained using 2 predictors. \nX must contain only predictor columns in exactly the same order and format as your training \ndata. Do not include the response column or any columns you did not import into the app. \n \nFor more information, see <a href="matlab:helpview(fullfile(docroot, ''stats'', ''stats.map''), ''appclassification_exportmodeltoworkspace'')">How to predict using an exported model</a>.');

% Perform cross-validation
partitionedModel = crossval(trainedClassifier.ClassificationKNN, 'KFold', 10);

% Compute validation predictions
[validationPredictions, validationScores] = kfoldPredict(partitionedModel);

% Compute validation accuracy
validationAccuracy = 1 - kfoldLoss(partitionedModel, 'LossFun', 'ClassifError');
end