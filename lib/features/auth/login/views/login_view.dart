import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_course/l10n/app_localizations.dart';

import 'package:flutter_course/core/constants/Theme.dart';
import 'package:flutter_course/core/widgets/input.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        LoginBodyWidget()
      ],)
    );
  }
}

class LoginBodyWidget extends StatefulWidget {
  const LoginBodyWidget({super.key});

  @override
  State<LoginBodyWidget> createState() => _LoginBodyWidgetState();
}

class _LoginBodyWidgetState extends State<LoginBodyWidget> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 200),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            AppLocalizations.of(context)!.loginWelcome,
            style: TextStyle(
              fontSize: 24,
              color: ArgonColors.text,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 24,),
          Input(
            placeholder: AppLocalizations.of(context)!.loginUsername,
            prefixIcon: Icon(Icons.supervised_user_circle),
          ),
          const SizedBox(height: 16,),
          Input(
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
          const SizedBox(height: 16,),
          GestureDetector(
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
          const SizedBox(height: 24,),
          ElevatedButton(
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
          const SizedBox(height: 2,),
          Text(
            AppLocalizations.of(context)!.loginQuote,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              color: Colors.blueGrey,
            ),
          ),
        ],
      )
    );
  }
}
