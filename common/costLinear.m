function [cost, SolChar] = costLinear(Model, coords)

xPath = coords(:,1);
yPath = coords(:,2);

dxPath = diff(xPath);
dyPath = diff(yPath);

% path length
L = sum(sqrt(dxPath.^2 + dyPath.^2));

%  violation check, deviding path to smaller parts for violation check
Temp = 100;
xx = zeros(length(xPath) - 1, Temp);
yy = zeros(length(xPath) - 1, Temp);

for i = 1:length(xPath) - 1
    xx(i,:) = linspace(xPath(i), xPath(i+1),Temp);
    yy(i,:) = linspace(yPath(i), yPath(i+1),Temp);
end
xx = xx(:,1:end-1)';
xx = xx(:); xx = xx';
yy = yy(:,1:end-1)';
yy = yy(:); yy = yy';

violation = zeros(1,Model.Obst.count);
for i = 1:Model.Obst.count
    d = sqrt((xx - Model.Obst.x(i)).^2 + (yy - Model.Obst.y(i)).^2);
    v = max(1 - d/(Model.Obst.r), 0);
    violation(i) = mean(v);
end
violation = mean(violation);

% solution characteristics
beta = 10e10;
SolChar.pathLength = L;
SolChar.violation = violation;
SolChar.isFeasible = (violation == 0);

cost = SolChar.pathLength  + beta*SolChar.violation ;

end
