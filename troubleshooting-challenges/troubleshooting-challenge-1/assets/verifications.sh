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
 
  content=$(/usr/bin/kubectl --kubeconfig=/root/.kube/config get pods --no-headers --selector app=hello-world  | grep hello-world | awk '{print $3;}')
  

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
 
  content=$(/usr/bin/kubectl --kubeconfig=/root/.kube/config get deploy --no-headers --selector app=hello-world  | grep hello-world | awk '{print $2;}')
  

  if [[ "$content" == "2/2" ]]
  then
    echo "Verification passed"
    return 0
  else
    echo "Verification failed"
    return 1
  fi
}