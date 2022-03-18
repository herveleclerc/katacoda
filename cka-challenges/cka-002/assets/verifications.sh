#!/bin/bash

# This script is called by the solver utility. Each function should be named 
# verify_task_#, where # is the number of the task each function will solve.
# When a verification fails for a step, the error number returned corresponds 
# to the hint number found in hints.md.

# Delay before first hint and between steps. Zero or positive integer in seconds.
export HINTS_DELAY=15

# Max time for verify blocking commands. Zero or positive integer time units s, m, h.
export VERIFY_TIMEOUT=3s

export ETCDCTL_API=3

export kctl="/usr/bin/kubectl --kubeconfig=/root/.kube/config"

export ectl="etcdctl --endpoints=https://$(hostname -i | awk '{print $2;}'):2379 --cacert="/etc/kubernetes/pki/etcd/ca.crt" --cert=/etc/kubernetes/pki/etcd/healthcheck-client.crt --key=/etc/kubernetes/pki/etcd/healthcheck-client.key"

function verify_task_1() {
 
  if [ -f "/tmp/etcd-backup.db" ]
  then
    content=$(${ectl} snapshot status /tmp/etcd-backup.db -w json | grep -c "hash.*revision.*totalKey.*totalSize")
    if [[ "$content" == "1" ]]
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

function verify_task_2() {
 
  content=$(${kctl} get pods -n default --no-headers --selector run=elliphant | grep elliphant | awk '{print $3;}')
  request_cpu=$(${kctl} get -n default -o jsonpath='{.spec.containers[0].resources.requests.cpu}' po elliphant)
  request_memory=$(${kctl} get -n default -o jsonpath='{.spec.containers[0].resources.requests.memory}' po elliphant)

  if [[ "$content" == "Running" ]]
  then
    if [[ "$request_cpu" == "250m" ]]
    then
      if [[ "$request_memory" == "200Mi" ]]
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
  else
    echo "Verification failed"
    return 1
  fi
}


function verify_task_3() {
 
  content=$(${kctl} get pods -n default --no-headers --selector run=super-user-pod | grep super-user-pod | awk '{print $3;}')
  capabilities=$(${kctl} get -n default -o jsonpath='{.spec.containers[0].securityContext.capabilities.add[0]}' po super-user-pod)
  

  if [[ "$content" == "Running" ]]
  then
      if [[ "$capabilities" == "SYS_TIME" ]]
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

function verify_task_4() {
 
  content=$(${kctl} get pods -n default --no-headers --selector run=use-pv | grep use-pv | awk '{print $3;}')

  nv=$(${kctl} get -n default po use-pv -o json | jq '.spec.containers[0].volumeMounts | length')


  if [[ "$content" == "Running" ]]
  then      
     for (( i=0; i<$nv; i++ ))
     do
      mountpath=$(${kctl} get -n default -o jsonpath="{.spec.containers[0].volumeMounts[$i].mountPath}" po use-pv)
      echo "$mountpath"
      if [[ "$mountpath" == "/data" ]]
      then
        echo "Verification passed"
        return 0
      fi
     done
  else
    echo "Verification failed"
    return 1
  fi
}

function verify_task_5() {
 
  content=$(${kctl} get pods -n default --no-headers --selector app=nginx-deploy | grep nginx-deploy | awk '{print $3;}')
  
  annotation=$(${kctl} get -n default -o jsonpath='{.metadata.annotations.deployment\.kubernetes\.io\/revision}' deploy nginx-deploy)
  

  if [[ "$content" == "Running" ]]
  then
      if [[ "$annotation" == "2" ]]
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


function verify_task_3() {
 
  create=$(${kctl} auth can-i create pods --as=alterway --namespace=development)
  watch=$(${kctl} auth can-i watch pods --as=alterway --namespace=development)
  

  if [[ "$create" == "yes" ]]
  then
      if [[ "$watch" == "no" ]]
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

function verify_task_7() {
 
  hostname=$(hostname)

  ${kctl} run -n resolver test-resolver --rm -i --image=busybox:1.28 --restart=Never -- nslookup nginx-resolver-service > /opt/expected-nslookup-service.txt

  if [[ ! -f /tmp/test-nslookup-service.txt ]]
  then
    echo "Verification failed"
    return 2
  fi


  diff '/opt/expected-nslookup-service.txt' '/tmp/test-nslookup-service.txt'
  if [[ $? -ne 0 ]]
  then
    echo "Verification failed"
    return 1
  else
    echo "Verification passed"
    return 0
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
  if [ -f "/tmp/fin-challenge.json" ]; then
     prenom=$(cat < "/tmp/fin-challenge.json" | jq -r '.prenom')
     nom=$(cat < "/tmp/fin-challenge.json" | jq -r '.nom')
     email=$(cat < "/tmp/fin-challenge.json" | jq -r '.email')
     code=$(cat < "/tmp/fin-challenge.json" | jq -r '.code')
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
              rm -f /tmp/fin-challenge.json
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

