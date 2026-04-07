// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get commonGoBack => 'Go back';

  @override
  String get commonWelcome => 'Welcome!';

  @override
  String get commonUsername => 'Username';

  @override
  String get commonEmail => 'Email';

  @override
  String get commonPassword => 'Password';

  @override
  String get commonForgotPassword => 'Forgot password?';

  @override
  String get commonLogin => 'Login';

  @override
  String get commonQuote =>
      'Press the Forgot password? link or the Login button to navigate within the app.';

  @override
  String get commonResetPassword => 'Reset Password';
}
