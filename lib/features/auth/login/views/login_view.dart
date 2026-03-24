import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_course/l10n/app_localizations.dart';

import 'package:flutter_course/core/constants/Theme.dart';
// widgets
import 'package:flutter_course/core/widgets/input.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool _obscurePassword = true;

  final double height = window.physicalSize.height;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("lib/core/assets/img/register-bg.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 16,
                    left: 24.0,
                    right: 24.0,
                    bottom: 32,
                  ),
                  child: Card(
                    elevation: 5,
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.63,
                          color: Color.fromRGBO(244, 245, 247, 1),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 24.0,
                                      bottom: 24.0,
                                    ),
                                    child: Center(
                                      child: Text(
                                        AppLocalizations.of(context)!.loginWelcome,
                                        style: TextStyle(
                                          color: ArgonColors.text,
                                          fontWeight: FontWeight.w200,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Input(
                                          placeholder: AppLocalizations.of(context)!.loginUsername,
                                          prefixIcon: Icon(Icons.supervised_user_circle),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Input(
                                          placeholder: AppLocalizations.of(context)!.loginPassword,
                                          prefixIcon: Icon(Icons.lock),
                                          suffixIcon: IconButton(
                                            icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                                            onPressed: () {
                                              setState(() => _obscurePassword = !_obscurePassword);
                                            },
                                          ),
                                          obscureText: _obscurePassword,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(context, '/forgot-password');
                                          },
                                          child: Text(
                                            AppLocalizations.of(context)!.loginForgotPassword,
                                            style: TextStyle(
                                              color: ArgonColors.primary,
                                              fontSize: 11,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 16),
                                    child: Center(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushReplacementNamed(context, '/temporal-route');
                                        },
                                        style: ElevatedButton.styleFrom(
                                          foregroundColor: ArgonColors.white,
                                          backgroundColor: ArgonColors.primary,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(4.0),
                                          ),
                                          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 12, bottom: 12),
                                        ),
                                        child: Text(
                                          AppLocalizations.of(context)!.loginLogin,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 2),
                                    child: Center(
                                      child: Text(
                                        AppLocalizations.of(context)!.loginQuote,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.blueGrey,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
