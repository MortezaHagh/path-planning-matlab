function [Open, RHS] = updateVertex(Open, RHS, G, nodesForUpdate, Model, Start)

    for nodeNumber = nodesForUpdate

        if nodeNumber ~= Model.Robot.targetNode
            succNodes = Model.Successors{nodeNumber, 1};
            [valMinG, ~] = min(G(succNodes) + Model.Successors{nodeNumber, 2});
            RHS(nodeNumber) = valMinG;
        end

        checkInOpen = nodeNumber == [Open.List.nodeNumber];

        if any(checkInOpen)
            Open.List(checkInOpen) = [];
            Open.count = Open.count - 1;
        end

        if G(nodeNumber) ~= RHS(nodeNumber)
            Open.count = Open.count + 1;
            op.nodeNumber = nodeNumber;
            nodeXY = Model.Nodes.cord(:, nodeNumber);
            op.hCost = calDistance(Start.cord(1), Start.cord(2), nodeXY(1), nodeXY(2), Model.distType);
            op.key = min(G(nodeNumber), RHS(nodeNumber)) + [op.hCost + Model.km; 0];
            op.ind = Open.count;
            Open.List(op.ind) = op;
        end

    end

end
