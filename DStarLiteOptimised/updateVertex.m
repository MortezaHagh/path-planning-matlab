function [Open, RHS] = updateVertex(Open, RHS, G, nodesForUpdate, Model, Start)

for nodeNumber=nodesForUpdate
    
    if G(nodeNumber)~=RHS(nodeNumber) && any(nodeNumber==[Open.List.nodeNumber])
        nodeInd = nodeNumber==[Open.List.nodeNumber];
        op.nodeNumber = nodeNumber;
        nodeXY = Model.Nodes.cord(:,nodeNumber);
        op.hCost = calDistance(Start.cord(1), Start.cord(2), nodeXY(1), nodeXY(2), Model.distType);
        op.key = min(G(nodeNumber), RHS(nodeNumber)) + [op.hCost+Model.km; 0];
        op.ind = Open.count;
        Open.List(nodeInd) = op;
    end
    
    if G(nodeNumber)~=RHS(nodeNumber) && ~any(nodeNumber==[Open.List.nodeNumber])
        Open.count = Open.count+1;
        op.nodeNumber = nodeNumber;
        nodeXY = Model.Nodes.cord(:,nodeNumber);
        op.hCost = calDistance(Start.cord(1), Start.cord(2), nodeXY(1), nodeXY(2), Model.distType);
        op.key = min(G(nodeNumber), RHS(nodeNumber)) + [op.hCost+Model.km; 0];
        op.ind = Open.count;
        Open.List(op.ind) = op;
    end
    
    checkInOpen=nodeNumber==[Open.List.nodeNumber];
    if G(nodeNumber)==RHS(nodeNumber) && any(nodeNumber==[Open.List.nodeNumber])
        Open.List(checkInOpen) = [];
        Open.count = Open.count-1;
    end
    
end

end