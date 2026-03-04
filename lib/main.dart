import 'package:flutter/material.dart';
import 'package:flutter_course/core/environment/environment.dart';
import 'package:flutter_course/features/login/presentation/views/login_view.dart';
import 'package:flutter_course/l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void runProject() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Environment.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: const [Locale('es', 'ES'), Locale('en', 'US'),],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const LoginView(),
    );
  }
}
