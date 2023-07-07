function plotAnimation2(Model, pathCoords)
% animate path points with tale! concurrent.

x = pathCoords(:,1);
y = pathCoords(:,2);

Color='g';
newObstColor = [0.8500 0.3250 0.0980];

h1=plot(x(1), y(1), 'o', 'MarkerFaceColor', Color, 'MarkerEdgeColor', Color(1,:),'MarkerSize',4);
h2=plot(x(1:2), y(1:2), 'Color', Color,'LineWidth', 2);
pause(0.2)

frame = getframe(gcf);
img =  frame2im(frame);
[img,cmap] = rgb2ind(img,256);
imwrite(img,cmap,'animation.gif','gif','LoopCount',Inf,'DelayTime',1);

for i=2:numel(x)
    
    set(h1, 'XData', x(i))
    set(h1, 'YData', y(i))
    
    set(h2, 'XData', x(i-1:i))
    set(h2, 'YData', y(i-1:i))
    
    % % New Obstacles
    % new (dynamic) obstacles
    if isfield(Model, 'NewObsts')
        for iNewObst=1:Model.NewObsts.count
            if Model.NewObsts.t(iNewObst)==i
                plot(Model.NewObsts.x(iNewObst), Model.NewObsts.y(iNewObst),'o', 'MarkerSize',5, ...
                    'MarkerFaceColor', newObstColor, 'MarkerEdgeColor', newObstColor);
            end
        end
    end
    
    drawnow
    pause(0.2)
    
    frame = getframe(gcf);
    img =  frame2im(frame);
    [img,cmap] = rgb2ind(img,256);
    imwrite(img,cmap,'animation.gif','gif','WriteMode','append','DelayTime',0.2);
end

end