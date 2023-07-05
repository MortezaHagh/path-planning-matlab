function [topNode, Open] = selectTopNode(Open, ~)
% select next node to expand

% no_visit: not_visited_id
no_visit = ~[Open.List.visited];

if sum(no_visit)>0
    costArray = [[Open.List(no_visit).fCost];
        find(no_visit)]';
    
    [~,sortInds]=sortrows(costArray(:,1));
    open_top_ind = costArray(sortInds(1),2);
else
    errorStruct.message = 'no path.';
    errorStruct.identifier = 'Astar:noPath';
    error(errorStruct)
end

Open.List(open_top_ind).visited = 1;
topNode = Open.List(open_top_ind);

end


