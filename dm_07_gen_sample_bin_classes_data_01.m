clc
clear
close all

load pr03.mat
class_label1 = 3;
class_label2 = 12;
Targs = TrainingData(:,49);
locs = find(Targs == class_label1 | Targs == class_label2);




