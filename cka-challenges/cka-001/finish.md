Parfait ! Vous avez fini Challenge n°1 du troubleshhoting kubernetes


## References 📚


1: `kubectl run nginx-pod --image=nginx:alpine`
2: `kubectl run messaging --image=redis:alpine  -l tier=msg`
3: `kubectl create ns cka-001` 
4: `kubectl get nodes -o json > /tmp/nodes.json`
5: `kubectl expose pod messaging --name messaging-service --port 6379`
6: `kubectl create deployment hr-web-app --image=kodekloud/webapp-color`
   `kubectl scale deployment hr-web-app --replicas=2`
