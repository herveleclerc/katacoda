---

Wait ...

For the long init script wait for the message `done`

## Parameters to set

- kubernetes api address

Run the following command to get the kubernetes api address

`kubectl cluster-info`{{execute}}

- Edit Taskvars.yml replace 127.0.0.1 by the ip address of master given by `cluster-info`

`vi Taskvars.yml`{{execute}}

or if you can't vi ;)

`nano Taskvars.yml`{{execute}}

or if you are really leazy

`sed -i "s/127.0.0.1/$(kubectl cluster-info | head -n 1 | awk -F[/:] '{print $4}')/g" Taskvars.yml`{{execute}}

- Project name must not contains white `space` or `$`
