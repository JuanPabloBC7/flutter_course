# BAM Wallet
## Documentación Técnica
### 1. Descripción del Proyecto
**BAM Wallet** es una aplicación móvil desarrollada en Flutter que simula un módulo bancario para un entorno financiero. El proyecto sigue estándares de desarrollo corporativo y se construye de forma incremental a través de múltiples módulos, cubriendo autenticación, visualización de productos financieros, transferencias, historial de transacciones, e-commerce con carrito de compras, notificaciones push y locales, sistema de roles, e internacionalización.

La aplicación está diseñada como un proyecto que aplica prácticas profesionales como Clean Architecture, manejo de estado con Riverpod, UI reactiva, integración con Firebase (Auth, Firestore, Cloud Messaging) y soporte multilenguaje.

### 2. Objetivo
Diseñar e implementar un módulo bancario que incluya:
- Autenticación segura (Firebase Auth + DummyJSON API).
- Almacenamiento seguro de sesión (flutter_secure_storage).
- Panel financiero con resúmenes de cuenta, estadísticas y cache local.
- Historial de transacciones con consultas paginadas desde Firestore.
- Formulario de transferencias con guardado en Firestore.
- E-commerce con carrito, favoritos, edición de productos (admin) y checkout con órdenes.
- Notificaciones push (Firebase Cloud Messaging) + notificaciones locales.
- Sistema de roles (admin/user) con permisos diferenciados.
- Notificaciones in-app en tiempo real con Firestore Streams.
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
│   ├── providers/                 # Providers compartidos (locale, role, user, services)
│   ├── routing/                   # Configuración de GoRouter con guards
│   ├── services/                  # Servicios de notificaciones (local, push, order stream)
│   ├── utils/                     # Validadores e íconos de categoría
│   └── widgets/                   # Widgets reutilizables (TopNotification, ProductCard, etc.)
├── features/
│   ├── auth/                      # Autenticación (Clean Architecture)
│   │   ├── data/                  # Data sources (remote, local, firebase) + repositorio
│   │   ├── domain/                # Entidades, Casos de Uso, Contrato del repositorio
│   │   └── presentation/          # Providers + Estado (Freezed)
│   ├── layouts/                   # Layout administrativo con navegación inferior
│   └── pages/                     # Pantallas por feature
│       ├── admin/
│       │   ├── configuration/     # Configuración de la app
│       │   ├── dashboard/         # Dashboard con cache local (SharedPreferences)
│       │   ├── ecommerce/         # E-commerce con Firestore
│       │   │   ├── providers/     # Cart, favorites, ecommerce providers
│       │   │   ├── services/      # ProductFirestoreService
│       │   │   └── views/         # Cart, Favorites, Edit Products
│       │   ├── history/           # Historial paginado desde Firestore
│       │   │   ├── providers/     # HistoryNotifier con paginación
│       │   │   └── services/      # TransactionFirestoreService
│       │   ├── product_detail/    # Detalle de producto con add-to-cart
│       │   ├── profile/           # Perfil de usuario
│       │   └── trasnfers/         # Transferencias con formulario Firestore
│       ├── auth/                  # Login, Olvidé mi Contraseña
│       └── core/                  # Splash, Onboarding
└── l10n/                          # Archivos de localización (EN/ES)
```

### 4. Colecciones Firestore
| Colección | Campos principales | Uso |
|-----------|-------------------|-----|
| `users` | userId, role, displayName | Roles y permisos (admin/user) |
| `accounts` | name, type, balance, currency | Cuentas financieras del usuario |
| `transactions` | accountId, title, amount, type, category, date | Historial de transacciones |
| `products` | name, price, imageUrl, category | Productos del e-commerce |
| `orders` | userId, items[], total, status, date | Órdenes de compra del carrito |

### 5. Dependencias
| Paquete | Propósito |
|---------|-----------|
| `flutter_riverpod` | Manejo de estado reactivo |
| `go_router` | Navegación declarativa con guards |
| `dio` | Cliente HTTP con interceptores |
| `freezed_annotation` | Clases de datos inmutables y uniones sealed |
| `json_annotation` | Serialización JSON |
| `shared_preferences` | Cache local (dashboard, locale) |
| `flutter_secure_storage` | Almacenamiento seguro de tokens (Keychain/EncryptedSharedPreferences) |
| `firebase_core` | Inicialización de Firebase |
| `firebase_auth` | Autenticación con email/contraseña |
| `cloud_firestore` | Base de datos NoSQL (transacciones, productos, órdenes, usuarios) |
| `firebase_messaging` | Push notifications con Firebase Cloud Messaging |
| `flutter_local_notifications` | Notificaciones locales del sistema |
| `flutter_localizations` | Soporte i18n |
| `intl` | Formato de fechas/números |
| `font_awesome_flutter` | Librería de íconos |
| `url_launcher` | Manejo de URLs externas |
| `cupertino_icons` | Íconos estilo iOS |
| `flutter_lints` | Reglas de calidad de código |
| `build_runner` | Ejecutor de generación de código |
| `freezed` | Generación de código para clases Freezed |
| `flutter_launcher_icons` | Generación del ícono de la app |

### 6. Sistema de Roles
| Rol | Permisos |
|-----|----------|
| `admin` | Acceso total: ve todas las órdenes, edita productos, recibe notificaciones de todos los usuarios |
| `user` | Acceso a sus propios datos: transacciones, órdenes, favoritos, carrito |

Los roles se almacenan en la colección `users` de Firestore y se consultan via `userRoleProvider`.

### 7. Notificaciones
| Tipo | Implementación | Cuándo se dispara |
|------|----------------|-------------------|
| **In-app (TopNotification)** | Overlay widget en la parte superior | Acciones de UI (add to cart, transfer, errors) |
| **Firestore Streams** | `OrderNotificationService` | Nueva orden detectada en tiempo real |
| **Local notification** | `flutter_local_notifications` | Checkout completado |
| **Push notification (FCM)** | `firebase_messaging` | Enviada manualmente desde Firebase Console |

### 8. Ejecución del Proyecto
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

| Proveedor | Email/Usuario | Contraseña | Rol |
|-----------|--------------|------------|-----|
| Firebase | `juan.balan@bam.com.gt` | `prueba123` | admin |
| Firebase | `juanpablobc7@gmail.com` | `prueba123` | user |
| DummyJSON | `emilys` | `emilyspass` | — |
| Mock Local | (cualquiera) | (cualquiera) | — |

### 9. Conclusiones
Este proyecto demuestra una arquitectura de aplicación Flutter de grado profesional orientado al sector financiero:

1. **Clean Architecture** aplicada consistentemente con clara separación de capas.
2. **Manejo de Estado Reactivo** con Riverpod elimina el uso manual de setState para flujos de datos.
3. **Navegación Type-safe** con GoRouter y guards de redirección previene acceso no autorizado.
4. **l10n Completo** traducción EN/ES con selector dinámico persistente.
5. **Integración Firebase** proporciona autenticación, base de datos real, y push notifications.
6. **Sistema de Roles** diferencia permisos entre admin y user.
7. **E-commerce Completo** con carrito, favoritos, checkout y órdenes en Firestore.
8. **Notificaciones Multicapa** (in-app, local, push, streams en tiempo real).
9. **Almacenamiento Seguro** de sesión con flutter_secure_storage.
10. **Paginación Cursor-based** para historial de transacciones desde Firestore.
11. **Librería de Componentes Reutilizables** con widgets para asegurar la consistencia de UI/UX.

### 10. Entregas
Sigue el siguiente link para ver las entregas por sprint de este proyecto, [click aquí](https://github.com/JuanPabloBC7/flutter_course/blob/feature/transversal_project/R-DELIVERIES.md)
