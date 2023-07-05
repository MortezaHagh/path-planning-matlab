function cost = costL(coords)

xPath = coords(:,1);
yPath = coords(:,2);

dxPath = diff(xPath);
dyPath = diff(yPath);

% path length
L = sum(sqrt(dxPath.^2 + dyPath.^2));

cost = L;

end
