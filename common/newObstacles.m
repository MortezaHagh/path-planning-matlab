function Model = newObstacles(Model)
% create newObstacles: inserted in the sppecified time t.

t = [4 7];
x = [10 12];
y = [8 9];
count = numel(t);
nodeNumbers = zeros(count);
for i = 1:count
    nodeNumbers(i) = (y(i)-Model.Map.yMin)*Model.Map.nX + x(i)-Model.Map.xMin+1;
end

% NewObsts
NewObsts.t = t;
NewObsts.x = x;
NewObsts.y = y;
NewObsts.count = count;
NewObsts.nodeNumbers = nodeNumbers;

% update Model
Model.NewObsts = NewObsts;

end