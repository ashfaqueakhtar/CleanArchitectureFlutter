import 'package:get/get.dart';
import 'package:getx_clean_arch/domain/usecase/splash/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController());
  }
}
