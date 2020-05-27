## Deploy the dev stack from scratch

- `task all`{{execute}} will deploy dev environment after a cleanup

## Check the deployment

`kubectl get pods -n dockercoins`{{execute}} -w

Hit `Ctrl-C`when all the pod are in ready state

## Acecss to the webui

Copy/Paste the output in a browser the output of this command

`echo ' '; echo [[HOST_SUBDOMAIN]]-$(kubectl get -o jsonpath="{.spec.ports[0].nodePort}" services webui -n dockercoins)-[[KATACODA_HOST]].environments.katacoda.com`{{execute}}

## test other environments

- `ENV=qa task deploy`{{execute}} will deploy QA environment

- `ENV=prod task deploy`{{execute}} will deploy PROD environment

## Cleanup

- `task clean`{{execute}}

### Templates

- default : main.jsonnet - Just use config and project file
- dev = default
- qa : change namespace and some tags of images,
- prod : change namespace, some tags of images and replicas (patching)
