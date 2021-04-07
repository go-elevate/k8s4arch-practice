# Unidad 2: Práctica

Para llevar acabo el ejercicio se utilizo una maquina virtual, provisionada mediante un Hyper-V.

Características de la VM utilizada:
- Sistema operativo del guest: Linux Ubuntu 20.04 LTS
- Memoria: 4gb
- CPU: 1

## Instalación de MicroK8s
Se utilizo la guía de la página de MicroK8s
https://microk8s.io/

- Descarga e instalación
```
   sudo snap install microk8s --classic
```



- Comprobación del estado de la instalación de MicroK8s
 
``` 
   sudo microk8s status --wait-ready
```
![alt text][01]

- Cambio de permisos
 
   ``` 
    sudo usermod -a -G microk8s juan
    sudo chown -f -R juan ~/.kube
   ```
  ![alt text][02]
- Estado del nodo
  ``` 
    microk8s kubectl get nodes
  ```

  ![alt text][03]

 
## Dashboard
- Creación del Pod NGINX
  ``` 
  microk8s kubectl run nginx --image nginx
  ```
  ![alt text][04] 

- Instalación del dashboard
  ``` 
  microk8s kubectl apply  https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0/aio/deploy/recommended.yaml
  ```
    ![alt text][05]
- Creación de cuenta de servicio oke-admin y RBAC
  ``` 
  microk8s kubectl apply -f oke-admin-service-account.yaml
  ```
  ![alt text][06]
- Generación de Token de acceso
![alt text][07]
- Comprobación de acceso al Dashboard

  Accediendo mediante un browser a la dirección 
  ```
  http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/.
  ```
  ![alt text][08]

  Vista de Pods
  ![alt text][11]

## Tareas finales
- Alias
 ![alt text][09]
- Visualización del estado de los nodos
 ![alt text][10]
- Vista ampliadas de los nodos
 ![alt text][12]
 ![alt text][13]






[01]: ./images/1_status_microk8s.png   "Estado de MicroK8s"

[02]: ./images/2_Cambio_de_Permisos.png   "Cambio de permisos"

[03]: ./images/3_Get_nodes.png  "Obtener estado de nodo"

[04]: ./images/4_Pod_nginx_created.png   "Instalación de NGINX"

[05]: ./images/5_Install_kubernetes_dashboard.png   "Instalación de dashboard"

[06]: ./images/6_Oke_admin_created.png   "Se creo la cuenta OKE ADMIN"

[07]: ./images/7_Token_created.png   "Token creado"

[08]: ./images/8_Dashboard_01.png   "Dashboard"

[09]: ./images/9_Alias_created.png   "Alias cambiado"

[10]: ./images/10_Get_Nodes_o_Wide.png   "Obtengo info ampliada de los nodos"

[11]: ./images/11_Pods_status.png "Dashboard nodos"

[12]: ./images/12_describe_nodes01.png "Nodos 1"

[13]: ./images/13_describe_nodes02.png "Nodos 2"
