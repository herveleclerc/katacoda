#!/bin/bash

# This script is called by the solver script. Each function should be named solve_task_#, 
# where # is the number of the task each function will solve. The calling solver will call
# the corresponding verify_task_# function after each solver_task_# function completes. 

export ETCDCTL_API=3

export kctl="/usr/bin/kubectl --kubeconfig=/root/.kube/config"

export ectl="etcdctl --endpoints=https://$(hostname -i | awk '{print $2;}'):2379 --cacert="/etc/kubernetes/pki/etcd/ca.crt" --cert=/etc/kubernetes/pki/etcd/healthcheck-client.crt --key=/etc/kubernetes/pki/etcd/healthcheck-client.key"


function solve_task_1() {
  ${ectl} snapshot save /tmp/etcd-backup.db
  ${ectl} snapshot status /tmp/etcd-backup.db -w json > /tmp/etcd-backup.db.json
}

function solve_task_2() {
  ${kctl} apply -f /opt/.logs/elliphant.yaml
}

function solve_task_3() {
 ${kctl} apply -f /opt/.logs/super-user-pod.yaml
}

function solve_task_4() {
   ${kctl} apply -f /opt/.logs/pvc-1.yaml
   ${kctl} apply -f /opt/.logs/use-pv-good.yaml
}

function solve_task_5() {
  ${kctl} create deploy nginx-deploy --image=nginx:1.17
  ${kctl} set image deployment/nginx-deploy nginx=nginx:1.18
  ${kctl} rollout status deploy nginx-deploy
}

function solve_task_6() {

cat <<EOF> alterway-user.yaml
apiVersion: certificates.k8s.io/v1beta1
kind: CertificateSigningRequest
metadata:
  name: alterway-developer
spec:
  request: $(cat "/root/alterway-csr.pem" | base64 | tr -d '\n')
  usages:
  - digital signature
  - key encipherment
  - server auth
EOF
  
   ${kctl} create -f /root/alterway-user.yaml
   ${kctl} get csr
   ${kctl} certificate approve alterway-developer
   ${kctl} get csr
   ${kctl} create role developer -n development --verb=create,list,get,update,delete --resource=pods
   ${kctl} create rolebinding developer-binding --role=developer --user=alterway --namespace=development
   ${kctl} auth can-i create pods --as=alterway --namespace=development
}

function solve_task_7() {
  ${kctl} create ns resolver
  ${kctl} run -n resolver nginx-resolver --image=nginx
  ${kctl} expose pod -n resolver nginx-resolver --name nginx-resolver-service --port=80 --target-port=80 --type=ClusterIP
  ${kctl} run -n resolver test-resolver --rm -i --image=busybox:1.28 --restart=Never -- nslookup nginx-resolver-service > /tmp/test-nslookup-service.txt
}

function solve_task_8() {
  ${kctl} create namespace cka-ressources

cat <<EOF> /root/resource-quota.yaml
apiVersion: v1
kind: ResourceQuota
metadata:
  name: resource-quota
  namespace: cka-ressources
spec:
  hard:
    requests.memory: 1Gi
    limits.memory: 2Gi
EOF

  ${kctl}  apply -f /root/resource-quota.yaml

cat <<EOF> /root/pod-over-request.yaml
apiVersion: v1
kind: Pod
metadata:
  name: cka-pod-1
  namespace: cka-ressources
spec:
  containers:
  - name: cka-pod-1
    image: redis:alpine
    resources:
      requests:
        memory: "1.5G"
        cpu: "250m"
      limits:
        memory: "2G"
EOF

  ${kctl} apply -f /root/pod-over-request.yaml

  echo 'Error from server (Forbidden): error when creating "/root/pod-over-request.yaml": pods "cka-pod-1" is forbidden: exceeded quota: resource-quota, requested: requests.memory=1500M, used: requests.memory=0, limited: requests.memory=1Gi' > /tmp/pod-over-request.txt
}


function solve_task_9() {
  ${kctl} create ns healthchecking

cat <<EOF> /root/probe-http.yaml
apiVersion: v1
kind: Pod
metadata:
  name: cka-nginx-1
  namespace: healthchecking
spec:
  containers:
  - name: liveness
    image: nginx
    livenessProbe:
      httpGet:
        path: /
        port: 80
      initialDelaySeconds: 3
      periodSeconds: 5
EOF

  ${kctl} apply -f /root/probe-http.yaml
  ${kctl} exec -n healthchecking cka-nginx-1 -- rm /usr/share/nginx/html/index.html

  echo "Liveness probe failed: HTTP probe failed with statuscode: 403" > /tmp/healthchecking.txt
}

function solve_task_10() {
  ${kctl} label node node01 disk=ssd

cat <<EOF> /root/node-selector.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: app001
  name: app001
  namespace: constraints
spec:
  replicas: 2
  selector:
    matchLabels:
      app: app001
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: app001
    spec:
      containers:
      - image: nginx:alpine
        name: nginx
        resources: {}
      nodeSelector:
       disk: ssd
EOF

 ${kctl} apply -f /root/node-selector.yaml

}

function solve_task_11() {
  ${kctl} get secret supersecret -n kube-system -o jsonpath='{.data.acopier}' | base64 --decode > /tmp/supersecret.txt
}

function solve_task_12() { 
   ${kctl} port-forward -n app002 myapp002 8080:8080 &
   echo "BONJOURBONJOUR" > /tmp/mystery.txt
}

function solve_task_13() { 
  if [ -f "/tmp/fin-challenge.json" ]; then
     prenom=$(cat < "/tmp/fin-challenge.json" | jq -r '.prenom')
     nom=$(cat < "/tmp/fin-challenge.json" | jq -r '.nom')
     code=$(cat < "/tmp/fin-challenge.json" | jq -r '.code')
     email=$(cat < "/tmp/fin-challenge.json" | jq -r '.email')

  curl -X POST -H 'Content-Type: application/json' \
   --data "{\"alias\":\"strongmind\",
            \"emoji\":\":strongmind:\",
             \"text\":\"Challenge cka-002\",
            \"attachments\":[{\"title\":\"Réussite du Challenge cka-002 (katacoda)\",
            \"title_link\":\"https://www.katacoda.com/awh/courses/cka-challenges/cka-001\",\"text\":\"$prenom $nom ($email) a réussi la certification\",\"color\":\"#764FA5\"}]}" \
   https://rocket.alterway.fr/hooks/QxnH7sqdQwLeby5vP/E5KwEWg88cT8RHrJJifYzdG5wfL5RPySPzKwMxZp$code
  else
    return 0
  fi
}
