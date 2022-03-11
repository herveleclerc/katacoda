#!/bin/bash

# This script is called by the solver script. Each function should be named solve_task_#, 
# where # is the number of the task each function will solve. The calling solver will call
# the corresponding verify_task_# function after each solver_task_# function completes. 

function solve_task_1() {
  kubectl get pods --no-headers --selector app=hello-world  | grep hello-world | awk '{print $3;}' > pod-status.txt
}
