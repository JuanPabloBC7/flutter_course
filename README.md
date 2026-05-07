# flutter_course
## Documentation
### Run Project
To run project use ```pub get``` to install dependencies and then ```run``` to execute main.dart file:
```
flutter pub get
flutter run
flutter clean
```

### Login authentication
DummyJSON: [DummyJSON - Auth](https://dummyjson.com/docs/auth)
Username: emilys
Password: emilyspass

## Sprints Delivery Videos
Here you will find the list of deliveries, sprint by sprint.
- [Content](https://github.com/JuanPabloBC7/flutter_course/tree/feature/transversal_project)
- [Sprint 1 - Proyecto integrador](https://drive.google.com/file/d/1YatGbW-SEUROhhDvGQt40QAryPF_YNx2/view?usp=drive_link)

## Project Structure
```
flutter_course/
└─ lib/
  ├─ core/
  │ ├─ assets/
  │ │ ├─ fonts/
  │ │ │ ├─ OpenSans-Bold.ttf
  │ │ │ ├─ OpenSans-Light.ttf
  │ │ │ └─ OpenSans-Regular.ttf
  │ │ └─ img/
  │ │   ├─ 2.0x/
  │ │   │ └─ images...
  │ │   └─ images...
  │ ├─ constants/
  │ │ └─ Theme.dart
  │ ├─ network/
  │ │ └─ services.dart
  │ ├─ routing/
  │ │ └─ routes.dart
  │ └─ widgets/
  │   └─ input.dart
  ├─ features/
  │ ├─ admin/
  │ │ ├─ layout/
  │ │ │ └─ layout_view.dart
  │ │ └─ pages/
  │ │   ├─ configuration/
  │ │   │ └─ configuration_view.dart
  │ │   ├─ dashboard/
  │ │   │ └─ dashboard_view.dart
  │ │   ├─ history/
  │ │   │ └─ history_view.dart
  │ │   └─ transfers/
  │ │     └─ transfers_view.dart
  │ └─ auth/
  │   ├─ forgot_password/
  │   │ └─ forgot_password_view.dart
  │   └─ login/
  │     └─ login_view.dart
  ├─ l10n/
  │ ├─ app_en.arb
  │ ├─ app_es.arb
  │ ├─ app_localizations_en.dart
  │ ├─ app_localizations_es.dart
  │ └─ app_localizations.dart
  └─ main.dart
```

# Project Statement
## Proyecto Transversal Flutter Avanzado
BAM (Bancolombia Guatemala)

### Contexto del proyecto
Este proyecto transversal acompaña todo el curso de **Flutter Avanzado** y simula el desarrollo de un **módulo real de una app bancaria de alto tráfico**, permitiendo a los estudiantes aplicar progresivamente los conocimientos de cada módulo en un entorno corporativo.

El proyecto se desarrolla de forma incremental, alineando **contenidos técnicos, arquitectura, buenas prácticas y calidad** con un caso realista del sector financiero.

### Nombre del proyecto
**BAM Wallet & Transfers – Módulo Bancario Escalable**

### Objetivo general
Diseñar e implementar un módulo funcional de una aplicación bancaria que incluya:
* Autenticación segura
* Visualización de productos y saldos
* Transferencias y pagos
* Historial y auditoría de transacciones
* Notificaciones push
* Internacionalización
* Integración con servicios backend
* Prácticas de calidad, testing, CI y uso de IA 

### Lineamientos generales
* Arquitectura limpia (Clean Architecture)
* Modularización por feature
* Manejo de estado profesional
* Enfoque en escalabilidad y alto tráfico
* Seguridad y manejo de errores
* Documentación técnica clara

### Resumen Backlog del Proyecto por Módulo
| Módulo | Historia de Usuario | Descripción                                    | Entregables                                       | Evidencia de Cumplimiento          |
| ------ |:-------------------:|:----------------------------------------------:|:-------------------------------------------------:|:----------------------------------:|
| 1      | HU 1.1              | Configuración profesional del proyecto Flutter | Repo inicial, README, lint y estructura base      | Repositorio Git + README           |
| 1      | HU 1.2              | Navegación base y pantallas iniciales          | Rutas y pantallas placeholder                     | App navegable                      |
| 1      | HU 1.3              | Cliente HTTP y manejo de errores               | Cliente HTTP + modelo de errores                  | Código + pruebas manuales          |
| 2      | HU 2.1              | Clean Architecture en Auth                     | Capas Domain / Data / UI                          | Estructura del feature ```auth```  |
| 2      | HU 2.2              | Login con validaciones                         | Login funcional con manejo de estados             | Demo funcional                     |
| 2      | HU 2.3              | Gestión de sesión                              | Guard de rutas + sesión persistente               | Navegación protegida               |
| 3      | HU 3.1              | Modularización por features                    | Estructura ```features/``` + doc de decisiones    | Documento técnico                  |
| 3      | HU 3.2              | Dashboard de productos                         | Dashboard con caché y manejo de estados           | UI funcional                       |
| 3      | HU 3.3              | Internacionalización                           | i18n ES / EN                                      | Cambio dinámico de idioma          |
| 4      | HU 4.1              | Firebase Authentication                        | Login real con Firebase                           | Usuario autenticado                |
| 4      | HU 4.2              | Historial Firestore                            | Transacciones paginadas                           | Consulta funcional                 |
| 4      | HU 4.3              | Push Notifications                             | Integración FCM                                   | Recepción de notificación          |
| 5      | HU 5.1              | Servicio Python                                | API / script de validación                        | Endpoint funcional                 |
| 6      | HU 6.1              | API Node.js / TypeScript                       | Endpoints de cuentas y transferencias             | Postman / OpenAPI                  |

---
---
## Detalle Backlog del Proyecto por Módulo
### Módulo 1 – Fundamentos Avanzados de Flutter y Dart

#### Objetivo del módulo
Construir la base técnica y estructural del proyecto con estándares corporativos.

#### Historias de Usuario y Entregables
#### HU 1.1 – Configuración profesional del proyecto
**Como desarrollador**, quiero configurar un proyecto Flutter con estándares profesionales para asegurar calidad y mantenibilidad desde el inicio.

#### Criterios de aceptación
* Proyecto Flutter inicializado correctamente
* Uso de Material 3
* Linter y formatter configurados
* Estructura base de carpetas definida

#### Entregables
* Repositorio inicial
* README con instrucciones de ejecución

#### HU 1.2 – Navegación base de la aplicación
Como usuario, quiero navegar entre las principales secciones de la app bancaria.

#### Entregables
* Sistema de navegación configurado
* Pantallas base:
    * Login
    * Dashboard
    * Transferencias
    * Historial
    * Configuración

#### HU 1.3 – Cliente HTTP y manejo de errores
**Como desarrollador**, quiero un cliente HTTP reutilizable para consumir APIs externas.

#### Entregables
* Cliente HTTP con interceptores
* Modelo de errores centralizado

---
### Módulo 2 – Clean Architecture y Manejo de Estado
#### Objetivo del módulo
Aplicar Clean Architecture y manejo de estado en el módulo de autenticación.

#### Historias de Usuario y Entregables
#### HU 2.1 – Arquitectura limpia para autenticación
**Como desarrollador**, quiero separar dominio, datos y presentación para desacoplar la lógica de negocio.

#### Entregables
* Capas Domain, Data y UI implementadas en el feature ```auth```
* Casos de uso de login y logout

#### HU 2.2 – Login con validaciones
**Como usuario**, quiero iniciar sesión de forma segura.

#### Criterios de aceptación
* Validaciones de email y contraseña
* Manejo de estados: loading, error y éxito

#### Entregables
* Pantalla de login funcional

#### HU 2.3 – Gestión de sesión y protección de rutas
**Como sistema**, quiero proteger las rutas privadas de la aplicación.

#### Entregables
* Guard de rutas
* Persistencia básica de sesión

---
### Módulo 3 – Modularización, UI avanzada e Internacionalización
#### Objetivo del módulo
Escalar el proyecto mediante modularización por features y UI adaptable.

#### Historias de Usuario y Entregables
#### HU 3.1 – Modularización por features
**Como desarrollador**, quiero separar la aplicación por funcionalidades para facilitar el trabajo
en equipo.

#### Entregables
* Estructura ```features/``` aplicada
* Documento de decisiones técnicas

#### HU 3.2 – Dashboard de productos y saldos
**Como usuario**, quiero visualizar mis productos financieros y saldos.

#### Entregables
* Dashboard con datos mock
* Estados de carga y error
* Cache local

#### HU 3.3 – Internacionalización
**Como usuario**, quiero usar la app en español o inglés.

#### Entregables
* Configuración i18n
* Selector de idioma

---
### Módulo 4 – Firebase y Notificaciones
#### Objetivo del módulo
Integrar servicios backend reales usando Firebase.

#### Historias de Usuario y Entregables
#### HU 4.1 – Autenticación con Firebase
**Como usuario**, quiero autenticarme usando Firebase Authentication.

#### Entregables
* Login funcional con Firebase
* Almacenamiento seguro de sesión

#### HU 4.2 – Historial de transacciones en Firestore
**Como usuario**, quiero consultar mi historial de transacciones.

#### Entregables
* Colección de transacciones
* Consultas paginadas

#### HU 4.3 – Notificaciones push
**Como usuario**, quiero recibir notificaciones sobre eventos importantes.

#### Entregables
* Integración con Firebase Cloud Messaging

---
### Módulo 5 – Integraciones con Python
#### Objetivo del módulo
Construir un servicio auxiliar para validaciones de negocio.
Historias de Usuario y Entregables

#### HU 5.1 – Servicio de validación en Python
**Como sistema**, quiero validar reglas de negocio antes de registrar transferencias.

#### Entregables
* Servicio REST en Python
* Documentación de uso

---
### Módulo 6 – Backend con Node.js y TypeScript
#### Objetivo del módulo
Desarrollar una API backend que consuma la app Flutter.
Historias de Usuario y Entregables

#### HU 6.1 – API de cuentas y transferencias
**Como aplicación móvil**, quiero consumir una API segura.

#### Entregables
* API en Node.js + TypeScript
* Endpoints documentados

#### HU 6.2 – Autenticación de la API
**Como sistema**, quiero proteger los endpoints con JWT.

#### Entregables
* Middleware de autenticación

---
### Módulo 7 – IA y Calidad de Software
#### Objetivo del módulo
Usar IA para mejorar productividad y calidad.

#### Historias de Usuario y Entregables
#### HU 7.1 – Refactor y pruebas con IA
**Como desarrollador**, quiero usar IA para refactorizar y crear pruebas.

#### Entregables
* Tests unitarios y de widgets
* Documento de prompts utilizados

---
### Módulo 8 – Entrega Final
#### Objetivo del módulo
Preparar una entrega corporativa completa.

#### Entregables finales
* Proyecto funcional end-to-end
* Documentación de arquitectura
* Diagrama de flujos
* Pipeline CI básico
* Video o demo funcional

---
### Resultado esperado
Al finalizar el curso, el estudiante habrá construido un módulo bancario profesional, alineado
con prácticas reales de desarrollo móvil en entornos financieros de alto tráfico.