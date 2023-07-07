function pathDirs = nodes2dirs(nodeNumbers, Model)
    % return direction array of path nodes

    nNodes = numel(nodeNumbers);
    pathDirs = zeros(1, nNodes);

    for i = 2:nNodes
        node1_xy = Model.Nodes.cord(:, nodeNumbers(i - 1));
        node2_xy = Model.Nodes.cord(:, nodeNumbers(i));

        dd = node2_xy - node1_xy;
        dx = dd(1);
        dy = dd(2);
        nodeTheta = atan2(dy, dx);
        pathDirs(i - 1) = nodeTheta;
    end

    pathDirs(end) = pathDirs(end - 1);

end
