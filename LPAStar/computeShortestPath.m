function [G, RHS, Open] = computeShortestPath(G, RHS, Open, Model)
% computeShortestPath between current startNode and targetNode


% select top key
TopNode = topKey(Open);

% update goal_key
Goal.nodeNumber = Model.Robot.targetNode;
Goal.key = min(G(Goal.nodeNumber), RHS(Goal.nodeNumber))*[1; 1];

while compareKeys(TopNode.key, Goal.key) || RHS(Goal.nodeNumber)~=G(Goal.nodeNumber)
    
    % remove topkey from open
    Open.List(TopNode.ind)=[];
    Open.count = Open.count-1;
    
    % update vertex
    nodesForUpdate = Model.Successors{TopNode.nodeNumber,1};
    if G(TopNode.nodeNumber)>RHS(TopNode.nodeNumber)
        G(TopNode.nodeNumber) = RHS(TopNode.nodeNumber);
    else
        G(TopNode.nodeNumber) = inf;
        nodesForUpdate(end+1) = TopNode.nodeNumber;
    end
    [Open, RHS] = updateVertex(Open, RHS, G, nodesForUpdate, Model);
    
    % select top key
    TopNode = topKey(Open);
    
    % update goal_key
    Goal.key = min(G(Goal.nodeNumber), RHS(Goal.nodeNumber))*[1; 1];
    
end

end