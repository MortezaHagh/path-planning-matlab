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
Model.expandMethod = 'random';  % random or heading
Model.distType = 'manhattan';    % euclidean or manhattan;
Model.adjType = '4adj';          % 4adj or 8adj

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

Model_init = Model;

%% start timer
tic

%% pp
% initial pp t0 (each displacement btween nodes takes 1 sec)
[Model, Path] = myAStar(Model);

% preallocation
newObstNode=0;
Sol.nodeNumbers = [0];

t=0;
pt=0;
while Sol.nodeNumbers(end)~=Model.Robot.targetNode
    t=t+1;
    pt=pt+1;
    
    % update model (insert new obstacles)
    if t==5
        newObstNode(end+1) = 37;
        Model.Obsts.x(end+1) = 5;
        Model.Obsts.y(end+1) = 0;
        Model.Obsts.nodeNumber(end+1) = 37;
        Model.Obsts.count = Model.Obsts.count+1;
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
        pt=2;
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
newObstNode = newObstNode(2:end);
if numel(newObstNode)>0
    Model_init.xc = [Model.Obsts.x Model.Nodes.cord(1,newObstNode)];
    Model_init.yc = [Model.Obsts.y Model.Nodes.cord(2,newObstNode)];
end
Sol.cost = costL(Sol.coords);
Sol.smoothness = calSmoothnessbyDir(Sol);

%% display data and plot solution
disp(Sol)

plotModel(Model)
plotSolution(Sol.coords,[])
% plotAnimation2(Sol.coords)

%% clear temporal data
clear xy t pt dirs newobstNode adj_type dist_type
