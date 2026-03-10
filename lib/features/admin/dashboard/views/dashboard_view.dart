import 'package:flutter/material.dart';
import 'package:flutter_course/core/network/services.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: UserService().fetchUser(), // Llamada al servicio
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error al cargar datos'));
        }

        final userData = snapshot.data;
        final username = userData?['username'] ?? 'N/A';
        final email = userData?['email'] ?? 'N/A';

        return Container(
          decoration: BoxDecoration(color: Colors.white),
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Hello world dashboard view',
                style: TextStyle(
                  fontSize: 16, 
                  color: Colors.black
                ),
              ),
              const SizedBox(height: 10), // Un poco de espacio
              Text(
                'Username: $username',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              Text(
                'Email: $email',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ],
          ),
        );
      },
    );
  }
}