function [Open, RHS, newObstNode, Model] = checkForUpdate(Open, RHS, newObstNode, Model, G, t)

% check for Map change
if t==4
    % update model
    newObstNode = [newObstNode 36];
    Model.Predecessors{newObstNode,2} = Model.Predecessors{newObstNode,2}+inf;
    
    % update vertex
    nodesForUpdate = newObstNode(end);
    [Open, RHS] = updateVertex(Open, RHS, G, nodesForUpdate, Model);
end

end