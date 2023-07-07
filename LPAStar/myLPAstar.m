function [Model, Path] = myLPAstar(Model)
    % LPAstar algorithm
    % moves robot to next node, then check for map changes and update path

    % initialization
    [G, RHS, Open] = initializeLPAstar(Model);

    t = 1;
    finalPathNodeNumbers = [Model.Robot.startNode; ];

    %% main procedure
    while Model.startNode ~= Model.Robot.targetNode

        % compute shortest path
        [G, RHS, Open] = computeShortestPath(G, RHS, Open, Model);

        % optimal paths nodes
        pathNodes = finalPathNodes(G, Model);

        % move robot to new startNode
        Model.startNode = pathNodes(2);
        finalPathNodeNumbers(end + 1) = Model.startNode;
        t = t + 1;

        % check for update in edge costs (obstacles)
        [Open, RHS, Model] = checkForUpdate(Open, RHS, Model, G, t);

    end

    %% optimal paths coordinations, nodes, directions
    Path.nodeNumbers = finalPathNodeNumbers;
    Path.coords = nodes2coords(Path.nodeNumbers, Model);
    Path.dirs = nodes2dirs(Path.nodeNumbers, Model);

end
