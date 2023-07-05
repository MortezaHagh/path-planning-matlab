function [Model, Path] = myAStar(Model)
% Astar algorithm

% initialization
[Closed, Open, TopNode] = initializeAstar(Model);

%%%% Start Algorithm

while TopNode.nodeNumber ~= Model.Robot.targetNode
    
    % finding neighbors (successors)
    switch Model.adjType
        case  '4adj'
            Neighbors=neighbors4(TopNode, Closed, Model);
        case '8adj'
            Neighbors=neighbors8(TopNode, Closed, Model);
    end
    
    % update or extend Open list with the successor nodes
    Open = updateOpen(Open, Neighbors);
    
    % select new Top Node
    [TopNode, Open] = selectTopNode(Open, Model.Robot.targetNode);
    Closed.count = Closed.count+1;
    Closed.nodeNumber(Closed.count) = TopNode.nodeNumber;
end

% optimal paths coordinations, nodes, directions
Path = optimalPath(Model, Open);

end
