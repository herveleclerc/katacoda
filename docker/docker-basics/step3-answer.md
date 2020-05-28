#### Vérifier que votre image est bien lancée

`docker ps`{{execute}}

Si vous avez bien lancé votre premier service vous devriez voir quelque chose d'approchant si vous taper la commande 
`docker ps`

```
docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS
              NAMES
6d58a36fd532        tutum/hello-world   "/bin/sh -c 'php-f..."   5 seconds ago       Up 4 seconds        0.0.0.0
:80->80/tcp   eloquent_wright
```

Notez :

- la première colonne correspond à l'ID de votre conteneur, la dernière au nom de votre conteneur.
- Si vous ne précisez aucun nom le serveur docker génère un nom unique pour votre conteneur


### Vérifier que vous avez accès au site web de l'image

http://[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com

