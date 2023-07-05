function Model = createModelFromMap(MapInput, Model)
% Create model from Map


%% Map Size
[H,W] = size(MapInput);
Map.xMin = 1;
Map.yMin = 1;
Map.xMax = W;
Map.yMax = H;
Map.lim = max(W, H);
Map.nX=Map.xMax-Map.xMin+1;
Map.nY=Map.yMax-Map.yMin+1;

%% Obstacles

Obst.r = 0.25;
Obst.x=[];
Obst.y=[];
Obst.nodeNumber = [];
Nodes.count = H*W;
Nodes.cord = zeros(2, Nodes.count);
Nodes.number = zeros(1,Nodes.count);

iNodeNumber=1;
for i=1:H
    for j=1:W
        Nodes.number(1,iNodeNumber)=iNodeNumber;
        Nodes.cord(:,iNodeNumber)=[j,i]';
        if MapInput(i,j)==0
            Obst.x=[Obst.x j];
            Obst.y=[Obst.y i];
            Obst.nodeNumber = [Obst.nodeNumber iNodeNumber];
        end
        iNodeNumber = iNodeNumber+1;
    end
end

Obst.count = numel(Obst.nodeNumber);

%% save model
Model.Nodes = Nodes;
Model.Obst = Obst;
Model.Map = Map;

% % save
% model_name = 'model_1';
% save(model_name, 'model');

end