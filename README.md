# PathPlanning-MATLAB
Single robot path planning algorithms implemented in MATLAB.
Including heuristic search and incremental heuristic search methods. 

<table style="padding:10px">
  <tr>
    <td><img src="./AStar/Results/obstacle1.jpg" align="right" alt="2"></td>
    <td><img src="./LPAStar/Results/sim-2.gif"  alt="1"></td>
  </tr>
</table>

## Methods
- A* (can turn into Dijkstra by changing the heuristic function)
- LPA* (Life Long Planning A*)
- D*Lite (With Optimized Version)

---
## Run
- Go into the methods directory.
- Run the **RUN_[Methods_name].m** file

## General
Apart from each path planning method's directory, there are two general directories:
- **common**: common functionalities used in all planning methods
- **models**: functions for creating and saving models (configurations). 

---
## Common Settings
can change this setting in the Run_[method].m file 
- distance type: **Model.distType** ('euclidean' or 'manhattan')
- distance type: **Model.adjType** ('4adj' or '8adj')
- expansion method: **Model.expandMethod**
  - 'random': onlly based on distance cost
  - 'heading': based on distance and heading
- create_model_method: 'from_map_file', 'from_samples', 'from_custom'

--- 
## Configuration - Models
Initial configuration includes:
- Map (free nodes)
- obstacles (occupied nodes)
- robot's start node
- robot's goal node
- ...

There are three methods to create initial configuration (model):
- **from_map_file**: from a map.mat file (square matrix, 0: occupied, 1: free)
- **from_samples**: from a list of ready samples
- **from_custom**: from createModelBase.m file which you can edit and customize

You can set the method in the RUn_p[method].m file.

To change the configuration in *from_custom* method, you can edit the **createModelBase.m** file in **models** directory.

---
## A*
Includes final path modification (green path in the simulation pictures).

---
## Simulations
### A*
<table style="padding:10px">
  <tr>
    <td><img src="./AStar/Results/obstacle9.jpg"  alt="1"></td>
    <td><img src="./AStar/Results/obstacles19.jpg" align="right" alt="2"></td>
    <td><img src="./AStar/Results/obstacle1.jpg" align="right" alt="2"></td>
  </tr>
</table>

### LPA*
<table style="padding:10px">
  <tr>
    <td><img src="./LPAStar/Results/sim-2.gif"  alt="1" width = 360px height = 300px></td>
  </tr>
</table>

