close all; clear all; clc
warning off;
addpath(genpath('ClusteringMeasure'));
addpath(genpath('utils'));
addpath(genpath('measure'));
ResSavePath = 'Res/';
MaxResSavePath = 'final_res/';
num_p=3;


if(~exist(ResSavePath,'file'))
    mkdir(ResSavePath);
    addpath(genpath(ResSavePath));
end

if(~exist(MaxResSavePath,'file'))
    mkdir(MaxResSavePath);
    addpath(genpath(MaxResSavePath));
end

dataPath = './datasets/';
% datasetName = {'Flower17','AwA_fea','MNIST_fea','Caltech256','VGGFace2_200_4Views','TinyImageNet_4Views','YouTubeFace50_4Views'}; 
% datasetName = {'AwA_fea'};
datasetName = {'3sources','Yale','Texas','Cornell','WebKB_cor2views','MSRCV1','Washington','WebKB_Wisconsin2views','Wisconsin','Dermatology','ORLRnSp','ORL_3Views','ORL_4Views','NGs','BBCSport','Movies','BBC','proteinFold','WebKB','HW_2Views','MFeat_2Views','uci-digit','Cora','Wiki_fea','CiteSeer','NUS-WIDE-SCENE','NUS-WIDE-OBJECT-10','Reuters-7200','Hdigit','SUNRGBD','STL10_4Views','Reuters','NUS-WIDE-OBJECT','YouTubeFace10_4Views','CIFAR100_Train_4Views','FashionMNIST_4Views','MNIST_ALL_4Views','Flower17','AwA_fea','MNIST_fea','Caltech256','TinyImageNet_4Views','YouTubeFace50_4Views'};

for dataIndex = 1 : length(datasetName)
    dataName = [dataPath datasetName{dataIndex} '.mat'];
    load(['F:\wxh_work\datasets\MultiView_Dataset\',datasetName{dataIndex} ]);
    gt=Y;
    num_cluster = max(gt);
    num_view = length(X);
    fea=cell(num_view,1);
    for v=1:num_view
        fea{v}=X{v};
    end
    num_cluster = max(gt);
    num_view = length(fea);
    for v=1:num_view
        fea{v} = zscore(fea{v})';
    end
    ResBest = zeros(1, 8);
    ResStd = zeros(1, 8);
    % parameters setting
    r1 = 10.^(1:1:1);
    acc = zeros(length(r1), 1);
    nmi = zeros(length(r1), 1);
    purity = zeros(length(r1), 1);
    idx = 1;
    for r1Index = 1 : length(r1)
        r1Temp = r1(r1Index);
        fprintf('Please wait a few minutes\n');
        disp(['Dataset: ', datasetName{dataIndex}, ...
            ', --r1--: ', num2str(r1Temp)]);
        tic;
        [Z, Obj,alpha,beta,C] = RLMVC(fea, num_cluster,num_p,r1Temp);
        time=toc;
        Z=Z';
        Z_normalized = Z ./ sqrt(sum(Z .^ 2, 2));
        res = myNMIACCwithmean(Z_normalized,Y,num_cluster);
        resFile2 = [MaxResSavePath datasetName{dataIndex}, '-ACC=', num2str(res(1)), '.mat'];
        save(resFile2,  'res', 'gt', 'Z_normalized', 'Obj','time','alpha','beta','C');
    end
end