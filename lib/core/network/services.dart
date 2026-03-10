// import 'dart:convert';
// import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

// class User {
//   String username;
//   String email;

//   User(this.username, this.email);
// }

// class UserService {
//   final String _baseUrl = 'https://api.tu-dominio.com/v1';

//   Future<User> fetchUser() async {
//     final url = Uri.parse('$_baseUrl/users/1');
    
//     try {
//       final response = await http.get(url);

//       if (response.statusCode == 200) {
//         final Map<String, dynamic> data = jsonDecode(response.body);
//         return User.fromJson(data);
//       } else {
//         throw Exception('Error al cargar usuario: ${response.statusCode}');
//       }
//     } catch (e) {
//       throw Exception('Fallo en la conexión: $e');
//     }
//   }
// }

class UserService {
  Future<Map<String, dynamic>> fetchUser() async {
    await Future.delayed(Duration(milliseconds: 500));
    try {
      return jsonDecode('{ "username": "jpbalan", "email": "jpbalan@example.com" }');
    } catch (e) {
      throw Exception('Fallo en la conexión: $e');
    }
  }
}
