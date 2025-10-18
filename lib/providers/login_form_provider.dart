import 'package:fl_componentes/services/auth_service.dart';
import 'package:flutter/material.dart';

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

  bool isValidForm() {/*
    print(formKey.currentState?.validate());

    print('$correo - $password');

    return formKey.currentState?.validate() ?? false;
  }*/


  /*
  validarLogin() async {
    print('getOnDisplayCharacters');

    //https://rickandmortyapi.com/api/character
    var url = Uri.http(_baseUrl, 'api/usuarios/login', {
      //'page': '1'
    });

    final response = await http.post(
      url,
      body: jsonEncode({'correo': email, 'password': password}),
    );

    print(response);

    final Map<String, dynamic> decodeData = json.decode(response.body);

    //final rickyMortyResponse = RickyMortyResponse.fromJson(response.body);

    //if (response.statusCode != 200) return('error');

    print(decodeData['ok']);
    //print(rickyMortyResponse.results[0].name);

    //onDisplayCharacter = rickyMortyResponse.results;

    notifyListeners();
  }

  */
    // debug prints kept minimal
    debugPrint(formKey.currentState?.validate().toString());
    debugPrint('$correo - $password');
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
