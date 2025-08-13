# cinemapedia

## DEV

1. Copiar el .env.template y renombrarlo como .env
2. Cambiar los valores de la variable de entorno (The movie DB).

## ISAR

El proyecto utiliza [Isar](https://isar.dev/es/tutorials/quickstart.html).

Cambios en la entidad, hay que ejecutar el comando `flutter pub run build_runner build` para generar el archivo de código.

Instalamos el paquete [path_provider](https://pub.dev/packages/path_provider/install) para usarlo con Isar.

si el proyecto tiene un error por el namespace de isar_flutter_libs, una solución es:

- En el archio android/build.gradle, agregar justo antes del primer subprojects:

```kts
subprojects {
    afterEvaluate {
        if (plugins.hasPlugin("com.android.library")) {
            extensions.configure<com.android.build.gradle.LibraryExtension>("android") {
                if (namespace == null) {
                    namespace = group.toString()
                }
            }
        }
    }
}
```

---

## PROD

### Cambiar el nombre de la aplicación

Instalamos el paquete [change_app_package_name](https://pub.dev/packages/change_app_package_name/install) para cambiar el nombre de la aplicación en modo desarrollo.

```bash
flutter pub add --dev change_app_package_name
```

Luego ejecutamos el comando:

```bash
flutter pub run change_app_package_name:main com.miempresaonombre.newname
```

---

### Cambiar icono de la aplicación

Instalamos el paquete [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons/install) para cambiar el icono de la aplicación en modo desarrollo.

```bash
flutter pub add --dev flutter_launcher_icons
```

Agregamos la configuración de flutter_launcher_icons en el archivo `pubspec.yaml`:

```yaml
flutter_launcher_icons:
  android: 'launcher_icon'
  ios: true
  image_path: 'assets/icon/icon.png'
  min_sdk_android: 21 # android min sdk min:16, default 21
```

Luego ejecutamos el comando:

```bash
flutter pub run flutter_launcher_icons
```

---

### Cambiar splash screen

Instalamos el paquete [flutter_native_splash](https://pub.dev/packages/flutter_native_splash/install) para cambiar el splash screen en modo desarrollo.

```bash
flutter pub add flutter_native_splash
```

Agregamos la configuración de flutter_native_splash en el archivo `pubspec.yaml`:

```yaml
flutter_native_splash:
  color: '#252829'
  image: 'assets/icon/icon.png'
```

Luego ejecutamos el comando:

```bash
flutter pub run flutter_native_splash:create
```
