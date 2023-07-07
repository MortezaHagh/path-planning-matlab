function Model = createModelBase(Model)
    % Create Base Model

    disp('Create Base Model');

    %% Map
    Map.lim = 28;
    Map.xMin = -1;
    Map.yMin = -1;
    Map.xMax = Map.lim;
    Map.yMax = Map.lim;
    Map.nX = Map.xMax - Map.xMin + 1;
    Map.nY = Map.yMax - Map.yMin + 1;

    %% robot data
    % dir: direction
    Robot.dir = deg2rad(90); %randsample([0 90 180 270], 1);

    % start & goal - coordinates
    % Robot.xs = 0;
    % Robot.ys = 0;
    % Robot.xt = 6;
    % Robot.yt = 7;
    Robot.xs = 7;
    Robot.ys = 4;
    Robot.xt = 21;
    Robot.yt = 16;

    %  start & goal - node numbers
    Robot.startNode = (Robot.ys - Map.yMin) * Map.nX + Robot.xs - Map.xMin + 1;
    Robot.targetNode = (Robot.yt - Map.yMin) * Map.nX + Robot.xt - Map.xMin + 1;

    %% obstacles
    % radius
    Obst.r = 0.25;

    % obstacles coordinates
    xc1 = [3 3 3 5 5 5 7 7 7 9 9 9 11 11 11];
    yc1 = [3 4 5 3 4 5 3 4 5 3 4 5 3 4 5];

    xc1 = xc1 + 1;
    yc1 = yc1 + 1;

    xc2 = [xc1 xc1 xc1 xc1];
    yc2 = [yc1 yc1 + 6 yc1 + 11 yc1 + 16];

    xc3 = xc2 + 12;
    yc3 = yc2;

    Obst.x = [xc2 xc3];
    Obst.y = [yc2 yc3];

    % number of obstacles
    Obst.count = length(Obst.x);

    % obstacle node numbers
    Obst.number = zeros(1, Obst.count);

    for ix = 1:Obst.count
        Obst.nodeNumber(ix) = (Obst.y(ix) - Map.yMin) * Map.nX + Obst.x(ix) - Map.xMin + 1;
    end

    %% nodes data
    iNode = 0;

    for iy = Map.yMin:Map.yMax

        for ix = Map.xMin:Map.xMax
            iNode = iNode + 1;
            Nodes.cord(1:2, iNode) = [ix, iy]'; % node coordinates
        end

    end

    Nodes.count = iNode;

    %% update model
    Model.Nodes = Nodes;
    Model.Robot = Robot;
    Model.Obsts = Obst;
    Model.Map = Map;

    %% plot model
    % plotModel(Model);

end
