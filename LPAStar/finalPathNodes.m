function pathNodes = finalPathNodes(G, Model)
% calculate optimap path nodes

i=1;
pathNodes = [];
nodeNumber = Model.Robot.targetNode;

pathNodes(i) = nodeNumber;

switch Model.expandMethod
    case 'random'
        while nodeNumber ~= Model.startNode
            i = i+1;
            predNodes = Model.Predecessors{nodeNumber,1};
            [~, indMinG] = min(G(predNodes)+ Model.Predecessors{nodeNumber,2});
            nodeNumber = predNodes(indMinG);
            pathNodes(i) = nodeNumber;
        end
        
    case 'heading'
        while nodeNumber ~= Model.startNode
            i = i+1;
            predNodes = Model.Predecessors{nodeNumber,1};
            
            if i==2
                [~, indMinG] = min(G(predNodes)+ Model.Predecessors{nodeNumber,2});
                nodeNumber = predNodes(indMinG);
                pathNodes(i) = nodeNumber;
                
                x1 = Model.Robot.xt;
                y1 = Model.Robot.yt;
                xy2 = Model.Nodes.cord(:, nodeNumber);
                currentDir = atan2(xy2(2)-y1, xy2(1)-x1);
            end
            
            if i>2
                dTheta = turnCost(nodeNumber, predNodes, Model, currentDir);
                [~, sortInd] = sortrows([G(predNodes)+ Model.Predecessors{nodeNumber,2}; abs(dTheta)]');
                nodeNumber = predNodes(sortInd(1));
                pathNodes(i) = nodeNumber;
                currentDir = currentDir+dTheta(sortInd(1));
            end
        end
end

pathNodes = flip(pathNodes);

end