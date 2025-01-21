import 'package:get/get.dart';
import 'package:getx_clean_arch/config/network/api_service.dart';
import 'package:getx_clean_arch/config/network/api_service_impl.dart';
import 'package:getx_clean_arch/data/datasources/appLocalData/app_local_data.dart';
import 'package:getx_clean_arch/data/datasources/appLocalData/app_local_data_impl.dart';
import 'package:getx_clean_arch/data/repo/auth_repo_impl.dart';
import 'package:getx_clean_arch/data/repo/user_repo_impl.dart';
import 'package:getx_clean_arch/domain/repo/auth_repo.dart';
import 'package:getx_clean_arch/domain/repo/user_repo.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    //1.Using permanent: true for a widget in Flutter ensures that the widget remains static and is not rebuilt,
    //even if its dependencies change
    //By avoiding rebuilt by permanent true it improves the performance of the app.
    //USE_CASE: Use it when you have a class invoked several times through out the app
    //used with Get.put
    //2.Using fenix: true in Flutter enables the incremental compilation feature for a specific widget.
    //Helps faster reload with data.
    //used with Get.lazyPut
    //USE_CASE: Suppose a class with lazyPut has been reinitialised then without fenix true it will have an error

    Get.put<AppLocalData>(AppLocalDataImpl.getInstance(), permanent: true);
    Get.put<ApiService>(ApiServiceImpl(), permanent: true);

    //REPO
    Get.put<AuthRepo>(AuthRepoImpl(), permanent: true);
    Get.put<UserRepo>(UserRepoImpl(), permanent: true);
  }
}
