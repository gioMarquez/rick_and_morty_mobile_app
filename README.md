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
