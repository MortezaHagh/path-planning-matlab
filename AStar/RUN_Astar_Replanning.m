% A* replanning: Single Robot Path Planning Algorithm - MATLAB
% with remapping in case of new obstacle detection

% Initialization
clc
clear
close

% adding paths
addpath('..\models');
addpath('..\common');

%% setting
Model.expandMethod = 'heading'; % random or heading
Model.distType = 'euclidean'; % euclidean or manhattan;
Model.adjType = '8adj'; % 4adj or 8adj

%% create Map and Model
create_model_method = 'from_custom'; % from_map_file, from_samples, from_custom

switch create_model_method
    case 'from_map_file'
        % load Map file and create model - (1:free, o:obstacles)
        map_name = 'Map.mat';
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

% add dynamic obstacles
Model = newObstacles(Model);

InitModel = Model;

%% start timer
tic

%% pp
% initial pp t0 (each displacement btween nodes takes 1 sec)
[Model, Path] = myAStar(Model);

% preallocation
newObstNode = 0;
Sol.nodeNumbers = [0];

t = 0;
pt = 0;

while Sol.nodeNumbers(end) ~= Model.Robot.targetNode
    t = t + 1;
    pt = pt + 1;

    % insert new obstacles
    if isfield(Model, 'NewObsts')

        for i = 1:Model.NewObsts.count

            if t == Model.NewObsts.t(i)
                newObstNode(end + 1) = Model.NewObsts.nodeNumbers(i);
                Model.Obsts.x(end + 1) = Model.NewObsts.x(i);
                Model.Obsts.y(end + 1) = Model.NewObsts.y(i);
                Model.Obsts.nodeNumber(end + 1) = newObstNode(end);
                Model.Obsts.count = Model.Obsts.count + 1;
            end

        end

    end

    % check if path replanning is needed
    if any(Path.nodeNumbers(pt) == Model.Obsts.nodeNumber)
        Model.Robot.startNode = Sol.nodeNumbers(end);
        xy = Model.Nodes.cord(:, Model.Robot.startNode);
        Model.xs = xy(1);
        Model.ys = xy(2);
        dirs = nodes2dirs(Sol.nodeNumbers, Model);
        Model.dir = dirs(end);
        [Model, Path] = myAStar(Model);
        pt = 2;
    end

    % update final sol
    Sol.nodeNumbers(t) = Path.nodeNumbers(pt);
end

% process time
Sol.runTime = toc;

% final solution
Sol.coords = nodes2coords(Sol.nodeNumbers, Model);
Sol.dirs = nodes2dirs(Sol.nodeNumbers, Model);

%% update model and calculate cost
Sol.cost = calCostL(Sol.coords);
Sol.smoothness = calSmoothnessbyDir(Sol);

%% display data and plot solution
disp(Sol)

showDynamicObst = true;
plotModel(InitModel, showDynamicObst)
plotSolution(Sol.coords, [])
% plotAnimation2(Model, Sol.coords)

%% clear temporal data
clear xy t pt dirs newobstNode adj_type dist_type
