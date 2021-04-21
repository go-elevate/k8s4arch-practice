# Unidad 06 - Multi Container Pods

¡Bienvenidos!

Esta práctica se corresponde a la unidad teórica número 6, dedicada exclusivamente a los patrones de arquitectura que surgen de modelar varios contenedores en un mismo pod, y como podemos comunicarlos entre ellos.

## Enunciado

¡Habemus Frontend desacoplado!

Luego de un arduo trabajo, el equipo pudo separar también la capa de front del monolito, con lo cual ya es hora de pensar en deprecar éste último.

Sin embargo, todavía hay algunos detalles restantes a investigar para poder aislar las capas completamente, con lo cual hoy, en principio, **deberemos evolucionarlas juntas**.

Esta es una gran excusa para un pod multicontainer, para que ambos contenedores vivan bajo la misma unidad de despliegue y evolucionen bajo el mismo ciclo de entrega continua.

Denuevo, es una solución _temporal_ hasta que podamos desacoplar los componentes completamente, hasta incluso su codebase.

Por otro lado, nos solicitaron **dar soporte a db migrations**, ya que están evaluando la posibilidad de cambiar la información que se almacena en el modelo de hoteles, por lo que necesitan poder ejecutar, **previo a cada despliegue**, un script de _migrations_ para eventualmente actualizar el modelo si es necesario. 

_Este primer script de prueba carga 17 hoteles en la base, que se encuentra inicialmente vacía._

En un principio se pensó en un _Job_, pero no podemos garantizar a priori que siempre se ejecute antes que el despliegue del _Pod_, carecemos de secuencialidad en ese aspecto, por lo cual queda a merced de una condición de carrera. No queremos eso bajo ninguna circunstancia.

Usted, como Arquitecto, debe pensar o diseñar una solución para atacar estas necesidades: 

- `armar un script de migrations que comparta acceso al modelo de datos del backend, pero que ejecute cada vez que se despliega la aplicación, en forma temprana`
- `incorporar el frontend al manifiesto principal, como otro contenedor`

Datos adicionales:

- Recordar que la información de la base está en un recurso paramétrico de configuración (armado en la práctica pasada), con lo cual hay que incluirlo en el manifiesto final.
- Recordemos que parte de esa información contiene el directorio donde se almacena la base de datos, que deberá ser compartida por el script y la aplicación.
- El equipo nos preparó un comando sobre la imagen del backend para ejecutar las migrations únicamente. Es otro entrypoint de la misma imagen. Ellos lo ejecutan de esta manera para pruebas locales:
`docker run --entrypoint python ghcr.io/go-elevate/k8s4arch-hotels-backend:slim migrations.py`
- La imagen del frontend contiene la siguiente etiqueta: `ghcr.io/go-elevate/k8s4arch-hotels-frontend:slim`

---

Con el fin de realizar una breve autovalidación dejamos los siguientes consejos:

- Como primer chequeo general, todos los pods resultantes deberán quedar en estado _Running_. Esto implica que no hubo problemas con el manifiesto YAML.

- Luego, para corroborar que las _migrations_ ejecutaron según lo esperado y que los contenedores dentro del `multicontainer pod` se pueden visualizar exitosamente por red interna, se podría ejecutar una petición desde el contenedor de _frontend_ hacia el _backend_ de la siguiente manera:

```bash
kubectl exec -ti deploy/$DEPLOYMENT_NAME -- curl http://localhost:5000/hotels
```

Esto debería retornar un JSON con el contenido de todos los hoteles. **Si no retorna nada, es porque la base de datos se encuentra vacía y el script de migrations no surtió efecto alguno.**

## Entrega y Devolución

Con respecto a esta entrega, se espera del alumno:

- **un manifiesto que contenga un pod con la capa de frontend y backend en contenedores distintos**.
- **soporte a ejecución de migrations de bases de datos en ese mismo manifiesto**.

El docente corregirá el manifiesto YAML, probándolo contra su entorno configurado de Kubernetes. En base a los resultados que arroje ese estado deseado, será la nota correspondiente para el alumno.  

La publicación oficial de la práctica será por la plataforma Google Classroom, donde se generará un material con devolución pautada para una fecha en particular y que es calificable.


## Aclaraciones

Al alumno se le proporcionó:

- un manual teórico con toda la información relevante a la unidad.
- un manual estilo guía o _walkthrough_ con información que puede utilizar a modo de soporte para la resolución de la ejercitación en cuestión.

Si alguno de estos documentos no está en su poder, contactarse con el personal docente para resolver la situación.