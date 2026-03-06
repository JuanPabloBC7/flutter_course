import 'package:flutter/material.dart';
import 'package:flutter_course/features/admin/configuration/views/configuration_view.dart';
import 'package:flutter_course/features/admin/dashboard/views/dashboard_view.dart';
import 'package:flutter_course/features/admin/history/views/history_view.dart';
import 'package:flutter_course/features/admin/trasnfers/views/trasnfers_view.dart';
import 'package:flutter_course/features/auth/forgot_password/views/forgot_password_view.dart';
import 'package:flutter_course/features/auth/login/views/login_view.dart';

class TempViewWidget extends StatelessWidget {
  const TempViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All views'),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 24,),
          DashboardBodyWidget(),
          const SizedBox(height: 24,),
          TransfersBodyWidget(),
          const SizedBox(height: 24,),
          ConfigurationBodyWidget(),
          const SizedBox(height: 24,),
          HistoryBodyWidget(),
        ],
      )
    );
  }
}