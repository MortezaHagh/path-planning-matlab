function [topNode, Open] = selectTopNode(Open, TopNode, expandMethod, ~)
% select next node to expand

% no_visit: not_visited_id
no_visit = ~[Open.List.visited];
nNoVisit = sum(no_visit);

if nNoVisit>0
    dTheta = angdiff(TopNode.dir*ones(1, nNoVisit), [Open.List(no_visit).dir]);
    dTheta = abs(dTheta);
    costArray = [[Open.List(no_visit).fCost];
        dTheta;
        find(no_visit)]';
    switch expandMethod
        case 'heading'
            [~,sortInds]=sortrows(costArray(:,1:2));
        otherwise
            [~,sortInds]=sortrows(costArray(:,1));
    end
    open_top_ind = costArray(sortInds(1),3);
else
    errorStruct.message = 'no path.';
    errorStruct.identifier = 'Astar:noPath';
    error(errorStruct)
end

Open.List(open_top_ind).visited = 1;
topNode = Open.List(open_top_ind);

end


