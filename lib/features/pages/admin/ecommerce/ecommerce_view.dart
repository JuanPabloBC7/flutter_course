import 'package:flutter/material.dart';
import 'package:flutter_course/core/constants/Theme.dart';

class EcommerceView extends StatelessWidget {
  const EcommerceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ArgonColors.bgColorScreen,
      appBar: AppBar(
        backgroundColor: ArgonColors.white,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          'E-Commerce',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: ArgonColors.text,
          ),
        ),
      ),
      body: const SizedBox.shrink(),
    );
  }
}
