import 'dart:isolate';

import 'package:get/get.dart';
import 'package:getx_clean_arch/config/network/network_constants.dart';
import 'package:getx_clean_arch/config/network/status.dart';
import 'package:getx_clean_arch/config/routes/routes.dart';
import 'package:getx_clean_arch/data/model/remote/user/all_user_response.dart';
import 'package:getx_clean_arch/domain/repo/user_repo.dart';

class HomeController extends GetxController {
  final _repo = Get.find<UserRepo>();

  final _status = STATUS.IDLE.obs;
  final RxList<Data> _userList = <Data>[].obs;

  get getStatus => _status.value;

  List<Data> get getUserList => _userList;

  @override
  void onInit() {
    super.onInit();
    _callHomeApi();
    //_callHomeApiWithIsolate();
  }

  void computeInIsolate(SendPort sendPort) async {
    ////// Request Data
    Map<String, dynamic> data = {
      NetworkConstants.paramPage: "1",
    };
    //////
    sendPort.send(await _repo.getAllUsers(requestData: data));
  }

  void _callHomeApiWithIsolate() async {
    final receivePort = ReceivePort();
    ////// Request Data
    Map<String, dynamic> data = {
      NetworkConstants.paramPage: "1",
    };
    //////

    await Isolate.spawn((List<dynamic> args) async {
      SendPort sendPort = args[0];
      UserRepo r = args[1];
      Map<String, dynamic> d = args[2];


      sendPort.send(await r.getAllUsers(requestData: d));
    }, [receivePort.sendPort, _repo, data] /*receivePort.sendPort*/);

    receivePort.listen((value) {
      _status.value = STATUS.SUCCESS;
      AllUserResponse? response = value;
      if (response != null) {
        var listUser = response.data ?? [];
        _userList.value = listUser;
      }
    }).onError((er, stackTrace) {
      _status.value = STATUS.ERROR;
    });
  }

  void _callHomeApi() {
    ////// Request Data
    Map<String, dynamic> data1 = {
      NetworkConstants.paramPage: "1",
    };
    //////

    ////// Any of data1 or data2 can be used
    _status.value = STATUS.LOADING;
    _repo.getAllUsers(requestData: data1).then((value) {
      _status.value = STATUS.SUCCESS;
      AllUserResponse? response = value;
      if (response != null) {
        var listUser = response.data ?? [];
        _userList.value = listUser;
      }
    }).onError((error, stackTrace) {
      _status.value = STATUS.ERROR;
    });
    //////
  }

  onLogout() {
    _repo.clearAllData().then((value) => _goToLoginPage());
  }

  _goToLoginPage() {
    Get.offNamed(Routes.kLogin);
  }
}
