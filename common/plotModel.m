function plotModel(Model)
% Plot Map and Robots start and target nodes

xMin=Model.Map.xMin;
xMax=Model.Map.xMax;
yMin=Model.Map.yMin;
yMax=Model.Map.yMax;
obstX=Model.Obst.x;
obstY=Model.Obst.y;
xs=Model.Robot.xs;
ys=Model.Robot.ys;
xt=Model.Robot.xt;
yt=Model.Robot.yt;

figure(1)
axis equal
axis([xMin-1,xMax+1,yMin-1,yMax+1])
box on
hold on

% g=gca;
% g.XTick=0:xMax;
% g.YTick=0:yMax;

% start
plot(xs,ys,'bs','MarkerSize',14,'MarkerEdgeColor',[0.5,0,0.5],...
    'MarkerFaceColor',[0.5,0,0.5]);
% target
plot(xt,yt,'bp','MarkerSize',14,'MarkerEdgeColor',[0,1,1],...
    'MarkerFaceColor',[0,1,1]);

% % Obstacles
% theta=linspace(0,2*pi,100);
% for i=1:length(xc)
%     fill(xc(i)+r*cos(theta),yc(i)+r*sin(theta),'k');
% end

% Obstacles
for i=1:length(obstX)
    plot(obstX(i),obstY(i),'ko', 'MarkerSize',5,'MarkerFaceColor','k');
end

% % Obstacles patch
% for i = 1:size(model.obstX,1)
%     patch(model.obstX{i,1}, model.obstY{i,1},'y','EdgeColor','yellow','FaceAlpha',0.5)
%     scatter(model.obstX{i,1}, model.obstY{i,1},'r','filled')
% end

% walls
rectangle('Position',[xMin-0.5 yMin-0.5 (xMax-xMin+1) (yMax-yMin+1)], 'LineWidth',5)

end
