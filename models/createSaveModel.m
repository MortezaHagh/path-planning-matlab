% create a complete model from map file and save it
% map file includes a square matrix with 1 and 0 (free or occupied)
% saves model to Model.mat file

clc
clear
close

% add path
addpath('..\common');

% settings
Model.expandMethod = 'random'; % random or heading
Model.distType = 'manhattan'; % euclidean manhattan;
Model.adjType = '4adj'; % 4adj 8adj

% lad map
load("Map.mat");

% create model from map
Model = createModelFromMap(Map, Model);

% add robot to model - by user
Model = addRobotToModel(Model);

% save model
save('Model', 'Model')

% Plot
plotModel(Model);
