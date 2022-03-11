
### Première chose à faire:


- Vérifier l'état du déployment : 

```
kubectl get deploy hello-world ↩️
```

- Vous devez avoir quelque chose comme ceci :

```
NAME          READY   UP-TO-DATE   AVAILABLE   AGE
hello-world   0/1     0            0           6s
```

- Regardez les caractériqtiques du déploiement :

```
kubectl describe deploy hello-world ↩️
```

- Remarquez que le déploiement est en erreur

- Notez le label `app=hello-world`

- Listez les pods du déploiement :

```
kubectl get pods --selector app=hello-world ↩️
```

- Notez le **STATUS** 

  - Il est en `ImagePullBackOff`  ou `ErrImagePull` 

- Regardez les logs du pod 

- Vous pouvez utiliser les labels pour pointer vers le pod :

```
kubectl logs -l app=hello-world ↩️
```

Maintenant c'est à vous 

**Corrigez l'erreur en ligne de commande !**

Soyez Patient et observez les changements avec la commande  

```
 watch 'kubectl get pods --selector app=hello-world'
```

