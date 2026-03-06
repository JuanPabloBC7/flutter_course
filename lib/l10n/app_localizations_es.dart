// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get loginWelcome => 'Bienvenido!';

  @override
  String get loginUsername => 'Usuario';

  @override
  String get loginPassword => 'Contraseña';

  @override
  String get loginForgotPassword => 'Olvidó su contraseña?';

  @override
  String get loginLogin => 'Iniciar Sesión';

  @override
  String get loginQuote =>
      'Presione el link de Olvidó su contraseña? o el botón de Iniciar Sesión, para navegar detro de la app.';

  @override
  String get commonGoBack => 'Regresar';
}
