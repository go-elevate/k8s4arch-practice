# Unidad 02 - Arquitectura de la Solución

Esta práctica se corresponde a la unidad teórica número 2 sobre la distribución de los componentes que conforman la plataforma de Kubernetes, y que responsabilidades derivan de esa distribución.

## Enunciado

Se busca crear el **cluster Kubernetes** de base sobre el cual trabajaremos todo el resto del curso. 

Consideraciones:

- Iniciaremos el resto de las unidades con conceptos básicos pero que se irán complejizando conforme avance el curso, con esta información buscamos que el alumno dimensione el alcance de los contenidos que va a implementar.
- El cluster debe ser un ambiente robusto y tolerante a fallos, se quiere evitar caer en problemáticas relacionadas a la infraestructura en las siguientes unidades.
- Se puede arrancar con una configuración básica, **pero se deberá explicar como dejaría eventualmente el cluster configurado para garantizar alta disponibilidad en las aplicaciones**.   

## Entrega y Devolución

Con respecto a la entrega, 

- si se utilizó un aprovisionamiento declarativo basta con subir el archivo de código fuente que se haya utilizado para crear el cluster.
- si se utilizó un aprovisionamiento manual, enviar en esta carpeta las capturas que usted crea necesarias para corroborar que se llegó a tener el cluster esperado en su versión final. (por ejemplo output de comandos como `kubectl version` o `kubectl get nodes -o wide`)
- si se configuró un cluster pequeño por temas de costos, dejar evidenciado cómo lo modificaría eventualmente para llegar a una configuración robusta y estable.


## Aclaraciones

Al alumno se le proporcionó:

- un manual teórico con toda la información relevante a la unidad.
- un manual estilo guía o _walkthrough_ con información que puede utilizar a modo de soporte para la resolución de la ejercitación en cuestión.

Si alguno de estos documentos no está en su poder, contactarse con el personal docente para resolver la situación.
