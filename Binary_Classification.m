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