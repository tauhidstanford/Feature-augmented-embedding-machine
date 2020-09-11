rng(42) % For reproducibility

%% Creation of data. Data consists of two Gaussian components. One component
% is of 0 mean and unit variance and other one is 1 mean and unit variance.
x1=randn(100,50);
x2=1+randn(100,50);
x=[x1;x2];
groundTruth=[ones(1,100) 2*ones(1,100)];

%% Data analysis by FEM
reduced_Dim=2; % Final reduced dimension
pointLimit=5000; % If data is of more than pointLimit number of points
% (5000 here), FEM learns the data structure from the first 5000 points.

% FEM with custom center defined in comp_center1.m and distance metric
% defined in com_distance1.m
[finalSCAout] = fem_custom(x, reduced_Dim,@comp_center1,@comp_distance1,pointLimit);

FS=14;
figure
gscatter(finalSCAout(:,1),finalSCAout(:,2),groundTruth)
set(gca,'FontSize',FS)
xlabel('FEM1')
ylabel('FEM2')
axis tight;