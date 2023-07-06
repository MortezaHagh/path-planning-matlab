# PathPlanning-MATLAB
Single robot path planning algorithms implemented in MATLAB.
Including heuristic search and incremental heuristic search methods. 

## Methods
- A* (can turn into Dijkstra by changing the heuristic function)
- LPA* (Life Long Planning A*)
- D*Lite (With Optimized Version)

## Run
- Go into the methods directory.
- Run the **RUN_[Methods_name].m** file

## Configuration - Models
Initial configuration includes:
- Map (free nodes)
- obstacles (occupied nodes)
- robot's start node
- robot's goal node
- ...

To change the configuration, you can edit the **createModelBase.m** file in **models** directory.

## General
Apart from each path planning method's directory, there are two general directories:
- **common**: common functionalities used in all planning methods
- **models**: functions for creating and saving models (configurations). 
