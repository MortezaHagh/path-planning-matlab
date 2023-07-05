function [G, RHS, Open] = initializeLPAstar(Model)
% Initialize LPAstar PP problem.


% G, RHS
G = Model.G;
RHS = Model.RHS;

% Open: count, List
% node key, ind

% set the starting node as the first node in Open
TopNode.nodeNumber=Model.Robot.startNode;
hCost = Distance(Model.Robot.xs, Model.Robot.ys, Model.Robot.xt, Model.Robot.yt, Model.distType);
TopNode.key = [hCost; 0];
RHS(TopNode.nodeNumber)=0;
TopNode.ind = 1;

% insert start node in Open list
Open.List(1) = TopNode;
Open.count = 1;

end