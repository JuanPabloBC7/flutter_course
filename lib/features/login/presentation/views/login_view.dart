import 'package:flutter/material.dart';
import 'package:flutter_course/core/assets.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Image.asset(Assets.loginBackground),
        BodyWidget()
      ],)
    );
  }
}

class BodyWidget extends StatelessWidget {
  const BodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
          )
        ],
      )
    );
  }
}