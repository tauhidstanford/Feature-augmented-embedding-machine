clear
close all

load('s1.mat'); % For reproducibility
rng(s1)
%% Data locading and pre-processing
% Load data and ground truth. Ground truth is only for visualization of 
% results

load('X_data.mat'); % data
load('Y_data.mat'); % ground truth

groundTruthFull=double(Y_data)+1;
I1=find(groundTruthFull==1);
I2=find(groundTruthFull==2);
I3=find(groundTruthFull==5);
I4=find(groundTruthFull==6);
groundTruth=[ones(1,length(I1)) ones(1,length(I2)) 2*ones(1,length(I3)) 2*ones(1,length(I4))];
X1=X_data(I1,:);
X2=X_data(I2,:);
X3=X_data(I3,:);
X4=X_data(I4,:);
X=[X1;X2;X3;X4];
X=double(X);
X(isnan(X))=0;
X=zscore(X);

%% Analysis of data by FEM and PCA
reduced_Dim=3; % Final reduced dimension (P in the manuscript)
pointLimit=5000; % If data is of more than pointLimit number of points
% (5000 here), FEM learns the data structure from the first 5000 points.

% FEM analysis
fem_Out=fem(X,reduced_Dim,pointLimit);

% Comparison with principal component analysis (PCA)
[cff,pca_Out,~]=pca(X,'NumComponents',reduced_Dim);
% 

%% Visualization of results from FEM and PCA

FS=14;
legendX={'Non-DS','DS'};
binnedGT = discretize(groundTruth,[0 1.1 2],'categorical',legendX);


figure
gscatter(pca_Out(:,1),pca_Out(:,2),binnedGT)
set(gca,'FontSize',FS)
xlabel('PC1')
ylabel('PC2')
axis tight;

figure
gscatter(fem_Out(:,1),fem_Out(:,2),binnedGT)
set(gca,'FontSize',FS)
xlabel('FEM1')
ylabel('FEM2')
axis tight;


