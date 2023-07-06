function [Model, Path] = myDstarLiteOptimised(Model)
% DstarLite Optimised Algorithm

% initialization
[G, RHS, Open] = initializeDstarLite(Model);

t=1;
newobstNode=[];
Path.nodeNumbers = [Model.Robot.startNode];

% update start_key
Start.nodeNumber = Model.Robot.startNode;
Start.key = min(G(Start.nodeNumber), RHS(Start.nodeNumber))*[1; 1];
Start.cord = nodes2coords(Start.nodeNumber, Model);
currentDir = deg2rad(Model.Robot.dir);

% compute shortest path
[G, RHS, Open, Start] = computeShortestPath(G, RHS, Open, Start, Model);

%% main procedure

% if G(Start.nodeNumber)=inf -> then there is no known path

while Start.nodeNumber~=Model.Robot.targetNode
    
    % move robot to next node
    sucNodes = Model.Successors{Start.nodeNumber};
    switch Model.expandMethod
        case 'heading'
            dTheta = turnCost(Start.nodeNumber, sucNodes, Model, currentDir);
            [~, sortInds] = sortrows([G(sucNodes) + Model.Successors{Start.nodeNumber,2}; abs(dTheta)]');
            Start.nodeNumber = sucNodes(sortInds(1));
            currentDir = currentDir + dTheta(sortInds(1));
        case 'random'
            [~, minInd] = min(G(sucNodes) + Model.Successors{Start.nodeNumber,2});
            Start.nodeNumber = sucNodes(minInd);
    end
    Start.coords = nodes2coords(Start.nodeNumber, Model);
    
    % move to Start.nodeNumber and add Start.nodeNumber to Path
    Path.nodeNumbers(end+1) = Start.nodeNumber;
    t=t+1;
    
    % check for update in edge costs (obstacles)
    [Open, RHS, newobstNode, Model] = checkForUpdate(Open, RHS, newobstNode, Model, G, t, Start);
    
    % compute shortest path
    [G, RHS, Open, Start] = computeShortestPath(G, RHS, Open, Start, Model);
    
end

%% optimal paths coordinations, nodes, directions
Path.coords = nodes2coords(Path.nodeNumbers, Model);
Path.dirs = nodes2dirs(Path.nodeNumbers, Model);

% update model
Model.Obsts.count = Model.Obsts.count+1;
Model.Obsts.nodeNumber(end+1) = newobstNode;
newObstXY = Model.Nodes.cord(:,newobstNode);
Model.Obsts.x = [Model.Obsts.x, newObstXY(1,:)];
Model.Obsts.y = [Model.Obsts.y, newObstXY(2,:)];

end
