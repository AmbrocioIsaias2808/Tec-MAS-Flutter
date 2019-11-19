# Tec-MAS Flutter



**Sistema informativo de comunicación y difusión para la comunidad del TecNM/ITM**

*Seguimos trabajando en el nombre*

------

### ¿Qué es Tec-Mas?

Tec-MAS pretende ser un medio de comunicación y difusión de información entre la institución educativa TecNM/ITM y su comunidad Institucional, permitiendo ofrecer la información importante y de relevancia académica de la forma mas oportuna y rápida posible.

------

### Notas del Desarrollador:

En la presente versión se puede decir que se ha logrado generar la aplicación Homologa a la antes generada en el repositorio de <a href="https://github.com/AmbrocioIsaias2808/Tec-MAS" target="_blank">TecMAS</a> sin embargo esta versión:

* Permite visualizar todos los artículos dados de alta en la plataforma de wordpress de forma "paginada" 
* Se incorpora un lector pdf para el calendario, ya no es simplemente un webview a una vista de google docs.
* Es posible visualizar los artículos y navegar entre hipervínculos (a excepción de aquellos que requieren abrir una nueva pestaña, esos no están permitidos por flutter hasta el momento).

Por el momento se siguen utilizando los plugins de lado de servidor:

- ```
  Wordpress Rest API v2
  ```

- ```
  Better REST API Featured Images
  ```

Las peticiones se siguen procesando en formato JSON.

**Cosas por hacer:**

* Mejorar el diseño (se, no me sigue gustando).
* Implementar seguridad para el sistema de backend.
* Ajustar ciertos detalles en la sección de transporte (en funcionamiento interno, en cuanto a datos guardados en el cache).
* Resolver un pequeño bug en la vista del calendario (corregir el disparo de una excepción)
* Resolver un pequeño bug visual en el apartado de inicio (al momento de recargar mientras se solicitan artículos al mismo tiempo).
* Implementar el servicio de notificaciones de OneSignal y Adaptarlo a nuestros requerimientos.
* Instruirme en el manejo de bases SQLite en flutter e implementar mejoras en la carga de contenido, rendimiento y funcionalidades.

*Cosas por hacer de forma personal: *

De la rama TecMAS-19-11-18-(Lector-de-Articulos) a las anteriores necesito agregar comentarios de cambios por versión.

**Capturas de Pantalla:**

<p align="center"><img src="ReadmeFiles/ (1).png" alt=" (1)" width='50%' /></p>
<p align="center"><img src="ReadmeFiles/ (2).png" alt=" (2)" width='50%' /></p>
<p align="center"><img src="ReadmeFiles/ (3).png" alt=" (3)" width='50%' /></p>
<p align="center"><img src="ReadmeFiles/ (4).png" alt=" (4)" width='50%' /></p>
<p align="center"><img src="ReadmeFiles/ (5).png" alt=" (5)" width='50%' /></p>
<p align="center"><img src="ReadmeFiles/ (6).png" alt=" (6)" width='50%' /></p>
<p align="center"><img src="ReadmeFiles/ (7).png" alt=" (7)" width='50%' /></p>
<p align="center"><img src="ReadmeFiles/ (8).png" alt=" (8)" width='50%' /></p>
<p align="center"><img src="ReadmeFiles/ (9).png" alt=" (9)" width='50%' /></p>
#### Mapa Interactivo:

El desarrollo del apartado mapa interactivo corresponde a un entorno de realidad aumentada que permita de una forma interactiva, visitar y observar el campus institucional. Sin embargo este proyecto no corresponde totalmente a nuestro equipo de trabajo, por lo tanto si los desarrolladores permiten en posteriores versiones presentaremos el link del repositorio en este apartado.