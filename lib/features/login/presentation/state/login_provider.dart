import 'package:flutter/material.dart';
import 'package:session_3/features/login/domain/use_cases/login_use_case.dart';

class LoginProvider extends ChangeNotifier {
  final LoginUseCase _loginUseCase;
  LoginProvider({LoginUseCase? loginUseCase})
    : _loginUseCase = loginUseCase ?? LoginUseCase();

  String title = 'Login';

  bool logged = false;

  void updateTitle(String newTitle) {
    title = newTitle;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    title = 'Haciendo login...';
    notifyListeners();

    try {
      final user = await _loginUseCase.call(email, password);
      title = 'Bienvenido ${user.name}';
      logged = true;

      notifyListeners();
      return true;
    } catch (e) {
      title = 'Error al hacer login';
      logged = false;
      notifyListeners();
      return false;
    }
  }

  void loginWithFacebook() {}
}
