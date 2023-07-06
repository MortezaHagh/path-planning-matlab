function Model=createModelAstar(Model)
% add neccessary data for Astar to Base Model

disp('Complete Model for AStar');

%% 
Nodes = Model.Nodes;

switch Model.adjType
    case '4adj'
        ixy = [1 0; 0 1; 0 -1; -1 0];
        nAdj=4;
    case '8adj'
        ixy = [1 0; 0 1; 0 -1; -1 0; 1 1; -1 -1; 1 -1; -1 1];
        nAdj=8;
end

% euclidean manhattan
switch Model.distType
    case 'manhattan'
        edgeLength=2;
    case 'euclidean'
        edgeLength=sqrt(2);
end

% tempNeighbor
tempNeighbor.nodeNumber = 0;
tempNeighbor.cost = 0;
tempNeighbor.dir = 0;
tempNeighbor.x = 0;
tempNeighbor.y = 0;
tempNodesNeigh.count = 0;
tempNodesNeigh.List = repmat(tempNeighbor, nAdj, 1);

% Neighbors
nNodes = Model.Nodes.count;
Neighbors = repmat(tempNodesNeigh, nNodes, 1);

for iNode=1:nNodes
    Neighbors(iNode).count = 0;
    if ~any(iNode==Model.Obsts.nodeNumber)
        xNode = Nodes.cord(1,iNode);
        yNode = Nodes.cord(2,iNode);
        for iAdj=1:nAdj
            ix=ixy(iAdj,1);
            iy=ixy(iAdj,2);
            newX = xNode+ix;
            newY = yNode+iy;
            newDir = atan2(iy, ix);
            
            % check if the Node is within array bound
            if(newX>=Model.Map.xMin && newX<=Model.Map.xMax) && (newY>=Model.Map.yMin && newY<=Model.Map.yMax)
                newNodeNumber = iNode+ix+iy*(Model.Map.nX);
                
                if ~any(newNodeNumber==Model.Obsts.nodeNumber)
                    if ix~=0 && iy~=0
                        cost = edgeLength;
                    else
                        cost = 1;
                    end
                    newNeighbor = tempNeighbor;
                    newNeighbor.nodeNumber = newNodeNumber;
                    newNeighbor.dir = newDir;
                    newNeighbor.cost = cost;
                    newNeighbor.x = newX;
                    newNeighbor.y = newY;
                    Neighbors(iNode).count = Neighbors(iNode).count + 1;
                    Neighbors(iNode).List(Neighbors(iNode).count) = newNeighbor;
                end
            end
        end
    end
end

%% save model
Model.Neighbors=Neighbors;

%% plot model
% plotModel(model);

end
