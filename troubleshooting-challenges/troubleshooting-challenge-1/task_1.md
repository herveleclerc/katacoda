
Première chose à faire:

Vérifier l'état du déployment : 

```
kubectl get deploy hello-world
```

Vous devez avoir quelque chose comme ceci

```
NAME          READY   UP-TO-DATE   AVAILABLE   AGE
hello-world   0/1     0            0           6s
```

Regardez les caractériqtiques du déploiement :

```
kubectl describe deploy hello-world
```

Remarquez que le déploiement est en erreur. et notez le label `app=hello-world`

Listez les pods du déploiement :

```
kubectl get pods --selector app=hello-world
```

Notez le **STATUS** 

Il est en `ImagePullBackOff` 

Regardez les log du pod 

```
kubectl logs -l app=hello-world
```

**Corrigez l'erreur en ligne de commande !**

Soyez Patient et observe les changements avec la commande  

```
 watch 'kubectl get pods --selector app=hello-world'
```

