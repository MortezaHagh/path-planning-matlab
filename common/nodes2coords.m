function path_coords = nodes2coords(Path, Model)
    % return coordinates of nodes

    path_coords = Model.Nodes.cord(:, Path);
    path_coords = path_coords';

end
