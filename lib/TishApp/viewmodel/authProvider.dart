import 'package:TishApp/TishApp/Services/AuthService.dart';
import 'package:flutter/cupertino.dart';

class AuthProvider with ChangeNotifier {
  bool _login_response = false;
  bool _register_response = false;

  // ignore: non_constant_identifier_names
  Future<void> Login(String username, String password) async {
    try {
      setLoginResponse(false);
      bool response = await AuthService().LoginRepo(username, password);
      setLoginResponse(response);
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  // ignore: non_constant_identifier_names
  Future<void> Register(
      String firstName, String lastName, String password, String email) async {
    try {
      setRegisterResponse(false);
      bool response = await AuthService()
          .registerService(firstName, lastName, password, email);
      setRegisterResponse(response);
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  void setLoginResponse(bool response) {
    _login_response = response;
    notifyListeners();
  }

  void setRegisterResponse(bool response) {
    _register_response = response;
    notifyListeners();
  }

  bool get login_response {
    return _login_response;
  }

  bool get register_response {
    return _register_response;
  }
}
