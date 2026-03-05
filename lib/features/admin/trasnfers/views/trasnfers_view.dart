import 'package:flutter/material.dart';

class TransfersView extends StatelessWidget {
  const TransfersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        TransfersBodyWidget()
      ],)
    );
  }
}

class TransfersBodyWidget extends StatelessWidget {
  const TransfersBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Hello world transfers view',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.normal,
            ),
          ),
        ]
      ),
    );
  }
}