#!/bin/bash

# This script is called by the solver utility. Each function should be named 
# verify_task_#, where # is the number of the task each function will solve.
# When a verification fails for a step, the error number returned corresponds 
# to the hint number found in hints.md.

# Delay before first hint and between steps. Zero or positive integer in seconds.
export HINTS_DELAY=15

# Max time for verify blocking commands. Zero or positive integer time units s, m, h.
export VERIFY_TIMEOUT=3s

export kctl="/usr/bin/kubectl --kubeconfig=/root/.kube/config"

function verify_task_1() {
 
  content=$(${kctl} get pods --no-headers --selector run=nginx-pod  | grep nginx-pod | awk '{print $3;}')
  
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
 
  content=$(${kctl} get pods --no-headers --selector run=messaging --selector tier=msg  | grep messaging | awk '{print $3;}')
  

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
 
  content=$(${kctl} get ns --no-headers | grep cka-001 | awk '{print $2;}')
  
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
 
  content=$(${kctl} get nodes -o json | jq -r '.items[0].metadata.name')

  if [ -f "/tmp/nodes.json" ]; then
    controplane=$(cat < "/tmp/nodes.json" | jq -r '.items[0].metadata.name')
  else 
    return 2
  fi
  
  if [[ "$content" == "$controplane" ]]
  then
    echo "Verification passed"
    return 0
  else
    echo "Verification failed"
    return 1
  fi
}

function verify_task_5() {
 
  content=$(${kctl} get services -l tier=msg --no-headers | grep messaging-service | awk '{print $1" "$2;}')
  
  if [[ "$content" == "messaging-service ClusterIP" ]]
  then
    echo "Verification passed"
    return 0
  else
    echo "Verification failed"
    return 1
  fi
}

function verify_task_6() {
 
  content=$(${kctl} get deploy --no-headers --selector app=hr-web-app  | grep hr-web-app | awk '{print $2;}')
  

  if [[ "$content" == "2/2" ]]
  then
    echo "Verification passed"
    return 0
  else
    echo "Verification failed"
    return 1
  fi
}

