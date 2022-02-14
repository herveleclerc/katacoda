## docker search

Il est fort possible que quelqu’un a eu les mêmes besoin que vous et ai mis à disposition son travail dans le hub de Docker.

Pour cela nous allons utiliser la commande **search** de Docker

### version Docker jusqu'à 1.10

```
usage:  docker search [OPTIONS] TERM

Search the Docker Hub for images

  --automated        Only show automated builds

  --help             Print usage

  --no-trunc         Don't truncate output

  -s, --stars        Only displays with at least x stars

```

### version Docker à partir de 1.11

```

Utilisation : docker search [OPTIONS] TERM

Options possibles :

--automated=false    Only show automated builds

--no-trunc=false     Don't truncate output

-s, --stars=0        Only displays with at least x stars

Par exemple recherchons toutes les images officielles :
```

`docker search nginx`{{execute}}

TP :

Chercher les images **tutum/hello-world** ayant 3 étoiles et ayant un build automatique :
