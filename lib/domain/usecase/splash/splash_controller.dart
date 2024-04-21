import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:getx_clean_arch/config/routes/routes.dart';
import 'package:getx_clean_arch/domain/repo/auth_repo.dart';

class SplashController extends GetxController{
  Timer? _timer;
  final _repo = Get.find<AuthRepo>();


  @override
  void onInit() async {
    //Do all stuffs after super.onInit()
    super.onInit();
    _setTimerNavigation();
  }

  @override
  void onClose() {
    //Do all stuffs before super.onClose()
    if (_timer != null) _timer!.cancel();
    super.onClose();
  }


  void _setTimerNavigation() {
    _timer = Timer(const Duration(seconds: 3), () async {
        String? token = await _repo.getToken();
        debugPrint("token : $token");
        if(token.isEmpty){
          _moveToLoginPage();
        }else{
          _moveToHomePage();
        }

    });
  }
  _moveToHomePage(){
    Get.offNamed(Routes.kHome);
  }

  _moveToLoginPage() {
    Get.offNamed(Routes.kLogin);
  }
}