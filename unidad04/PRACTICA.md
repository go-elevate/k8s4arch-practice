# Unidad 4

## Parte 1

Los criterios para los labels generados en el deployment son los siguientes.
- modulo: Para poder identificar los recursos por vertical de negocio o equipo de trabajo. Por ej: pagos, dashboard, autenticacion, transferencias, etc. En el caso de la practica reservas seria nuestro modulo.
- capa: frontend, backend, database, cache, etc. En el caso de la practica el contenedor es un monolito.
- version: Release de la aplicación. Por ejemplo: 1.0.1, 1.2, etc. La idea es que el mismo coincida con el tag del container. En el caso de la practica: monolith
- tecnologia: Label referente a la tecnologia usada, por ejemplo: java, python, angular, react. En este caso react-python
- ambiente: Ambiente en el cual esta corriendo la aplicación.