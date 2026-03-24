import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_course/l10n/app_localizations.dart';

import 'package:flutter_course/core/constants/Theme.dart';
// widgets
import 'package:flutter_course/core/widgets/input.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  _ForgotPasswordViewState createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
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
                                        AppLocalizations.of(context)!.resetPassResetPassword,
                                        style: TextStyle(
                                          color: ArgonColors.text,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 38,
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
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 16),
                                    child: Column(
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.pushReplacementNamed(context, '/login');
                                          },
                                          style: ElevatedButton.styleFrom(
                                            foregroundColor: ArgonColors.white,
                                            backgroundColor: ArgonColors.primary,
                                            minimumSize: const Size(double.infinity, 50), 
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(4.0),
                                            ),
                                            padding: const EdgeInsets.symmetric(vertical: 12),
                                          ),
                                          child: Text(
                                            AppLocalizations.of(context)!.resetPassResetPassword,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16.0,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 12,),
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.pushReplacementNamed(context, '/login');
                                          },
                                          style: ElevatedButton.styleFrom(
                                            foregroundColor: ArgonColors.black,
                                            backgroundColor: ArgonColors.secondary,
                                            minimumSize: const Size(double.infinity, 50), 
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(4.0),
                                            ),
                                            padding: const EdgeInsets.symmetric(vertical: 12),
                                          ),
                                          child: Text(
                                            AppLocalizations.of(context)!.commonGoBack,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16.0,
                                            ),
                                          ),
                                        ),
                                      ]
                                    )
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
