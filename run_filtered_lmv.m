% This code runs the SMVSC algorithm on Handwritten£¬Caltech-101£¬Citeseer dataset.

% Notice: The dataset is organized in a cell array with each element being a view. 
% Each view is represented by a matrix, each row of which is a sample.

% The method is based on LMVSC, the core of LMVSC is encapsulated in an independent matlab function.
% Visit lmv.m directly, if you want to learn the details of its implementation.

clear;
clc;

addpath('./dataset');
addpath('./CANµÄ¹¹Í¼');
% load data and graph
load('Handwritten_numerals.mat');
load('A.mat');

X=data;
y=labels;

nv=length(X);
    
ns=length(unique(y));

% tsne before filtering
% mappedX_origin = tsne(X{3},'Algorithm','barneshut','NumPCAComponents',50,'perplexity',100);
% figure
% gscatter(mappedX_origin(:,1),mappedX_origin(:,2),y)

% Filtering(Core part of this code)
parfor i = 1:nv
    A{i} = (A{i} + A{i}')/2;
    D{i} = diag(sum(A{i}));
    % graph filter order k = 1
    X{i} = 1/2 * (eye(size(X{i},1))+D{i}^(-1/2)*A{i}*D{i}^(-1/2)) * X{i};
    % graph filter order k = 2
    % X{i} = 1/4 * (eye(size(X{i},1))+D{i}^(-1/2)*A{i}*D{i}^(-1/2)) * (eye(size(X{i},1))+D{i}^(-1/2)*A{i}*D{i}^(-1/2)) * X{i};
    % ................
end

% tsne after filtering
% mappedX_filter = tsne(X{3},'Algorithm','barneshut','NumPCAComponents',50,'perplexity',100);
% figure
% gscatter(mappedX_filter(:,1),mappedX_filter(:,2),y)


% Parameter 1: number of anchors (tunable)
numanchor=[10,20];

% Parameter 2: alpha (tunable)
alpha=[0.01,0.1,1,10];
%alpha
for j=1:length(numanchor)
    
    % Perform K-Means on each view
    parfor i=1:nv
        rand('twister',5489);
        [~, H{i}] = litekmeans(X{i},numanchor(j),'MaxIter', 100,'Replicates',10);
    end

    for i=1:length(alpha)
        fprintf('params:\tnumanchor=%d\t\talpha=%f\n',numanchor(j),alpha(i));
        tic;
        
        % LMVSC
        [F,ids] = lmv(X',y,H,alpha(i));
        
        % Performance evaluation of clustering result
        result=ClusteringMeasure(ids,y);
        
        t=toc;
        fprintf('result:\t%12.6f %12.6f %12.6f %12.6f\n',[result t]);
        
        % Write the evaluation results to a text file
        dlmwrite('Handwritten_quad.txt',[alpha(i) numanchor(j) result t],'-append','delimiter','\t','newline','pc');
        
    end
end