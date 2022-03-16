#!/bin/bash

# This script is called by the solver utility. Each function should be named 
# verify_task_#, where # is the number of the task each function will solve.
# When a verification fails for a step, the error number returned corresponds 
# to the hint number found in hints.md.

# Delay before first hint and between steps. Zero or positive integer in seconds.
export HINTS_DELAY=15

# Max time for verify blocking commands. Zero or positive integer time units s, m, h.
export VERIFY_TIMEOUT=3s

alias k='/usr/bin/kubectl --kubeconfig=/root/.kube/config'

function verify_task_1() {
 
  content=$(k get pods --no-headers --selector run=nginx-pod  | grep nginx-pod | awk '{print $3;}')
  
  if [[ "$content" == "Running" ]]
  then
    echo "Verification passed"
    return 0
  else
    echo "Verification failed"
    return 1
  fi
}

function verify_task_2() {
 
  content=$(k get pods --no-headers --selector run=messaging --selector tier=msg  | grep messaging | awk '{print $3;}')
  

  if [[ "$content" == "Running" ]]
  then
    echo "Verification passed"
    return 0
  else
    echo "Verification failed"
    return 1
  fi
}


function verify_task_3() {
 
  content=$(k get ns --no-headers | grep cka-001 | awk '{print $2;}')
  
  if [[ "$content" == "Active" ]]
  then
    echo "Verification passed"
    return 0
  else
    echo "Verification failed"
    return 1
  fi
}

function verify_task_4() {
 
  content=$(k get nodes -o json | jq -r '.items[0].metadata.name')
  
  if [[ "$content" == "????" ]]
  then
    echo "Verification passed"
    return 0
  else
    echo "Verification failed"
    return 1
  fi
}