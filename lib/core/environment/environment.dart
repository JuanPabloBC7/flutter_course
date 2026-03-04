import 'dart:convert';
import 'package:flutter/services.dart';

enum Env { development, staging, production }

class Environment {

  Environment._();
  static Environment? _instance;
  static Environment get intance {
    _instance ??= Environment._();
    return _instance!;
  }

  // Environment variables
  static String get apiBaseUrl => _values['apiUrl'] ?? '';
  static String get appName => _values['appName'] ?? '';
  static String get appMode {
    final appMode = _values['appMode'];
    if (appMode == null) {
      print('Warning: appMode variable is not define');
    }
    return _values['appMode'] ?? '';
  }

  static Map<String,dynamic> _values = {};
  // static Map<String,dynamic> get values => _values;

  // final String apiBaseUrl;
  // const Environment(this.apiBaseUrl);
  // static const dev = Environment('https://api-dev.banco.com');
  // static const prod = Environment('https://api.banco.com');
  static late final Env env;

  static Future<void> initialize() async {
    String fileName;
    switch (env) {
      case Env.development:
        fileName = 'env_dev.json';
        break;
      case Env.staging:
        fileName = 'env_staging.json';
        break;
      case Env.production:
        fileName = 'env_prod.json';
        break;
    }
    _values = await load(fileName);
  }

  static Future<Map<String, dynamic>> load (String fileName) async {
    // Cargar el archivo JSON correspondiente al entorno
    return rootBundle.loadString(fileName).then((jsonString) {
      return json.decode(jsonString);
    });
  }
}