import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_clean_arch/config/network/network_constants.dart';
import 'package:getx_clean_arch/config/network/status.dart';
import 'package:getx_clean_arch/config/routes/routes.dart';
import 'package:getx_clean_arch/data/model/remote/auth/login_request.dart';
import 'package:getx_clean_arch/data/model/remote/auth/login_response.dart';
import 'package:getx_clean_arch/domain/entities/login/login_data.dart';
import 'package:getx_clean_arch/domain/repo/auth_repo.dart';

class LoginController extends GetxController {
  //Here controller signifies as a usecase from CLEAN ARCHITECTURE
  //It will have all the business logic

  final _authRepo = Get.find<AuthRepo>();

  final TextEditingController _usernameController = TextEditingController(text: 'eve.holt@reqres.in');
  final TextEditingController _passwordController = TextEditingController(text: 'cityslicka');

  final _loginData = LoginData();
  final _status = STATUS.IDLE.obs;
  final _usernameError = "".obs;
  final _passwordError = "".obs;

  get getStatus => _status.value;

  get getUserNameError => _usernameError.value;

  get getPasswordError => _passwordError.value;
  get usernameController => _usernameController;
  get passwordController => _passwordController;

  LoginData get getLoginData => _loginData;

  @override
  void onInit() {
    super.onInit();
    getLoginData.setPassword(_passwordController.text).setUsername(_usernameController.text);
  }

  @override
  void onClose() {
    _usernameController.dispose(); //dispose is compulsory and before super.onClose()
    _passwordController.dispose();
    super.onClose();
  }

  void onSubmit() {
    //Reset error and the assign
    _passwordError.value = "";
    _usernameError.value = "";
    if (getLoginData.getUserName.isEmpty) {
      _usernameError.value = "Username is Empty";
    } else if (getLoginData.getPassword.isEmpty) {
      _passwordError.value = "Password is Empty";
    } else {
      _callLoginApi();
    }
  }

  void _callLoginApi() {
    /// Request Data
    Map<String, dynamic> data1 = {
      NetworkConstants.paramEmail: getLoginData.getUserName,
      NetworkConstants.paramPassword: getLoginData.getPassword,
    };
    //////
    var data2 = LoginRequest(
      email: getLoginData.getUserName,
      password: getLoginData.getPassword,
    ).toJson();

    //any of data1 or data2 can be used
    _status.value = STATUS.LOADING;
    _authRepo.postLogin(requestData: data2).then((value) {
      _status.value = STATUS.SUCCESS;
      LoginResponse? response = value;
      if (response != null) {
        _authRepo.setToken(response.token ?? "");
        _moveToHome();
      }
    }).onError((error, stackTrace) {
      _status.value = STATUS.ERROR;
    });
    //////
  }

  _moveToHome() {
    Get.offNamed(Routes.kHome);
  }
}
