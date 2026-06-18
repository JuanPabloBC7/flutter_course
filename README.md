# flutter_course

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Documentation
### Important Documentation
- Official documentation of [dart](https://docs.flutter.dev/).
- Find dart dependencies in [pub.dev](https://pub.dev/).
- Test code with [Try Dart in your browser](https://dart.dev/#try-dart).
- Design your site with [Material components](https://docs.flutter.dev/ui/widgets/material).
- Types of [variables](https://dart.dev/language/variables).
- [Figma designs General](https://www.figma.com/community/mobile-apps?resource_type=mixed&editor_type=all&price=all&sort_by=all_time&creators=all) for project.
- [Figma designs 1]([https://www.figma.com/design/Gj5WThN6aqbaiew4eYZYnY/Fintech-Mobile-App-Update1.0--Community-?node-id=0-1&p=f&t=B17Pzikj4K4ClR27-0](https://www.figma.com/design/iwcJo6KyW1DcUgCuLJr7Yz/Mobile-Apps-%E2%80%93-Prototyping-Kit--Community-?node-id=101-306&p=f&t=FMw9fVgEsToPWS9N-0)) for project.
- [Figma designs 2](https://www.figma.com/design/Gj5WThN6aqbaiew4eYZYnY/Fintech-Mobile-App-Update1.0--Community-?node-id=0-1&p=f&t=B17Pzikj4K4ClR27-0) for project.

### Run Dart File
In this case the filename is "main.dart" you cand fin it in "./lib/main.dart". The command to run console is:

```
cd bin
dart <filename>.dart
```

### Run Project
To run project use:
```
flutter pub get
flutter run
```

### Run Project with launch.json file
To run project use: 
```
flutter run -t lib/main_dev.dart
```

or 

```
flutter run -t lib/main_prod.dart
```

### Shortcut commands
When the application is already running, you can use these letters to easy access commands.
```
r Hot reload. 🔥🔥🔥
R Hot restart.
h List all available interactive commands.
d Detach (terminate "flutter run" but leave application running).
c Clear the screen
q Quit (terminate the application on the device).
```

#### Commands
Use ```stl``` in code to create a new ```Flutter Stateless Widget``` easily.

### Command Line
- Use ```flutter run``` to execute.
- Use ```flutter pub get``` to execute and download dependencies.
- Use ```flutter clean``` to clean dependencies and "empty" the project.
- Use ```dart devtools``` to dev dependencies.
- Use ```flutter doctor -v``` for see what need to install, for execute, emulate, flutter version, dart version, etc. 
- Use ```open -a Simulator``` to iOS emulator or simulator.
- Need ```Homebrew``` installed for ```Cocoa pods```, see homebrew version with ```brew --version```.
- Use ```brew install cocoapods``` for handling swift iOS package, that is, iOS dependencies.
- Use ```pof init``` to init iOS project, that is, to create Podfile file, who is the manager of iOS dependencies.

### Project Structure
```
flutter_course/               | 
├── bin/                      | 
| └── examples/               | 
| | └── main/                 | 
│ | | └── interfaces/         | 
│ | |   └── models.dart       | (models for console functions)                
| | └── theory.dart           | (console functions)                           
| └── main.dart               | (console application)                         
├── android/                  | 
| └── app/                    | 
|   └── main/                 | 
│     └── AndroidManifest.xml | (Permissions file for Android)                
├── ios/                      | 
| └── Runner/                 | 
│   └── Info.plist            | (Permissions file for iOS)                    
├── lib/                      | 
│ └── main.dart               | (Is the main code file of the flutter project)
└── pubspec.yaml              | (Where u can find all dependencies installed) 
```

### Theory
#### Rules
**Files**
- Use ```snake_case``` to named files. Ex (repository_transfer.dart, usescase_validate_founds.dart).

**Variables**:
- Use ```camelCase``` to named variables or methods and be specific as you can. Ex (aviableBalance, calculateTaxes()).

**Classes**
- Use ```PascalCase``` to named files. Ex (RepositoryTransfer, UsesCaseValidateFounds).

**Constants**
- Use ```lowerCamelCase``` or ```SCREAMING_SNAKE_CASE``` to named constansts. Ex (aviableBalance, calculateTaxes, AVIABLE_BALANCE, CALCULATE_TATEX).

**Status**
- Use ```PascalCase``` or ```SCREAMING_SNAKE_CASE``` to named status. Ex [Success or Info: (TransferLoading, TransferSuccess, TransferFailure), Error: (INSUFFICIENT_FUNDS, ACCOUNT_BLOCKED, SERVICE_DOWN)].

#### Tips
To create a ```launch.json``` file, you need to go to debug option in VS Code, then press ```create a launch.json file```. If you can't see it, create it manually.

#### Variables and concepts
| Type    | Description                                                                            |
| ------- |:--------------------------------------------------------------------------------------:|
| final   | This variable used for execution time, that is, it consume RAM memory of the device.   |
| concept | This variable used for compilation time, that is, it consume ROM memory of the device. |

#### Project correctly structured in Flutter
```
flutter_course/
└─ lib/
  ├─ core/
  │ ├─ environments/
  │ ├─ errors/
  │ ├─ network/
  │ ├─ theme/
  │ │ └─ assets/
  │ │   ├─ images/
  │ │   │ ├─ branding/ 
  │ │   │ │ ├─ logo_primary.png
  │ │   │ │ └─ logo_white.png
  │ │   │ ├─ icons/
  │ │   │ │ ├─ transfer.png
  │ │   │ │ ├─ payment.png
  │ │   │ │ └─ card.png
  │ │   │ ├─ states/
  │ │   │ │ ├─ success.png
  │ │   │ │ ├─ error.png
  │ │   │ │ └─ warning.png
  │ │   │ └─ illustrations/
  │ │   ├─ animations/
  │ │   ├─ data/
  │ │   │ └─ banks.json
  │ │   └─ fonts/
  │ │     ├─ Inter-Regular.ttf
  │ │     ├─ Inter-Medium.ttf
  │ │     ├─ Inter-SemiBold.ttf
  │ │     └─ Inter-Bold.ttf
  │ ├─ routing/
  │ ├─ utils/
  │ └─ widgets/
  ├─ features/
  │ ├─ l10n/
  │ ├─ accounts/
  │ │ ├─ data/
  │ │ ├─ domain/
  │ │ └─ presentation/
  │ ├─ transfers/
  │ │ ├─ data/
  │ │ ├─ domain/
  │ │ └─ presentation/
  │ ├─ payments/
  │ │ ├─ data/
  │ │ ├─ domain/
  │ │ └─ presentation/
  │ ├─ auth/
  │ │ ├─ data/
  │ │ ├─ domain/
  │ │ └─ presentation/
  │ └─ client_profile/
  │   ├─ data/
  │   │ ├─ datasources/
  │   │ ├─ models/
  │   │ └─ repositories_impl/
  │   ├─ domain/
  │   │ ├─ entities/
  │   │ ├─ repositories/
  │   │ └─ usecases/
  │   └─ presentation/
  │     ├─ screens or views/
  │     ├─ widgets/
  │     └─ state/
  └─ main.dart
```

| Folder       | Description                                                                                                                                                              |
| ------------ |:------------------------------------------------------------------------------------------------------------------------------------------------------------------------:|
| core         | Contains that you share, like ```network (HTTP client, interceptors), global error handling, logging, routes, theme, utilities, shared components “really common”...```. |
| domain       | Contains rules and is stable.                                                                                                                                            |
| data         | Changes with APIs, providers and thecnical regulations.                                                                                                                  |
| presentation | UX, but it shouldn't touch on financial logic.                                                                                                                           |

---
---
# Project Statement
### Historias de Usuario y Entregables
#### HU 1.1 – Configuración profesional del proyecto
Como desarrollador, quiero configurar un proyecto Flutter con estándares profesionales para asegurar calidad y mantenibilidad desde el inicio.

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
Como desarrollador, quiero un cliente HTTP reutilizable para consumir APIs externas.

#### Entregables
* Cliente HTTP con interceptores
* Modelo de errores centralizado
