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

function verify_task_7() {
 
  hostname=$(hostname)

  content=$(${kctl} get pod --no-headers --selector run=static-pod  | grep static-pod-${hostname} | awk '{print $3;}')
  

  if [[ "$content" == "Running" ]]
  then
    echo "Verification passed"
    return 0
  else
    echo "Verification failed"
    return 1
  fi
}

function verify_task_8() {
 
  content=$(${kctl} get pods --no-headers -n finance --selector run=temp-bus  | grep temp-bus | awk '{print $3;}')
  
  if [[ "$content" == "Running" ]]
  then
    echo "Verification passed"
    return 0
  else
    echo "Verification failed"
    return 1
  fi
}

function verify_task_9() {
 
  content=$(${kctl} get pods --no-headers -n default --selector run=orange | grep orange | awk '{print $3;}')
  
  if [[ "$content" == "Running" ]]
  then
    echo "Verification passed"
    return 0
  else
    echo "Verification failed"
    return 1
  fi
}

function verify_task_10() {
 
  curl -s -o /dev/null localhost:30082

  retVal=$?

if [ $retVal -ne 0 ]
  then
    echo "Verification failed"
    return 1
  else
    echo "Verification passed"
    return 0
  fi
}

function verify_task_11() {
 
  content=$(${kctl} get nodes -o jsonpath='{.items[*].status.nodeInfo.osImage}')

  if [ -f "/tmp/osImage.txt" ]; then
    osImage=$(cat < "/tmp/osImage.txt")
  else 
    return 2
  fi
  
  if [[ "$content" == "$osImage" ]]
  then
    echo "Verification passed"
    return 0
  else
    echo "Verification failed"
    return 1
  fi
}

function verify_task_12() {
 
  content=$(${kctl} get pv --no-headers | grep pv-analytics | awk '{print $1" "$2" "$3" "$5;}')
  path=$(${kctl} get -o jsonpath='{.spec.hostPath.path}' pv pv-analytics)

  if [[ "$content" == "pv-analytics 100Mi RWX Available" ]]
  then
    if [[ "$path" == "/pv/data-analytics" ]]
    then
      echo "Verification passed"
      return 0
    else
      echo "Verification failed"
      return 1
    fi
  else
    echo "Verification failed"
    return 1
  fi
}

function verify_task_13() {
  if [ -f "/root/fin-challenge.json" ]; then
     prenom=$(cat < "/root/fin-challenge.json" | jq -r '.prenom')
     nom=$(cat < "/root/fin-challenge.json" | jq -r '.nom')
     email=$(cat < "/root/fin-challenge.json" | jq -r '.email')
     code=$(cat < "/root/fin-challenge.json" | jq -r '.code')
     if [[ -z "$prenom" ]]  ||  [[ -z "$nom" ]] || [[ -z "$code" ]] || [[ -z "$email" ]]
     then
       echo "Verification failed"
       return 1
     else
       if [[ "$prenom" != "CHANGEZ-MOI" && "$nom" != "CHANGEZ-MOI" && "$code" != "CHANGEZ-MOI"  && "$email" != "CHANGEZ-MOI" ]]; then
          curl --fail -X POST -H 'Content-Type: application/json' \
            --data "{\"alias\":\"strongmind\",
            \"emoji\":\":strongmind:\",
             \"text\":\"Challenge cka-001\",
            \"attachments\":[{\"title\":\"Réussite du Challenge cka-001 (katacoda)\",
            \"title_link\":\"https://www.katacoda.com/awh/courses/cka-challenges/cka-001\",\"text\":\"$prenom $nom ($email) a réussi la certification\",\"color\":\"#764FA5\"}]}" \
            https://rocket.alterway.fr/hooks/QxnH7sqdQwLeby5vP/E5KwEWg88cT8RHrJJifYzdG5wfL5RPySPzKwMxZp$code
            retVal=$?
            if [ $retVal -ne 0 ]
            then
              echo "Verification failed"
              return 1
            else
              echo "Verification passed"
              rm -f /root/fin-challenge.json
              return 0
            fi
        else
          echo "Verification failed"
          return 1
        fi
     fi
  else
    return 1
  fi
}

