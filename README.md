# Tec-MAS Flutter

**Sistema informativo de comunicación y difusión para la comunidad del TecNM/ITM**

*Seguimos trabajando en el nombre*

------

### ¿Qué es Tec-Mas?

Tec-MAS pretende ser un medio de comunicación y difusión de información entre la institución educativa TecNM/ITM y su comunidad Institucional, permitiendo ofrecer la información importante y de relevancia académica de la forma mas oportuna y rápida posible.

------

### Notas del Desarrollador:

La presente versión incorpora las siguientes funciones:

- Permite visualizar todos los artículos dados de alta en la plataforma de wordpress de forma "paginada"

- Se incorpora un lector pdf para el calendario, ya no es simplemente un webview a una vista de google docs.

- Es posible visualizar los artículos y navegar entre hipervínculos (a excepción de aquellos que requieren abrir una nueva pestaña, esos no están permitidos por flutter hasta el momento).

  Funciones incorporadas y cambios en esta versión:

  * Se ha modificado el sistema de navegación de la aplicación, visualmente no hay cambios relevantes pero internamente todo esta manejado por un pageview.
  * Aunado a lo anterior se incorpora persistencia entre las vistas de la aplicación, es decir, las vistas dependientes de internet solo cargarán una sola vez (al ser invocadas) y permanecerán estáticas en contenido a menos que el usuario refresque el contenido, esto evita realizar peticiones innecesarias al servidor.
  * Se ha incorporado una base de datos SQLite para almacenar los datos pedidos al servidor. Esto permite, en caso de no poseer conexión a internet, cargar los últimos resultados guardados en memoria (para hacer mas practica la aplicación).
  * Anudado a lo anterior se incorpora la funcionalidad de guardar los artículos de relevancia para los usuarios en el dispositivo y visualizarlos en el apartado correspondiente.
  * Se incorpora una nueva forma de gestionar los estilos de la aplicación.
  * El resto de los cambios involucran cambios y optimización de funciones y procesos.

**Desde el lado del servidor:**

Por el momento se siguen utilizando los plugins de lado de servidor:

- ```
  Wordpress Rest API v2 (Viene incorporado con wordpress)
  ```

- ```
  Better REST API Featured Images
  ```

Las peticiones se siguen procesando en formato JSON.

A su vez incorpora ya un sistema de seguridad en el backend, esto utilizando el plugin:

- ```
  WordPress REST API Authentication
  ```

Por ende las solicitudes a la api de wordpress han sido bloqueadas a menos que se envié junto con la petición http las credenciales correspondientes.

[![Captura](https://github.com/AmbrocioIsaias2808/Tec-MAS-Flutter/raw/master/ReadmeFiles/Captura.PNG)](https://github.com/AmbrocioIsaias2808/Tec-MAS-Flutter/blob/master/ReadmeFiles/Captura.PNG)

Además se incorpora el servicio de notificaciones de OneSignal, sin embargo tenemos ciertos bugs o contratiempos:

- El servicio incorporado intenta abrir el navegador predefinido del equipo, comportamiento que deseamos modificar para que abra la aplicación y muestre el contenido del post en la misma. Este comportamiento no se a podido incorporar hasta el momento debido a:
  - No hemos encontrado hasta el momento una forma de reabrir la aplicación en caso de estar cerrada. En caso de estar abierta los test demuestran que seria posible incorporar el comportamiento, sin embargo no es lo que se desea.

Por lo pronto las notificaciones son recibidas pero al intentar abrirlas solo se eliminan del panel de notificaciones.

**Cosas por hacer:**

- Mejorar el diseño (se, no me sigue gustando).
- Ajustar ciertos detalles en la sección de transporte (en funcionamiento interno, en cuanto a datos guardados en el cache).
- Resolver un pequeño bug en la vista del calendario (corregir el disparo de una excepción) <- (Probablemente no se corrija, no implica problemas de funcionamiento, pero veremos).
- Agregar un apartado de **Acerca de** 
- Agregar estilos y funcionalidades al apartado del Visor de articulos.
- Pues ver el tema de las notificaciones y deep links.
- Si es posible, cambiar la pantalla de carga ("Splash Screen") de los dispositivos.

**Resuelto pero en revisión:**

- NA

*Cosas por hacer de forma personal:*

De la rama TecMAS-19-11-18-(Lector-de-Articulos) a las anteriores necesito agregar comentarios de cambios por versión.

**Capturas de Pantalla:**

<p align="center"><img src="ReadmeFiles/ (1).png" width="50%" /></p>
<br>
<p align="center"><img src="ReadmeFiles/ (2).png" width="50%" /></p>
<br>
<p align="center"><img src="ReadmeFiles/ (3).png" width="50%" /></p>
<br>
<p align="center"><img src="ReadmeFiles/ (4).png" width="50%" /></p>
<br>
<p align="center"><img src="ReadmeFiles/ (5).png" width="50%" /></p>
<br>
<p align="center"><img src="ReadmeFiles/ (6).png" width="50%" /></p>
<br>
<p align="center"><img src="ReadmeFiles/ (7).png" width="50%" /></p>
<br>
<p align="center"><img src="ReadmeFiles/ (8).png" width="50%" /></p>
<br>
<p align="center"><img src="ReadmeFiles/ (9).png" width="50%" /></p>
<br>
<p align="center"><img src="ReadmeFiles/ (10).png" width="50%" /></p>
<br>
<p align="center"><img src="ReadmeFiles/ (11).png" width="50%" /></p>
<br>
<p align="center"><img src="ReadmeFiles/ (12).png" width="50%" /></p>
<br>
<p align="center"><img src="ReadmeFiles/ (13).png" width="50%" /></p>
<br>
<p align="center"><img src="ReadmeFiles/ (14).png" width="50%" /></p>
<br>
<p align="center"><img src="ReadmeFiles/ (15).png" width="50%" /></p>
<br>
<p align="center"><img src="ReadmeFiles/ (16).png" width="50%" /></p>
<br>
<p align="center"><img src="ReadmeFiles/ (17).png" width="50%" /></p>
<br>

**APK liberado:**

<a href="https://raw.githubusercontent.com/AmbrocioIsaias2808/Tec-MAS-Flutter/TecMAS-19.12.16-(BugFix-SavedArticles)/ReadmeFiles/19.12.17.apk" target="_blank">Descargar aquí</a>

### Mapa Interactivo:

El desarrollo del apartado mapa interactivo corresponde a un entorno de realidad aumentada que permita de una forma interactiva, visitar y observar el campus institucional. Sin embargo este proyecto no corresponde totalmente a nuestro equipo de trabajo, por lo tanto si los desarrolladores permiten en posteriores versiones presentaremos el link del repositorio en este apartado.



**Repositorios Relacionados:** 

<ul><li><a href="https://github.com/AmbrocioIsaias2808/Tec-MAS" target="_blank" >TecMAS</a></li></ul>