# LPA*: Lifelong Planning A* Path Planning Algorithm - MATLAB
Single Robot Path Planning.

coding based on nodes.

in semi-unknown environment
 - known initial map
 - detect new obstacles (remapping is needed).

two mode:  8 and 4 neighbor nodes

## run code

RUN_LPAstar.m: LPA* path planning

## functions

myLPAStar: for static maps and maps with changing esdge costs

%%%%%%
cost = inf*ones(nNodes, nNodes);
cost(iNode, newNodeNumber) = 1;