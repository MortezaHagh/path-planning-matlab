function [Open, RHS, newobstNode, Model] = checkForUpdate(Open, RHS, newobstNode, Model, G, t, Start)

% check for Map change
if t==4
    % update model
    newobstNode = [newobstNode 36];
    
    Model.Predecessors{newobstNode,2} = Model.Predecessors{newobstNode,2}+inf;
    for iP=Model.Predecessors{newobstNode,1}
        indInSuc = Model.Successors{iP,1} == newobstNode;
        Model.Successors{iP,2}(indInSuc) = Model.Successors{iP,2}(indInSuc)+inf;
    end
    
    xyStart = Start.cord;
    xySlast = Model.Nodes.cord(:, Model.sLast);
    Model.km = Model.km +Distance(xySlast(1), xySlast(2), xyStart(1), xyStart(2), Model.distType);
    Model.sLast = Start.nodeNumber;
    
    % update vertex
    nodesForUpdate = Model.Predecessors{newobstNode(end),1};
    [Open, RHS] = updateVertex(Open, RHS, G, nodesForUpdate, Model, Start);
    
end

end