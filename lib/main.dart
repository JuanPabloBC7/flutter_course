import 'package:flutter/material.dart';
// import 'package:flutter_course/core/routing/routes.dart';
// import 'package:flutter_course/features/auth/login/views/login_view.dart';
import 'package:flutter_course/l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// screens
import 'package:flutter_course/features/views/onboarding.dart';
import 'package:flutter_course/features/views/pro.dart';
import 'package:flutter_course/features/views/home.dart';
import 'package:flutter_course/features/views/profile.dart';
import 'package:flutter_course/features/views/register.dart';
import 'package:flutter_course/features/views/articles.dart';
import 'package:flutter_course/features/views/elements.dart';

void main() {
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
      title: 'Argon PRO Flutter',
      theme: ThemeData(fontFamily: 'OpenSans'),
      initialRoute: "/onboarding",
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        "/onboarding": (BuildContext context) => new Onboarding(),
        "/home": (BuildContext context) => new Home(),
        "/profile": (BuildContext context) => new Profile(),
        "/articles": (BuildContext context) => new Articles(),
        "/elements": (BuildContext context) => new Elements(),
        "/account": (BuildContext context) => new Register(),
        "/pro": (BuildContext context) => new Pro(),
      }
    );
  }
}
