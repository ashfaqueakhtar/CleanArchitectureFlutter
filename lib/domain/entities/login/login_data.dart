import 'package:get/get.dart';

class LoginData {
  // This class is basically an entity

  final _username = "".obs;
  final _password = "".obs;

  LoginData();

  LoginData setUsername(String value) {
    _username.value = value;
    return this;
  }

  LoginData setPassword(String value) {
    _password.value = value;
    return this;
  }

  String get getUserName => _username.value;

  String get getPassword => _password.value;
}
