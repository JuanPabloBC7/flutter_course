import 'package:flutter_course/core/environment/environment.dart';
import 'package:flutter_course/main.dart';

void main(List<String> args) {
  Environment.env = Env.production;
    runProject(); 
}