function Model = newObstacles(Model)
% create newObstacles: inserted in the sppecified time t.

t = [4 6];
xy = {[1 4], [1, 7]};
count = numel(t);
nodeNumber = zeros(count);
for i = 1:count
    nodeNumber(i) = (xy{i}(2)-Model.Map.yMin)*Model.Map.nX + xy{i}(1)-Model.Map.xMin+1;
end

% NewObsts
NewObsts.t = t;
NewObsts.xy = xy;
NewObsts.count = count;
NewObsts.nodeNumbers = nodeNumbers;

% update Model
Model.NewObsts = NewObsts;

end