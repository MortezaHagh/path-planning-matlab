function Model = addRobotToModel(Model)
% add Robot data to Model


%% robot data
% dir: direction
Robot.dir = randsample([0 90 180 270],1);

% start & goal - start & target coordinates
Robot.xs = 2;
Robot.ys = 2;
Robot.xt = 6;
Robot.yt = 7;
% Robot.xs = 120;
% Robot.ys = 25;
% Robot.xt = 150;
% Robot.yt = 250;

%  start & goal - node numbers
Robot.startNode = (Robot.ys-Model.Map.yMin)*(Model.Map.nX)+Robot.xs-Model.Map.xMin+1;
Robot.targetNode = (Robot.yt-Model.Map.yMin)*(Model.Map.nX)+Robot.xt-Model.Map.xMin+1;

%% save model
Model.robotCount=1;
Model.Robot = Robot;

end
