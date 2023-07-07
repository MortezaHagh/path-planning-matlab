function [Open, RHS, Model] = checkForUpdate(Open, RHS, Model, G, t, Start)

% check for Map change
for i=1:Model.NewObsts.count
    if t==Model.NewObsts.t(i)
        newobstNode = Model.NewObsts.nodeNumbers(i);
        Model.Predecessors{newobstNode,2} = Model.Predecessors{newobstNode,2}+inf;
        for iP=Model.Predecessors{newobstNode,1}
            indInSuc = Model.Successors{iP,1} == newobstNode;
            Model.Successors{iP,2}(indInSuc) = Model.Successors{iP,2}(indInSuc)+inf;
        end
        
        xyStart = Start.cord;
        xySlast = Model.Nodes.cord(:, Model.sLast);
        Model.km = Model.km +calDistance(xySlast(1), xySlast(2), xyStart(1), xyStart(2), Model.distType);
        Model.sLast = Start.nodeNumber;
        
        % update vertex
        nodesForUpdate = Model.Predecessors{newobstNode,1};
        [Open, RHS] = updateVertex(Open, RHS, G, nodesForUpdate, Model, Start);
    end
end

end