# APLICACION PARA EL USUARIO SERVIDOR (quien oferta a los servicios publicados)

# Andrés Ruiz  - Luis Renteria

# INICIO DEL PROYECTO 
# Proyecto desarrolado en el framework Flutter y el lenguaje Dart
 * Version de flutter: 2.8.1 
 * Version de dart: 2.14.4
 - En caso de tener una versión distinta, configure Flutter version Manager (FVM) https://fvm.app/

# Arquitectura usuada : Clean Architecture

    |-lib
      |--src
         |--config/   
         |--core/   
         |--data
            |--local/
            |--repository/
            |--model/
         |--domain
            |--entities/
            |--repository/       
            |--usecase/
         |--presentation
            |--widgets/
            |--pages/
                |--authentication/
                |--complete_account/
                |--home
                    |--profile/
                    |--service_detail/
                    |--list_service/

# Paqueteria usada https://pub.dev/
- dartz:
# Localizador de dependencias
- get_it:
# para comparar las variables (por tipado)
- equatable
# Gestor de estados
- flutter_bloc:
# Imagenes locales (camara o galeria)
- image_picker:
# Almacenamiento local (cahe)
- shared_preferences:
# Conexión con la Api de firebase
- firebase_auth:
- cloud_firestore:
- firebase_storage:

# Input con formador de pin para codigos
- pin_code_fields
