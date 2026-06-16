import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/core/constants/Theme.dart';
import 'package:flutter_course/core/routing/app_router.dart';
import 'package:flutter_course/firebase_options.dart';
import 'package:flutter_course/l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'BAM Wallet & Transfers',
      routerConfig: AppRouter.router,

      // ── Material 3 Theme ──
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: ArgonColors.primary,
          brightness: Brightness.light,
          primary: ArgonColors.primary,
          onPrimary: ArgonColors.white,
          secondary: ArgonColors.info,
          error: ArgonColors.error,
          surface: ArgonColors.bgColorScreen,
          onSurface: ArgonColors.text,
        ),
        scaffoldBackgroundColor: ArgonColors.bgColorScreen,
        fontFamily: 'OpenSans',
        appBarTheme: const AppBarTheme(
          backgroundColor: ArgonColors.white,
          foregroundColor: ArgonColors.text,
          elevation: 0,
          centerTitle: false,
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: ArgonColors.text,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: ArgonColors.white,
            backgroundColor: ArgonColors.primary,
            minimumSize: const Size(double.infinity, 52),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
            textStyle: const TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: ArgonColors.text,
            minimumSize: const Size(double.infinity, 52),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            side: const BorderSide(color: ArgonColors.border, width: 1.5),
            textStyle: const TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: ArgonColors.white,
          hintStyle: const TextStyle(color: ArgonColors.muted),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: ArgonColors.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: ArgonColors.primary, width: 1.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: ArgonColors.error),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: ArgonColors.error, width: 1.5),
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: ArgonColors.primary,
          unselectedItemColor: ArgonColors.muted,
          backgroundColor: ArgonColors.white,
          selectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          unselectedLabelStyle: TextStyle(fontSize: 12),
        ),
        dividerTheme: DividerThemeData(
          color: ArgonColors.border.withValues(alpha: 0.5),
          thickness: 1,
        ),
        switchTheme: SwitchThemeData(
          thumbColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return ArgonColors.primary;
            }
            return ArgonColors.muted;
          }),
          trackColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return ArgonColors.primary.withValues(alpha: 0.3);
            }
            return ArgonColors.border;
          }),
        ),
      ),

      // ── Localization ──
      supportedLocales: const [
        Locale('es', 'ES'),
        Locale('en', 'US'),
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
