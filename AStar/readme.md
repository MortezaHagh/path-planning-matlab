# A*: Single Robot Path Planning Algorithm - MATLAB
Single Robot Path Planning.

coding based on nodes.

In semi-unknown environment:
 - known initial map.
 - detect new obstacles (remapping is needed). 

note: with robotD (Direction) as a parameter in selecting next node.

## run code

RUN_Astar.m: A* path planning

RUN_Astar_Remapping: A* pp for map with changing edge costs


## myAStar function
two mode:  8 and 4 neighbor nodes

neighbors4: arrange neighbors based on robot direction

neighbors8


%%%%%%%
Open sorting
Open initial allocation
