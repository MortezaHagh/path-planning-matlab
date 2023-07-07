function Model = addRobotToModel(Model)
    % add Robot data to Model

    %% robot data
    % dir: direction
    Robot.dir = deg2rad(90);

    % start & goal - coordinates
    Robot.xs = 2;
    Robot.ys = 2;
    Robot.xt = 6;
    Robot.yt = 7;

    %  start & goal - node numbers
    Robot.startNode = (Robot.ys - Model.Map.yMin) * (Model.Map.nX) + Robot.xs - Model.Map.xMin + 1;
    Robot.targetNode = (Robot.yt - Model.Map.yMin) * (Model.Map.nX) + Robot.xt - Model.Map.xMin + 1;

    %% update model
    Model.robotCount = 1;
    Model.Robot = Robot;

end
