import 'package:flutter/material.dart';
import 'package:flutter_course/l10n/app_localizations.dart';

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
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24,),
          TextField(
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.loginUsername,
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16,),
          TextField(
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.loginPassword,
              border: OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                onPressed: () {
                  setState(() => _obscurePassword = !_obscurePassword);
                },
              ),
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
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color(0xFF006FFD)
              ),
            ),
          ),
          const SizedBox(height: 24,),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/temporal-route');
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Color(0xFF006FFD))
            ),
            child: Text(AppLocalizations.of(context)!.loginLogin, style: TextStyle(color: Colors.white),),
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
