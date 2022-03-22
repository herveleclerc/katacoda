#!/bin/bash

# This script is called by the solver script. Each function should be named solve_task_#, 
# where # is the number of the task each function will solve. The calling solver will call
# the corresponding verify_task_# function after each solver_task_# function completes. 


export kctl="/usr/bin/kubectl --kubeconfig=/root/.kube/config"

function solve_task_1() {
 ${kctl} run nginx-pod --image=nginx:alpine
}

function solve_task_2() {
  ${kctl} run messaging --image=redis:alpine  -l tier=msg
}

function solve_task_3() {
  ${kctl} create ns cka-001
}

function solve_task_4() {
  ${kctl} get nodes -o json > /tmp/nodes.json
}

function solve_task_5() {
  ${kctl} expose pod messaging --name messaging-service --port 6379
}

function solve_task_6() {
  ${kctl} create deployment hr-web-app --image=kodekloud/webapp-color
  ${kctl} scale deployment hr-web-app --replicas=2   
}

function solve_task_7() {
  ${kctl} run static-pod --image=busybox --command sleep 1000 --dry-run=client -o yaml > static-pod.yaml
  cp static-pod.yaml /etc/kubernetes/manifests/.
}

function solve_task_8() {
  ${kctl} create namespace finance
  ${kctl} run temp-bus -n finance --image=redis:alpine
}


function solve_task_9() {
  ${kctl} apply -f /opt/orange-app-good.yaml
}

function solve_task_10() {

  ${kctl} expose deploy hr-web-app --name hr-web-app-service --port 8080  --type NodePort --target-port 8080 
  ${kctl} patch svc hr-web-app-service --patch '{"spec": { "type": "NodePort", "ports": [ { "nodePort": 30082, "port": 8080, "protocol": "TCP", "targetPort": 8080 } ] } }'
}

function solve_task_11() {
  ${kctl} get nodes -o jsonpath='{.items[*].status.nodeInfo.osImage}' > /tmp/osImage.txt
}

function solve_task_12() { 
   k apply -f /opt/pv-analytics.yaml
}

function solve_task_13() { 
  if [ -f "/root/fin-challenge.json" ]; then
     prenom="Hervé"
     nom="Leclerc"
     code=$(cat < "/root/fin-challenge.json" | jq -r '.code')
     email=$(cat < "/root/fin-challenge.json" | jq -r '.email')

  curl -X POST -H 'Content-Type: application/json' \
   --data "{\"alias\":\"strongmind\",
            \"emoji\":\":strongmind:\",
             \"text\":\"Challenge cka-001\",
            \"attachments\":[{\"title\":\"Réussite du Challenge cka-001 (katacoda)\",
            \"title_link\":\"https://www.katacoda.com/awh/courses/cka-challenges/cka-001\",\"text\":\"$prenom $nom ($email) a réussi la certification\",\"color\":\"#764FA5\"}]}" \
   https://rocket.alterway.fr/hooks/QxnH7sqdQwLeby5vP/E5KwEWg88cT8RHrJJifYzdG5wfL5RPySPzKwMxZp$code
  else
    return 0
  fi
}
