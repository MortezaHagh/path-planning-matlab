function Open = updateOpen(Open, Neighbors)
% uodate Open by Neighbors


% update or extend Open list with the successor nodes
for iNeighbors=1:Neighbors.count
    neighbors_open_common = [Open.List.nodeNumber]==Neighbors.List(iNeighbors).nodeNumber;
    
    % if there is a common node in neighbors and open
    if any(neighbors_open_common)
        indOpen=find(neighbors_open_common);
        
        % if fCost of node in Neighbors is less than Open -> update node in Open
        if Neighbors.List(iNeighbors).fCost<Open.List(indOpen).fCost
            Open.List(indOpen) = Neighbors.List(iNeighbors);
        end
        
        % if there is No common node in Neighbors and Open
    else
        % insert neighbor into the open list
        Open.count = Open.count+1;
        Open.List(Open.count) = Neighbors.List(iNeighbors);
    end
end

end