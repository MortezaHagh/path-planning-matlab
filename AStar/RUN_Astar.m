% A*: Single Robot Path Planning Algorithm - MATLAB

% Initialization
clc
clear
close

% adding paths
addpath('..\models');
addpath('..\common');

%% settings
Model.expandMethod = 'heading'; % random or heading
Model.distType = 'manhattan'; % euclidean or manhattan;
Model.adjType = '8adj'; % 4adj or 8adj

%% create Map and Model
create_model_method = 'from_custom';  % from_map_file, from_samples, from_custom

switch create_model_method
case 'from_map_file'
    % load Map file and create model - (1:free, o:obstacles)
    load(map_name, 'Map');
    Model = createModelFromMap(Map, Model);
    Model = addRobotToModel(Model);
case 'from_samples'
    sample_model_name = "Obstacle2";
    Model = createModelSamples(sample_model_name, Model);
case 'from_custom'
    Model = createModelBase(Model);
end

% complete base model for Astar
Model = createModelAstar(Model);

%% optimal path by Astar
% Path: nodeNumbers, coords, dirs
tic
[Model, Path] = myAStar(Model);
Sol = Path;
Sol.runTime = toc;
Sol.cost = calCostL(Sol.coords);
Sol.smoothness = calSmoothnessbyDir(Sol);

%% modify path
tic
Mpath = modifyPath (Model, Path);
Msol = Mpath;
Msol.runTime = Sol.runTime + toc;
Msol.cost = calCostL(Msol.coords);
Msol.smoothness = calSmoothness(Msol.coords);
%Msol.smoothness = calSmoothnessbyDir(Msol);  #todo

%% # display data and plot solution
disp(['run time for path= ' num2str(Sol.runTime)])
disp(Sol)

plotModel(Model)
plotSolution(Sol.coords, Msol.coords)
% plotAnimation2(Sol.coords)

%% clear temporal data
clear adj_type dist_type
