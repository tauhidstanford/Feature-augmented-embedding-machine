
clear
close all

rng(0) % For reproducibility
%% Plotting parameters
col = [ [1 0 0]; [0 0 1]; [0 1 0]; [0 0 0]; [0 1 1]; [1 0 1]; [1 1 0]; ...
    [1 .5 .5]; [.5 1 .5]; [.5 .5 1]  ]';
ms = [25 3];mk=['.' '+'];
lgd = {'class 1','class 2'};
SetAR = @(ar)set(gca, 'PlotBoxAspectRatio', [1 ar 1], 'FontSize', 20);
FontS=20;
Nk=6;

%% Data generation. Data consists of two Gaussian components. One component 
% is of 0 mean and unit variance, whereas the other component is of 0
% mean and 4 variance.

num_class=2; % Number of class
M=2000; % Number of points in each class
N=60;
groundTruth = [ones(1,M) 2*ones(1,M)];

A(1:M,1:N) = 0+2*randn(M,N); 
A(M+1:2*M, 1:N) = 0+1*randn(M,N);

dataOriginal=A;
sz=size(dataOriginal);dim_Original=sz(2);

% Visualization of first two dimensions of original data
figure
for ik=1:num_class
    I = find(groundTruth==ik);I=I(1:Nk:end);
    plot(dataOriginal(I,1), dataOriginal(I,2), mk(ik), 'Color', col(:,ik), 'MarkerSize', ms(ik));
hold on
end
xlabel('D1')
ylabel('D2')
set(gca,'FontSize',FontS)
axis tight

%% Data analysis by FEM and PCA

reduced_Dim=2; % The final reduced dimension (P in the manuscript)
pointLimit=5000; % If data is of more than pointLimit number of points
% (5000 here), FEM learns the data structure from the first 5000 points.

% FEM
FEM_Out=fem(dataOriginal,reduced_Dim,pointLimit);

% PCA
[cff,PCA_Out,~]=pca(dataOriginal,'NumComponents',reduced_Dim);

%% Visualization of FEM and PCA results

figure
for ik=1:num_class
    I = find(groundTruth==ik);I=I(1:Nk:end);
    plot(FEM_Out(I,1), FEM_Out(I,2), mk(ik), 'Color', col(:,ik), 'MarkerSize', ms(ik));
hold on
end
xlabel('FEM1')
ylabel('FEM2')
set(gca,'FontSize',FontS)
axis tight

 figure
for ik=1:num_class
    I = find(groundTruth==ik);I=I(1:Nk:end);
    plot(PCA_Out(I,1), PCA_Out(I,2),mk(ik), 'Color', col(:,ik), 'MarkerSize', ms(ik));
hold on
end
set(gca,'FontSize',FontS)
xlabel('PC1')
ylabel('PC2')
axis tight

