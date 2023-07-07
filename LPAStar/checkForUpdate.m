function [Open, RHS, Model] = checkForUpdate(Open, RHS, Model, G, t)

% check for Map change
for i=1:Model.NewObsts.count
    if t==Model.NewObsts.t(i)
        % update model
        newObstNode = Model.NewObsts.nodeNumbers(i);
        Model.Predecessors{newObstNode,2} = Model.Predecessors{newObstNode,2}+inf;
        
        % update vertex
        [Open, RHS] = updateVertex(Open, RHS, G, newObstNode, Model);
    end
end

end