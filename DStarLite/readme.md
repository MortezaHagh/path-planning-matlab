# D*Lite: Path Planning Algorithm - MATLAB
Single Robot Path Planning
coding based on nodes.
in semi-unkown environment

## run code

RUN_DstarLite.m: D*Lite path planning

## functions

myDstarLite: for map with changing esdge costs


## myLPAStar & myLPAStar_Replanning

two mode:  8 and 4 neighbor nodes

- expandArray4

- expandArray8

%%%%
cost = inf*ones(nNodes, nNodes);
cost just for adjacents
add is in U for Node structure
Successors to data structure containing costs -> delete big cost matrix
