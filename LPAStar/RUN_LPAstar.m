% LPA*: Lifelong Planning A* Path Planning Algorithm - MATLAB
% Morteza Haghbeigi, m.haghbeigi@gmail.com

% Initialization
clc
clear
close

% adding paths
addpath('D:\00-Robotics\02-Robot Path Planning\Methods\Astar-Single & Multi-MATLAB')
addpath('D:\00-Robotics\02-Robot Path Planning\Methods\Astar-Single & Multi-MATLAB\SRPP')

%% settings
Model.expandMethod = 'random';   % random or heading
Model.distType = 'manhattan';    % euclidean or manhattan;
Model.adjType = '4adj';          % 4adj or 8adj

%% create Map and Model - loading a Map Matrix

% % load Map and create model - (1:free, o:obstacles)
%  load(map_name, 'Map');
% Model = createModelFromMap(Map, Model);

% % add robot data to model
% Model = addRobotToModel(Model);

%% Create Map and Model by User
Model = createModelBase(Model);
Model = createModelLPAstar(Model);

%% optimal path by LPAstar
% Path: nodeNumbers, coords, dirs
tic
[Model, Path] = myLPAstar(Model);
Sol = Path;
Sol.runTime = toc;
Sol.cost = costL(Sol.coords);
Sol.smoothness = smoothness_by_dir(Sol);

%% display data and plot solution
disp(['run time for path= ' num2str(Sol.runTime)])
disp(Sol)

plotModel(Model)
plotSolution(Sol.coords, [])
% plotAnimation2(Sol.coords)

%% clear temporal data
clear adj_type dist_type

