function Path = optimalPath(Model, Open)
% find optimal path nodes from target to start after Astar returns
% Path: nodeNumbers, coords, dirs

% starting from the last (target) node
pathNodes(1) = Model.Robot.targetNode;
i=2;

% Traverse Open and determine the parent nodes
indParent = [Open.List.nodeNumber]==pathNodes(1);
parentNodeNumber = Open.List(indParent).pNode;

% going back to start node
while parentNodeNumber ~= Model.Robot.startNode
    pathNodes(i) = parentNodeNumber;
    indParent = [Open.List.nodeNumber]==parentNodeNumber;
    parentNodeNumber =Open.List(indParent).pNode;
    i=i+1;
end

Path.nodeNumbers = [Model.Robot.startNode, flip(pathNodes)];
Path.coords = nodes2coords(Path.nodeNumbers, Model);
Path.dirs = nodes2dirs(Path.nodeNumbers, Model);

end
