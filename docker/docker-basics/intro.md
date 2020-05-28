Un peu d'histoire sur les conteneurs et Docker

### Premières expérimentations

- [IBM VM/370 (1972)](https://en.wikipedia.org/wiki/VM_(operating_system))
- [Linux VServers (2001)](http://www.solucorp.qc.ca/changes.hc?projet=vserver)
- [Solaris Containers (2004)](https://en.wikipedia.org/wiki/Solaris_Containers)
- [FreeBSD jails (1999)](https://www.freebsd.org/cgi/man.cgi?query=jail&sektion=8&manpath=FreeBSD+4.0-RELEASE)

Au fait:
**En 72 vous aviez quel age ?**

---

### Les origines du projet Docker

- dotCloud était un PAAS utilisant un moteur de conteneur custom.
- Ce moteur était au départ basé sur OpenVZ (puis plus tard sur LXC) et AUFS.
- Au départ (circa 2008) Un simple script Python.
- A partir de  2012, le moteur avait une dizaine de composants Python (et déjà une centaine de micro-services!)
- Fin 2012, dotCloud a refactorisé son moteur de conteneurs
- Le nom de code de projet était :  "Docker"

---

### Première version publique

- Mars 2013, à la PyCon de Santa Clara: "Docker" est montré en public pour la première fois
- C'est une version avec une licence Open Source
- Les feedback et réactions sont très positifs
- Les équipes de  dotCloud team migrents progressivement vers le développement de Docker
- La même année dotCloud devient Docker
- En 2014 l'activité PAAS de dotCloud est vendue.

---

### Premiers utilisateurs de Docker

- PAAS builders (Flynn, Dokku, Tsuru, Deis...)
- Utilisateurs PAAS (ceux qui étaient assez gros pour construire leur propre PAAS)
- Plateforme d'intégration continue (CI)
- développeurs, développeurs, développeurs, développeurs, développeurs

---

### A propos de  Docker Inc

- Docker Inc. était au départ dotCloud Inc
- dotCloud Inc. était une entreprise française
- Docker Inc. est le premier sponsors et contributeur du projet Docker :
  - Embauche les contributeurs et mainteneurs
  - Fournit l'infrastructure pour le projet
  - Maintient et fait tourner le Docker Hub.
- Siège basé à San Francisco.
- > 150M capital.

---

### Comment Docker Inc. fait du brouzouf ?

- SAAS
  - Docker Hub (par les private repo)
  - Docker Cloud (par node)
- Subscription
  - on-premise stack (Docker Datacenter)
  - DTR (Docker Trusted Registry)
  - UCP (Universal Control Plane)
  - CS (Moteur avec support commercial)
- Support
- Training et consulting

