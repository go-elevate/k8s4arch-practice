# Unidad 04 - Diseño de Aplicaciones

¡Bienvenidos!

Esta práctica se corresponde a la unidad teórica número 4 donde se vieron algunas herramientas extras para optimizar el diseño de aplicaciones en la plataforma, siempre cumpliendo con los atributos de calidad de las aplicaciones _cloud-native_.

## Enunciado

#### Parte 1

La organización que lo contrató comenzó a incorporar otras soluciones a la plataforma, producto de la migración que se encuentran llevando a cabo ahora mismo.

Teniendo una variedad de aplicaciones en el cluster, comienza a ser una tarea compleja **identificarlas de una forma simple y unívoca** o incluso agruparlas para aplicarles cierta configuración.

¿Qué haria para solventar esta problemática? Una pista parecería venir por el lado de etiquetas/anotaciones, con lo cual dejamos a responsabilidad del lector etiquetar o anotar a la aplicación monolítica de hoteles, segun corresponda, para diferenciarla de otras aplicaciones que puedan ser desplegadas en el cluster.

Acá es importante que se comunique en la entrega qué criterios se utilizaron a la hora de catalogar la aplicación.

#### Parte 2

¡El equipo de desarrollo liberó una nueva versión de la aplicación monolítica de hoteles!

Esta vez, nos llegó la información que la imagen Docker de la aplicación tiene una nueva etiqueta: `ghcr.io/go-elevate/k8s4arch-hotels:monolith-v2`

Nos solicitan que diseñemos el manifiesto Kubernetes para **actualizar la versión de la aplicación**, teniendo en cuenta que:

- la nueva versión no está del todo validada, puede contener errores, por lo cual tenemos que tener un plan para volver a la versión estable rápidamente
- la actualización debería garantizar alta disponibilidad, no podemos dejar a los usuarios sin poder reservar hoteles, de eso depende el negocio de la organización
- no se piensa adicionar ninguna herramienta que nos ayude con la transparencia en la actualización de las aplicaciones de cara a los usuarios (canary, blue/green), con lo cual debería ser una estrategia soportada nativamente por la plataforma

¿Qué estrategia de despliegue considera óptima para este caso? Implemente los cambios necesarios en el YAML para soportar esta necesidad con la configuración particular según su criterio.

#### Parte 3

Actualizamos la aplicación, ¡perfecto! Pero descubrimos que debido a una mala decisión de diseño, la misma es bastante lenta para arrancar. Seguramente el problema radique por algún procesamiento costoso que provoca una **indisponibilidad temporal cuando se inicializa el contexto aplicativo**. 

Nos solicitan una vez más una intervención como Arquitectos. El problema parece ser claro: _necesitamos pedirle a Kubernetes que demore un tiempo previo a redigirir tráfico a la aplicación_.

¿Cómo podemos asegurar eso sin afectar la salud general de la aplicación? Implemente los cambios necesarios en el manifiesto YAML correspondiente.  

Como dato adicional nos informan que el frontend del monolito expone el contenido en el **puerto 80 por http**.


## Entrega y Devolución

Con respecto a esta entrega, se espera del alumno:

- **un manifiesto que contenga únicamente la solución propuesta para la primer parte**. Nota: es recomendable reutilizar el mismo archivo de la práctica pasada y adaptarlo.
- **un único manifiesto para la parte 2 y 3**  

El docente corregirá los manifiestos YAML, probándolos contra su entorno configurado de Kubernetes. En base a los resultados que arroje ese estado deseado, será la nota correspondiente para el alumno.  

La publicación oficial de la práctica será por la plataforma Google Classroom, donde se generará un material con devolución pautada para una fecha en particular y que es calificable.


## Aclaraciones

Al alumno se le proporcionó:

- un manual teórico con toda la información relevante a la unidad.
- un manual estilo guía o _walkthrough_ con información que puede utilizar a modo de soporte para la resolución de la ejercitación en cuestión.

Si alguno de estos documentos no está en su poder, contactarse con el personal docente para resolver la situación.