#!/bin/bash

# This script is called by the solver utility. Each function should be named 
# verify_task_#, where # is the number of the task each function will solve.
# When a verification fails for a step, the error number returned corresponds 
# to the hint number found in hints.md.

# Delay before first hint and between steps. Zero or positive integer in seconds.
export HINTS_DELAY=15

# Max time for verify blocking commands. Zero or positive integer time units s, m, h.
export VERIFY_TIMEOUT=3s


function verify_task_1() {
  dpkg-query -l | grep azure-cli
  if [[ $? -ne 0 ]]
  then 
    return 1
  fi  

  whereis azure-cli
  if [[ $? -ne 0 ]]
  then 
    return 2
  fi


  if [[ ! -f 'az.txt' ]]
  then
    return 3
  fi

  az --version > '/tmp/expected-az.txt'
  diff '/tmp/expected-az.txt' 'az.txt'
  if [[ $? -ne 0 ]]
  then 
    return 4
  fi  
}


function verify_task_2() {
  if [[ ! -f 'az-login.txt' ]]
  then
    return 1
  fi

  c=$(grep -c "AzureCloud.*dafda750-ae63-46d1-8b81-3546648b438c.*2d1f3234-b3f6-481b-ab6d-0038d5edaddb" az-login.txt)
  if [[ $c -eq 0 ]]
  then 
    return 2
  fi  
}


function verify_task_3() {

  if [[ ! -f 'az-resource-group.txt' ]]
  then
    return 1
  fi


  c=$(grep -c "/subscriptions/2d1f3234-b3f6-481b-ab6d-0038d5edaddb/resourceGroups/my-resource-group.*northeurope" az-resource-group.txt)
  if [[ $c -eq 0 ]]
  then 
    return 2
  fi  
}


function verify_task_4() {

if [[ ! -f 'az-vnet.txt' ]]
  then
    return 1
  fi


  c=$(grep -c "/subscriptions/2d1f3234-b3f6-481b-ab6d-0038d5edaddb/resourceGroups/my-resource-group/providers/Microsoft.Network/virtualNetworks/my-vnet" az-vnet.txt)
  if [[ $c -eq 0 ]]
  then 
    return 2
  fi  
  
}
