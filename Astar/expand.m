function expand = expand(TopNode, Closed, Model)
% expand a node and find feasible successors
% nodeNumber pNode gCost fCost dir

% neghbors from model
nNeighbors = Model.Neighbors(TopNode.nodeNumber).count;
Neighbors = Model.Neighbors(TopNode.nodeNumber).List;

nExpand = 0;
for iNeighbor = 1:nNeighbors
    % neighbor
    newX = Neighbors(iNeighbor).x;
    newY = Neighbors(iNeighbor).y;
    newDir = Neighbors(iNeighbor).dir;
    newCost = Neighbors(iNeighbor).cost;
    newNodeNumber = Neighbors(iNeighbor).nodeNumber;
    
    % add neighbor (newNode) to list if it is not in Closed list
    if ~any(newNodeNumber == Closed.nodeNumber)
        nExpand = nExpand + 1;
        list(nExpand).visited = 0;
        list(nExpand).nodeNumber = newNodeNumber;
        list(nExpand).pNode = TopNode.nodeNumber;
        list(nExpand).gCost = TopNode.gCost + newCost;
        hCost = Distance(Model.Robot.xt, Model.Robot.yt, newX, newY, Model.distType);
        list(nExpand).fCost = list(nExpand).gCost + hCost;
        list(nExpand).dir = newDir;
    end
end

% Neighbors
expand.count = nExpand;

if nExpand ~= 0
    expand.List = list;
else
    expand.List = [];
end

end
