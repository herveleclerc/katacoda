# Préparation CKA

CKA Prep

## A propos de ce Challenge

Si vous trouvez des erreurs, ou faire des proposition n'hésitez pas à me contacter : herve.leclerc@alterway.fr


https://www.katacoda.com/awh/courses/cka-challenges/cka-001


etcdctl --endpoints=https://172.17.0.23:2379 --cacert="/etc/kubernetes/pki/etcd/ca.crt" --cert=/etc/kubernetes/pki/etcd/healthcheck-client.crt --key=/etc/kubernetes/pki/etcd/healthcheck-client.key member list

ETCDCTL_API=3 etcdctl --endpoints=https://172.17.0.23:2379 --cacert="/etc/kubernetes/pki/etcd/ca.crt" --cert=/etc/kubernetes/pki/etcd/healthcheck-client.crt --key=/etc/kubernetes/pki/etcd/healthcheck-client.key snapshot save /tmp/etcd-backup.db


ETCDCTL_API=3 etcdctl --endpoints=https://172.17.0.23:2379 --cacert="/etc/kubernetes/pki/etcd/ca.crt" --cert=/etc/kubernetes/pki/etcd/healthcheck-client.crt --key=/etc/kubernetes/pki/etcd/healthcheck-client.key snapshot status /tmp/etcd-backup.db



etcdctl --endpoints=https://172.17.0.23:2379 --cacert="/etc/kubernetes/pki/etcd/ca.crt" --cert=/etc/kubernetes/pki/etcd/healthcheck-client.crt --key=/etc/kubernetes/pki/etcd/healthcheck-client.key snapshot status /tmp/etcd-backup.db -w json | grep "hash.*revision.*totalKey.*totalSize" | wc -l


hostname -i | awk '{print $2;}'