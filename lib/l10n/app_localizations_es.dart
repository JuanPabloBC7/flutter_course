// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get welcome => 'Bienvenido!';

  @override
  String get email => 'Correo electrónico';

  @override
  String get password => 'Contraseña';

  @override
  String get forgotPassword => 'Olvido su contraseña?';

  @override
  String get login => 'Iniciar sesión';

  @override
  String get notMember => 'No eres miembro? ';

  @override
  String get registerNow => 'Registrate ahora';

  @override
  String get orContinueWith => 'O continue con';
}
