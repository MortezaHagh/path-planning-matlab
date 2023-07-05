% A*: Single Robot Path Planning Algorithm - MATLAB
% Main code for running the algorithm.
% Morteza Haghbeigi, m.haghbeigi@gmail.com


% Initialization
clc
clear
close

% adding paths
addpath('..\')

%% settings
Model.expandMethod = 'heading';  % random or heading
Model.distType = 'manhattan';    % euclidean or manhattan;
Model.adjType = '4adj';          % 4adj or 8adj

%% create Map and Model - loading a Map Matrix

% % load Map and create model - (1:free, o:obstacles)
%  load(map_name, 'Map');
% Model = createModelFromMap(Map, Model);

% % add robot data to model
% Model = addRobotToModel(Model);

% % Create Model from Samples
% Model = createModelSamples("Obstacle1", Model);

% Create Map and Model by User
Model = createModelBase(Model);

%% optimal path by Astar
% Path: nodeNumbers, coords, dirs
tic
[Model, Path] = myAStar(Model);
Sol = Path;
Sol.runTime = toc;
Sol.cost = costL(Sol.coords);
Sol.smoothness = smoothness_by_dir(Sol);

%% modify path
tic
Mpath = modifyPath (Model, Path);
Msol = Mpath;
Msol.runTime = Sol.runTime + toc;
Msol.cost = costL(Msol.coords);
Msol.smoothness = smoothness(Msol.coords);
%Msol.smoothness = smoothness_by_dir(Msol);  #todo

%% # display data and plot solution
disp(['run time for path= ' num2str(Sol.runTime)])
disp(Sol)

plotModel(Model)
plotSolution(Sol.coords, Msol.coords)
% plotAnimation2(Sol.coords)

%% clear temporal data
clear adj_type dist_type

