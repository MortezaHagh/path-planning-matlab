function [Open, RHS, Model] = checkForUpdate(Open, RHS, Model, G, t, Start)

    % check for Map change
    for i = 1:Model.NewObsts.count

        if t == Model.NewObsts.t(i)

            xyStart = Start.cord;
            xySlast = Model.Nodes.cord(:, Model.sLast);
            Model.km = Model.km +calDistance(xySlast(1), xySlast(2), xyStart(1), xyStart(2), Model.distType);
            Model.sLast = Start.nodeNumber;

            % dynamic obstacle
            newobstNode = Model.NewObsts.nodeNumbers(i);
            preds = Model.Predecessors{newobstNode, 1};
            costPred = Model.Predecessors{newobstNode, 2};
            Model.Predecessors{newobstNode, 2} = Model.Predecessors{newobstNode, 2} + inf;

            for iP = Model.Predecessors{newobstNode, 1}
                indInSuc = Model.Successors{iP, 1} == newobstNode;
                Model.Successors{iP, 2}(indInSuc) = Model.Successors{iP, 2}(indInSuc) + inf;
            end

            newCostPred = Model.Predecessors{newobstNode, 2};
            iPred = 1;

            for neighbor = preds
                costOld = costPred(iPred);

                if costOld > newCostPred(iPred)

                    if (neighbor ~= Model.Robot.targetNode)
                        RHS(neighbor) = min(RHS(neighbor), newCostPred(iPred) + G(newobstNode));
                    end

                elseif (RHS(neighbor) == costOld + G(newobstNode))

                    if (neighbor ~= Model.Robot.targetNode)
                        succNodes = Model.Successors{neighbor, 1};
                        RHS(neighbor) = min(G(succNodes) + Model.Successors{neighbor, 2});
                    end

                end

                iPred = iPred + 1;
            end

            % update vertex
            nodesForUpdate = [Model.Predecessors{newobstNode, 1} newobstNode];
            [Open, RHS] = updateVertex(Open, RHS, G, nodesForUpdate, Model, Start);
        end

    end

end
