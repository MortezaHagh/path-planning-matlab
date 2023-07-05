function plotSolution(pathCoords, mPathCoords)
% Plot Path and mPath on the Map

x = pathCoords(:,1);
y = pathCoords(:,2);

% path
plot(x, y, 'b', 'LineWidth', 2);
plot(x(2:end-1), y(2:end-1), 'bo', 'MarkerFaceColor', 'b','MarkerSize',4);

% modified path
if ~isempty(mPathCoords)
    mx = mPathCoords(:,1);
    my = mPathCoords(:,2);
    plot(mx, my, 'g');
    plot(mx(2:end-1), my(2:end-1), 'go','MarkerFaceColor','g','MarkerSize',4);
end

end
