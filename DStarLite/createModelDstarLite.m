function Model = createModelDstarLite(Model)
    % add neccessary data for Dstar Lite to Astar Base Model

    disp('Complete Model for DstarLite');

    %% edge costs, G, RHS
    Nodes = Model.Nodes;

    switch Model.adjType
        case '4adj'
            ixy = [1 0; 0 1; 0 -1; -1 0];
            nAdj = 4;
        case '8adj'
            ixy = [1 0; 0 1; 0 -1; -1 0; 1 1; -1 -1; 1 -1; -1 1];
            nAdj = 8;
    end

    % euclidean manhattan
    switch Model.distType
        case 'manhattan'
            edgeLength = 2;
        case 'euclidean'
            edgeLength = sqrt(2);
    end

    nNodes = Model.Nodes.count;
    Successors = cell(nNodes, 2);
    Predecessors = cell(nNodes, 2);

    for iNode = 1:nNodes

        if ~any(iNode == Model.Obsts.nodeNumber)
            xNode = Nodes.cord(1, iNode);
            yNode = Nodes.cord(2, iNode);

            for iAdj = 1:nAdj
                ix = ixy(iAdj, 1);
                iy = ixy(iAdj, 2);
                newX = xNode + ix;
                newY = yNode + iy;

                % check if the Node is within array bound
                if (newX >= Model.Map.xMin && newX <= Model.Map.xMax) && (newY >= Model.Map.yMin && newY <= Model.Map.yMax)
                    newNodeNumber = iNode + ix + iy * (Model.Map.nX);

                    if ~any(newNodeNumber == Model.Obsts.nodeNumber)
                        Successors{iNode, 1} = [Successors{iNode}, newNodeNumber];
                        Predecessors{newNodeNumber, 1} = [Predecessors{newNodeNumber, 1}, iNode];

                        if ix ~= 0 && iy ~= 0
                            cost = edgeLength;
                        else
                            cost = 1;
                        end

                        Successors{iNode, 2} = [Successors{iNode, 2}, cost];
                        Predecessors{newNodeNumber, 2} = [Predecessors{newNodeNumber, 2}, cost];
                    end

                end

            end

        end

    end

    % G, RHS
    G = inf(1, nNodes);
    RHS = inf(1, nNodes);

    %% dynamic obsts
    Model.NewObsts.count = 0;

    %% save model
    Model.sLast = Model.Robot.startNode;
    Model.Predecessors = Predecessors;
    Model.Successors = Successors;
    Model.RHS = RHS;
    Model.G = G;
    Model.km = 0;

    %% plot model
    % plotModel(model);

end
