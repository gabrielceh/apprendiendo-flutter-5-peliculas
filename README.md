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
