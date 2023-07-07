function [G, RHS, Open, Start] = computeShortestPath(G, RHS, Open, Start, Model)
    % computeShortestPath between current startNode and targetNode

    % select top key
    TopNode = topKey(Open);

    % update start_key
    Start.key = min(G(Start.nodeNumber), RHS(Start.nodeNumber)) * [1; 1] + [Model.km; 0];

    while compareKeys(TopNode.key, Start.key) || RHS(Start.nodeNumber) ~= G(Start.nodeNumber)

        k_old = TopNode.key;
        k_new = min(G(TopNode.nodeNumber), RHS(TopNode.nodeNumber)) + [TopNode.hCost + Model.km; 0];

        % remove topkey from open
        Open.List(TopNode.ind) = [];
        Open.count = Open.count - 1;

        % update vertex
        nodesForUpdate = Model.Predecessors{TopNode.nodeNumber, 1};

        if compareKeys(k_old, k_new)
            Open.List(end + 1) = TopNode;
            Open.List(end).key = k_new;
            Open.count = Open.count + 1;
        else

            if G(TopNode.nodeNumber) > RHS(TopNode.nodeNumber)
                G(TopNode.nodeNumber) = RHS(TopNode.nodeNumber);
            else
                G(TopNode.nodeNumber) = inf;
                nodesForUpdate(end + 1) = TopNode.nodeNumber;
            end

            [Open, RHS] = updateVertex(Open, RHS, G, nodesForUpdate, Model, Start);
        end

        % select top key
        TopNode = topKey(Open);

        % update start_key
        Start.key = min(G(Start.nodeNumber), RHS(Start.nodeNumber)) * [1; 1] + [Model.km; 0];

    end

end
