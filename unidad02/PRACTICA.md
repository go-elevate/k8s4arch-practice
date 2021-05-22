# Unidad 02

La practica se desrarollo bajo los siguientes requerimientos.

- Host: Windows 10
- Hyper-V
- Guest: Ubuntu 20.04 LTS, con 6gb de Memoria y 127gb de disco, donde se instalo microk8s
- CPU Guest: 1

## Instalacion Microk8s

- Instalación de microk8s

![alt text][02]

- Agrego el usuario al grupo microk8s

![alt text][02]

- Verifico el status de la instalación 

![alt text][03]

- Genero el alias para trabajar mas comodo
- Verifico el estado del nodo y los servicios actuales

![alt text][04]

## Habilito los addons

- Instalo el dashboard

![alt text][05]

- Creo el Service Account y el ClusterRoleBinding

![alt text][06]

- Solicito el Token

```
nalderete@k8:~/k8s4arch-practice$ kubectl -n kubernetes-dashboard get secret $(kubectl -n kubernetes-dashboard get sa/admin-user -o jsonpath="{.secrets[0].name}") -o go-template="{{.data.token | base64decode}}"

```
![alt text][07]

- Home del dashboard

![alt text][07]

## Ejecuto NGINX

- Ejecuto un proxy nginx

![alt text][08]

- Verifico los pods en el dashboard

![alt text][09]

## Decripcion general del cluster

![alt text][10]
![alt text][11]
![alt text][12]

[01]: ./images/snap.PNG  "Instalación de microk8s"
[02]: ./images/addusergroup.PNG  "Agrego el usuario al grupo microk8s"
[03]: ./images/status.PNG  "Verifico el status de la instalación"
[04]: ./images/nodesservices.PNG  "Estado del nodo y los servicios actuales"
[05]: ./images/dashboard.png  "Instalo el dashboard"
[06]: ./images/serviceaccountrolebinding.png  "Service Account y el ClusterRoleBinding"
[07]: ./images/token.png  "Solicito el Token"
[08]: ./images/runnginx.png  "Ejecuto un proxy nginx"
[09]: ./images/pods.png  "Verifico los pods en el dashboard"
[10]: ./images/describe1.png  "Decribpcion de los nodos"
[11]: ./images/describe2.png  "Decribpcion de los nodos cont."
[12]: ./images/allnamespaces.png  "Verifico los namespaces"