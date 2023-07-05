function [Open, RHS] = updateVertex(Open, RHS, G, nodesForUpdate, Model)

for nodeNumber=nodesForUpdate
    if nodeNumber~=Model.startNode
        predNodes = Model.Predecessors{nodeNumber,1};
        [valMinG, ~] = min(G(predNodes) + Model.Predecessors{nodeNumber,2});
        RHS(nodeNumber) = valMinG;
    end
    
    checkInOpen = nodeNumber==[Open.List.nodeNumber];
    if any(checkInOpen)
        Open.List(checkInOpen) = [];
        Open.count = Open.count-1;
    end
    
    if G(nodeNumber)~=RHS(nodeNumber)
        Open.count = Open.count+1;
        op.nodeNumber = nodeNumber;
        nodeXY = Model.Nodes.cord(:,nodeNumber);
        hCost = Distance(nodeXY(1), nodeXY(2), Model.Robot.xt, Model.Robot.yt, Model.distType);
        op.key = min(G(nodeNumber), RHS(nodeNumber)) + [hCost; 0];
        op.ind = Open.count;
        Open.List(op.ind) = op;
    end
    
end

end