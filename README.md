# Tec-MAS Flutter

**Sistema informativo de comunicación y difusión para la comunidad del TecNM/ITM**

*Seguimos trabajando en el nombre*

------

### ¿Qué es Tec-Mas?

Tec-MAS pretende ser un medio de comunicación y difusión de información entre la institución educativa TecNM/ITM y su comunidad Institucional, permitiendo ofrecer la información importante y de relevancia académica de la forma mas oportuna y rápida posible.

------

### Notas del Desarrollador:

La presente versión incorpora las siguientes funciones:

La presente versión a comparación de la anterior 20.01.05 trae ciertos cambios:

* Se han corregido bugs y errores en los apartados de noticias relevantes a la carga de datos y peticiones al servidor.
* Ahora los apartados importantes de la aplicación inician todas las peticiones al servidor en segundo plano al iniciar el aplicativo, esto mejora la fluides al navegar por el aplicativo.
* Se ha modificado por ende el sistema de navegación, los apartados de noticias pueden ser accedidos al desplazar con el dedo hacia la izquierda.

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

Por ende las solicitudes a la api de wordpress han sido bloqueadas a menos que se envié junto con la petición http las credenciales correspondientes:
<p align="center"><img src="ReadmeFiles\captura.png" alt=" (1)"/></p>
Además se incorpora el servicio de notificaciones de OneSignal, sin embargo tenemos ciertos bugs o contratiempos:

* En cuanto a este servicio los anteriores problemas han sido corregidos, sin embargo queda solo un ligero dilema mas que problema, se necesita enviar una notificaciòn programada ante la primera apertura de la aplicaciòn para configurar correctamente la apertura de las notificaciones desde la aplicaciòn.

**Cosas por hacer:**

- En la vista de calendario estoy conciente que es probable que surjan errores en dispositivos IOS, es asì que entraria en tela de revisiòn ese aspecto.
- Posiblemente ver la revisiòn del splash screen para dispositivos IOS.
- Checar la integración del mapa interactivo, las anteriores pruebas han seguido siendo sin éxito total, puedo poner que están al 88% de ser fructíferas pero se necesitan verificar detalles aún.
- Posiblemente ver la forma de mejorar el apartado de transporte, seria interesante poder poner mapas tipo google maps.

**Resuelto pero en revisión:**

- NA

*Cosas por hacer de forma personal:*

De la rama TecMAS-19-11-18-(Lector-de-Articulos) a las anteriores necesito agregar comentarios de cambios por versión.

**Capturas de Pantalla:**

<p align="center"><img src="ReadmeFiles\ (1).png" alt=" (1)" width="50%" /></p>
<p align="center"><img src="ReadmeFiles\ (2).png" alt=" (1)" width="50%"class="" /></p>
<p align="center"><img src="ReadmeFiles\ (3).png" alt=" (1)" width="50%"class="" /></p>
<p align="center"><img src="ReadmeFiles\ (4).png" alt=" (1)" width="50%"class="" /></p>
<p align="center"><img src="ReadmeFiles\ (5).png" alt=" (1)" width="50%"class="" /></p>
<p align="center"><img src="ReadmeFiles\ (6).png" alt=" (1)" width="50%" class="" /></p>
<p align="center"><img src="ReadmeFiles\ (7).png" alt=" (1)" width="50%" class="" /></p>
<p align="center"><img src="ReadmeFiles\ (8).png" alt=" (1)" width="50%" class="" /></p>
<p align="center"><img src="ReadmeFiles\ (9).png" alt=" (1)" width="50%" class="" /></p>
<p align="center"><img src="ReadmeFiles\ (10).png" alt=" (1)" width="50%"class="" /></p>
<p align="center"><img src="ReadmeFiles\ (11).png" alt=" (1)" width="50%"class="" /></p>
<p align="center"><img src="ReadmeFiles\ (12).png" alt=" (1)" width="50%"class="" /></p>
<p align="center"><img src="ReadmeFiles\ (13).png" alt=" (1)" width="50%" class="" /></p>
<p align="center"><img src="ReadmeFiles\ (14).png" alt=" (1)" width="50%"class="" /></p>
<p align="center"><img src="ReadmeFiles\ (15).png" alt=" (1)" width="50%"class="" /></p>
<p align="center"><img src="ReadmeFiles\ (16).png" alt=" (1)" width="50%"class="" /></p>
**APK liberado:**

<a href="https://raw.githubusercontent.com/AmbrocioIsaias2808/Tec-MAS-Flutter/TecMAS-20.01.03.02-(PDFViewerAndOpt)/ReadmeFiles/S-20.01.05-fix%20(2).apk" target="_blank">Descargar aquí</a>

### Mapa Interactivo:

El desarrollo del apartado mapa interactivo corresponde a un entorno de realidad aumentada que permita de una forma interactiva, visitar y observar el campus institucional. Sin embargo este proyecto no corresponde totalmente a nuestro equipo de trabajo, por lo tanto si los desarrolladores permiten en posteriores versiones presentaremos el link del repositorio en este apartado.



**Repositorios Relacionados:** 

<ul><li><a href="https://github.com/AmbrocioIsaias2808/Tec-MAS" target="_blank" >TecMAS</a></li></ul>
