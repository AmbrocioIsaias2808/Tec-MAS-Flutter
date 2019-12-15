Esta es una copia de la versión estable TecMAS-19.12.14.02-(SQLiteDatabase-Experimental), básicamente es una copia de seguridad de mi repositorio local.

Esta versión incorpora mejoras en diversos aspectos como:

* Incorporación de nuevos temas y colores.
* Se corrigen errores de versiones anteriores (Sin embargo aún falta checar lo relevante a las notificaciones).
* Se incorpora guardado de artículos favoritos por el usuario (falta arreglar el borrado del mismo).
* Las paginas de correspondientes a las vistas de artículos incorporan en su funcionamiento el despliegue de artículos desde la base de datos (en caso de falta de conexión a internet).
* Se puede paginar entre la vista de artículos y artículos guardados sin perder el estado de los widgets.



Razones para realizar esta copia de seguridad:

1. Deseo tener un respaldo
2. Realizaré cambios en el sistema de navegación para obtener cierta persistencia y no tener que realizar peticiones innecesarias al servidor y gastar datos (cada vez que se cambia a un apartado de lista de artículos, este se vuelve a crear y con ello se realiza una petición al servidor.)