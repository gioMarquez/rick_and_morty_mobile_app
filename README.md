# Rick and Morty Mobile App

## Getting Started

Para levantar este proyecto Flutter debes tener instalado Flutter SDK, Dart y un editor como VS Code o Android Studio.
Primero clona el repositorio y entra en la carpeta del proyecto.
Después ejecuta el comando flutter pub get para descargar todas las dependencias.
Asegúrate de tener un emulador corriendo o un dispositivo físico conectado.
Ejecuta flutter devices para verificar que Flutter lo reconoce.
Finalmente inicia la aplicación con flutter run.

Si tienes problemas de conexión a la API, revisa que en el archivo AndroidManifest.xml dentro de android/app/src/main/ tengas agregada la línea <uses-permission android:name="android.permission.INTERNET"/>.

Para ejecutar pruebas, usa el comando flutter test.

Estructura sugerida del proyecto:
lib/ con las carpetas models, pages, widgets y el archivo main.dart.

Las dependencias principales del proyecto son http para consumir la API y cupertino_icons para íconos.

Con estos pasos el proyecto debería levantarse correctamente desde cualquier entorno con Flutter configurado.

### Proceso de desarrollo
Consistió en estructurar la aplicación siguiendo una separación clara entre presentación, lógica y consumo de datos. Definí un modelo Character para mapear la información obtenida de la API de Rick and Morty, y creé un servicio dedicado para gestionar las peticiones HTTP, incluyendo paginación, búsqueda por nombre y filtrado por estado.

En la interfaz, utilicé widgets reutilizables como CharacterCard y organicé la pantalla principal con scroll infinito controlado mediante un ScrollController. Para optimizar el rendimiento y evitar llamadas excesivas al servidor, implementé un sistema de debounce en la barra de búsqueda. También diseñé una pantalla de detalle que muestra la información completa del personaje junto con los episodios en una disposición responsiva mediante Wrap.

Las principales decisiones técnicas se basaron en mantener un código escalable, fácil de mantener y con una experiencia de usuario fluida, aprovechando los principios de simplicidad y modularidad.
