//import 'dart:convert';

import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class LoginFormProvider extends ChangeNotifier {
  // ignore: unnecessary_new
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  String correo = '';
  String password = '';

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool isValidForm() {
    // debug prints kept minimal
    print(formKey.currentState?.validate());
    print('$correo - $password');
    return formKey.currentState?.validate() ?? false;
  }

  // Replaced the broken HTTP code.
  // Call this from the UI: final error = await loginFormProvider.validarLogin(authService);
  // Returns null when login succeeds, or an error message when it fails.
  Future<String?> validarLogin(AuthService authService) async {
    if (!isValidForm()) return 'Formulario inválido';

    isLoading = true;

    try {
      final String? error = await authService.loginLocal(correo, password);
      return error; // null = success
    } catch (e) {
      return 'Error de conexión: $e';
    } finally {
      isLoading = false;
    }
  }
}
