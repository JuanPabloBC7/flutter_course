// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get welcome => 'Welcome!';

  @override
  String get email => 'Email address';

  @override
  String get password => 'Password';

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get login => 'Login';

  @override
  String get notMember => 'Not a member? ';

  @override
  String get registerNow => 'Register now';

  @override
  String get orContinueWith => 'Or continue with';
}
