# Unidad 02 - Arquitectura de la Solución

Esta práctica se corresponde a la unidad teórica número 2 sobre la distribución de los componentes que conforman la plataforma de Kubernetes, y que responsabilidades derivan de esa distribución.

## Enunciado

Se busca crear el **cluster Kubernetes** de base sobre el cual trabajaremos todo el resto del curso.


## Resolucion

Se procedio a instalar microk8s localmente (MAC + Multipass).
Se siguieron todos los puntos indicados en la guía de instalación, más los del walkthrough.
Se suben dos capturas de pantalla y archivos .txt con las salidas de algunos comandos.


## Consideraciones

Quería intentar armar con alguna maquina virtual más algún otro nodo, de manera de tener 2 o 3 nodos workers (igual serían todos hosteados en la misma máquina) para hacer pruebas de alta disponibilidad si bajaba un nodo, pero lo dejé en suspenso atenta al comentario de Matias Ruggier que nos recomendaba "dejar eso así, con un solo nodo, ya que va a ser tu base para todas las prácticas que se vienen, el alcance con microk8s en esta práctica es single node"
