import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/core/assets.dart';
import 'package:flutter_course/features/login/presentation/widgets/social_media_widget.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        Image.asset(Assets.loginBackground),
        // Image.asset(
        //   Assets.loginBackground,
        //   height: 500,
        //   fit: BoxFit.cover,
        //   alignment: Alignment.center,
        // ),
        BodyWidget()
      ],)
    );
  }
}

class BodyWidget extends StatelessWidget {
  const BodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final TapGestureRecognizer tapGestureRecognizer = TapGestureRecognizer();
    tapGestureRecognizer.onTap = () {
      print('Go to registration page.');
    };

    return Container(
      decoration: BoxDecoration(color: Colors.white),
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Welcome!',
            style: TextStyle(
              fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24,),
          TextField(
            decoration: InputDecoration(
              hintText: 'Email Address',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16,),
          TextField(
            decoration: InputDecoration(
              hintText: 'Password',
              border: OutlineInputBorder(),
              suffixIcon: Icon(Icons.visibility_off)
            ),
            obscureText: true,
          ),
          const SizedBox(height: 16,),
          Text(
            'Forgot password?',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Color(0xFF006FFD)
            ),
          ),
          const SizedBox(height: 24,),
          ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Color(0xFF006FFD))
            ),
            child: Text('Login', style: TextStyle(color: Colors.white),),
          ),
          const SizedBox(height: 16,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Not a member? '),
              InkWell(
                onTap: () {
                  print('Go to registration page.');
                },
                child: Text(
                  'Register now',
                  style: TextStyle(
                    color: Color(0xFF006FFD),
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ],
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: 'Not a member? ',
              style: TextStyle(color: Colors.black, fontSize: 14),
              children: [
                TextSpan(
                  text: 'Register now',
                  recognizer: tapGestureRecognizer,
                  // recognizer: TapGestureRecognizer()..onTap = () {
                  //   print('Go to registration page.');
                  // },
                  style: TextStyle(
                    color: Color(0xFF006FFD),
                    fontSize: 14
                  ),
                )
              ]
            )
          ),
          Text.rich(
            textAlign: TextAlign.center,
            TextSpan(
              text: 'Not a member? ',
              style: TextStyle(color: Colors.black, fontSize: 14),
              children: [
                TextSpan(
                  text: 'Register now',
                  recognizer: tapGestureRecognizer,
                  // recognizer: TapGestureRecognizer()..onTap = () {
                  //   print('Go to registration page.');
                  // },
                  style: TextStyle(
                    color: Color(0xFF006FFD),
                    fontSize: 14
                  ),
                )
              ]
            )
          ),
          const SizedBox(height: 24,),
          Divider(),
          Text('Or continue with', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey, fontSize: 14)),
          const SizedBox(height: 24,),
          SocialMediaRow()
        ],
      )
    );
  }
}

class SocialMediaRow extends StatelessWidget {
  const SocialMediaRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SocialMediaWidget(lColor: Colors.red, lImage: Assets.googleIcon),
        SizedBox(width: 12,),
        SocialMediaWidget(lColor: Colors.black, lImage: Assets.appleIcon),
        SizedBox(width: 12,),
        SocialMediaWidget(lColor: Color(0xFF006FFD), lImage: Assets.facebookIcon),
        // SocialMediaWidget.google(),
        // SizedBox(width: 12,),
        // SocialMediaWidget.apple(),
        // SizedBox(width: 12,),
        // SocialMediaWidget.facebook(),
      ]
    );
  }
}