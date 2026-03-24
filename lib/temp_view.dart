import 'package:flutter/material.dart';
import 'package:flutter_course/features/admin/pages/configuration/configuration_view.dart';
import 'package:flutter_course/features/admin/pages/dashboard/dashboard_view.dart';
import 'package:flutter_course/features/admin/pages/history/history_view.dart';
import 'package:flutter_course/features/admin/pages/trasnfers/trasnfers_view.dart';

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
          DashboardView(),
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