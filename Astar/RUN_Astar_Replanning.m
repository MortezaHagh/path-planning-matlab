% A* replanning: Single Robot Path Planning Algorithm - MATLAB
% with remapping in case of new obstacle detection
% Main code for running the algorithm.
% Morteza Haghbeigi, m.haghbeigi@gmail.com

% Initialization
clc
clear
close

% adding paths
addpath('D:\00-Robotics\02-Robot Path Planning\Methods\Astar-Single & Multi-MATLAB')
addpath('D:\00-Robotics\02-Robot Path Planning\Methods\Astar-Single & Multi-MATLAB\SRPP')

%% setting
Model.expandMethod = 'random';  % random or heading
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
        newObstNode(end+1) = 36;
        Model.Obst.x(end+1) = 4;
        Model.Obst.y(end+1) = 0;
        Model.Obst.nodeNumber(end+1) = 37;
        Model.Obst.count = Model.Obst.count+1;
    end
    % check if path replanning is needed
    if any(Path.nodeNumbers(pt) == Model.Obst.nodeNumber)
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
    Model_init.xc = [Model.Obst.x Model.Nodes.cord(1,newObstNode)];
    Model_init.yc = [Model.Obst.y Model.Nodes.cord(2,newObstNode)];
end
Sol.cost = costL(Sol.coords);
Sol.smoothness = smoothness_by_dir(Sol);

%% display data and plot solution
disp(Sol)

plotModel(Model)
plotSolution(Sol.coords,[])
% plotAnimation2(Sol.coords)

%% clear temporal data
clear xy t pt dirs newobstNode adj_type dist_type
