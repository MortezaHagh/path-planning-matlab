function Path = modifyPath (Model, Path)

pathNodeNumbers = Path.nodeNumbers;
pathCoords = Path.coords;
pathDirs = Path.dirs;

it = 1;
NumPoints = 100;
while it <= size(pathCoords,1) - 2
    X = linspace(pathCoords(it,1), pathCoords(it+2,1), NumPoints);
    Y = linspace(pathCoords(it,2), pathCoords(it+2,2), NumPoints);
    
    violation = zeros(1,Model.Obst.count);
    for k = 1:Model.Obst.count
        dd = sqrt((X - Model.Obst.x(k)).^2+(Y - Model.Obst.y(k)).^2);
        v = max(1-dd/(Model.Obst.r),0);
        violation(k) = mean(v);
    end
    Violation = any(violation);
    
    if ~Violation
        pathCoords(it+1,:) = [];
        pathNodeNumbers(it+1) = [];
        pathDirs(it+1) = [];
    else
        it = it +1;
    end
    
end

Path.coords = pathCoords;
Path.nodes = pathNodeNumbers;
Path.dirs = pathDirs;

end
