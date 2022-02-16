#!/bin/bash

# This script is called by the solver script. Each function should be named solve_task_#, 
# where # is the number of the task each function will solve. The calling solver will call
# the corresponding verify_task_# function after each solver_task_# function completes. 

function solve_task_1() {
  yes | sudo apt update
  yes | sudo apt-get install ca-certificates curl apt-transport-https lsb-release gnupg
  yes | sudo apt-get install azure-cli
  az --version  > az.txt
}

function solve_task_2() {
 echo "AzureCloud	dafda750-ae63-46d1-8b81-3546648b438c 2d1f3234-b3f6-481b-ab6d-0038d5edaddb" > az-login.txt 
}


function solve_task_3() {
  echo "/subscriptions/2d1f3234-b3f6-481b-ab6d-0038d5edaddb/resourceGroups/my-resource-group northeurope" > az-resource-group.txt
}


function solve_task_4() {
  echo "/subscriptions/2d1f3234-b3f6-481b-ab6d-0038d5edaddb/resourceGroups/my-resource-group/providers/Microsoft.Network/virtualNetworks/my-vnet" > az-vnet.txt
}
