# BAM Wallet
## Documentación Técnica
### 1. Descripción del Proyecto
**BAM Wallet** es una aplicación móvil desarrollada en Flutter que simula un módulo bancario para un entorno financiero. El proyecto sigue estándares de desarrollo corporativo y se construye de forma incremental a través de múltiples módulos, cubriendo autenticación, visualización de productos financieros, transferencias, historial de transacciones, internacionalización con traducciones utilizando l10n, por el momento, cuenta con constantes actualizaciones, por lo que el proyecto se sigue construyendo.

La aplicación está diseñada como un proyecto que aplica prácticas profesionales como Clean Architecture, manejo de estado con Riverpod, UI reactiva, integración con Firebase y soporte multilenguaje.

### 2. Objetivo
Diseñar e implementar un módulo bancario que incluya:
- Autenticación segura (Firebase Auth + DummyJSON API).
- Panel financiero con resúmenes de cuenta y estadísticas.
- Historial de transacciones.
- Internacionalización completa (EN/ES).
- Arquitectura profesional y estándares de calidad de código.

### 3. Arquitectura
El proyecto sigue los principios de **Clean Architecture** con una estructura modular organizada por features:

```
lib/
├── core/                          # Infraestructura compartida
│   ├── assets/                    # Fuentes, imágenes y recursos
│   ├── config/                    # Feature flags
│   ├── constants/                 # Colores del tema
│   ├── network/                   # Cliente API, excepciones, servicios
│   ├── providers/                 # Providers compartidos de Riverpod
│   ├── routing/                   # Configuración de GoRouter
│   ├── utils/                     # Validadores e íconos de categoría
│   └── widgets/                   # Widgets reutilizables
├── features/
│   ├── auth/                      # Autenticación (Clean Architecture)
│   │   ├── data/                  # Data sources + Implementación del repositorio
│   │   ├── domain/                # Entidades, Casos de Uso, Contrato del repositorio
│   │   └── presentation/          # Providers + Estado (Freezed)
│   ├── layouts/                   # Layout administrativo con navegación inferior (menú bottombar)
│   └── pages/                     # Pantallas por feature
│       ├── admin/                 # Dashboard, Transferencias, Historial, Config, Perfil, E-commerce
│       ├── auth/                  # Login, Olvidé mi Contraseña
│       └── core/                  # Splash, Onboarding
└── l10n/                          # Archivos de localización (EN/ES)
```

### 4. Dependencias
| Paquete | Propósito |
|---------|-----------|
| `flutter_riverpod` | Manejo de estado reactivo |
| `go_router` | Navegación declarativa con guards |
| `dio` | Cliente HTTP con interceptores |
| `freezed_annotation` | Clases de datos inmutables y uniones sealed |
| `json_annotation` | Serialización JSON |
| `shared_preferences` | Almacenamiento local persistente |
| `firebase_core` | Inicialización de Firebase |
| `firebase_auth` | Autenticación con email/contraseña |
| `cloud_firestore` | Base de datos NoSQL para productos |
| `flutter_localizations` | Soporte i18n |
| `intl` | Formato de fechas/números |
| `font_awesome_flutter` | Librería de íconos |
| `url_launcher` | Manejo de URLs externas |
| `cupertino_icons` | Íconos estilo iOS |
| `flutter_lints` | Reglas de calidad de código |
| `build_runner` | Ejecutor de generación de código |
| `freezed` | Generación de código para clases Freezed |
| `flutter_launcher_icons` | Generación del ícono de la app |

### 5. Ejecución del Proyecto
```bash
# Instalar dependencias
flutter pub get

# Generar código Freezed/JSON
dart run build_runner build --delete-conflicting-outputs

# Generar archivos l10n
flutter gen-l10n

# Ejecutar la app
flutter run
```
Para iniciar sesión, se pueden utilizar las siguientes credenciales, tomar en cuenta la feature flag que este activa `lib/core/config/feature_flags.dart`:

| Proveedor | Email/Usuario | Contraseña |
|-----------|--------------|------------|
| Firebase | `juan.balan@bam.com.gt` | `prueba123` |
| DummyJSON | `emilys` | `emilyspass` |
| Mock Local | (cualquiera) | (cualquiera) |

### 6. Conclusiones
Este proyecto demuestra una arquitectura de aplicación Flutter de grado profesional orientado al sector financiero:

1. **Clean Architecture** aplicada consistentemente con clara separación de capas.
2. **Manejo de Estado Reactivo** con Riverpod se elimina el uso manual de setState para flujos de datos.
3. **Navegación Type-safe** con GoRouter y guards de redirección previene acceso no autorizado.
4. **l10n Completo** traducción de EN/ES.
5. **Integración Firebase** proporciona autenticación y base de datos reales
6. **Librería de Componentes Reutilizables** con widgets para asegurar la consistencia de UI/UX.

### 7. Entregas
Sigue el siguiente link para ver las entregas por sprint de este proyecto, [click aquí](https://github.com/JuanPabloBC7/flutter_course/blob/feature/transversal_project/R-DELIVERIES.md)