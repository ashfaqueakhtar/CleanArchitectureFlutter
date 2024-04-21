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
