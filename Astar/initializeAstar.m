function [Closed, Open, TopNode] = initializeAstar(Model)
% Initialize Astar PP problem.


% Closed: count, nodeNumber
% Closed: put all obstacles on the Closed list
Closed.count = Model.Obst.count;
Closed.nodeNumber = Model.Obst.nodeNumber;

% Open: count, List
% Open.List Fields: visited nodeNumber pNode gCost fCost dir

% set the starting node as the first node in Open (TopNode)
TopNode.visited = 1;
TopNode.nodeNumber=Model.Robot.startNode;
TopNode.pNode=Model.Robot.startNode;
TopNode.dir = Model.Robot.dir;
TopNode.gCost = 0;
hCost = Distance(Model.Robot.xs, Model.Robot.ys,  Model.Robot.xt,  Model.Robot.yt, Model.distType);
TopNode.fCost = TopNode.gCost + hCost;

% insert TopNode (start node) in Open list
Open.count = 1;
Open.List(1) = TopNode;

% add last node to Closed
Closed.count = Closed.count+1;
Closed.nodeNumber(Closed.count) = TopNode.nodeNumber;

end