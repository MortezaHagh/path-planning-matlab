clc
clear
close

% setting
Model.distType = 'manhattan';  % euclidean manhattan;
Model.adjType = '4adj';        % 4adj 8adj

% lad map
load("Map.mat");

% create model from map
Model = createModelFromMap(Map, Model);

% add robot to model - by user
Model = addRobotToModel(Model);

% % save model
% save('Model','Model')

% Plot
plotModel(Model);
