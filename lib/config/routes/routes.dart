import 'package:get/get.dart';
import 'package:getx_clean_arch/domain/usecase/home/home_binding.dart';
import 'package:getx_clean_arch/domain/usecase/login/login_binding.dart';
import 'package:getx_clean_arch/domain/usecase/splash/splash_binding.dart';
import 'package:getx_clean_arch/presentation/pages/home/home_screen.dart';
import 'package:getx_clean_arch/presentation/pages/login/login_screen.dart';
import 'package:getx_clean_arch/presentation/pages/splash/splash_screen.dart';

class Routes {
  static String kSplash = '/';
  static String kHome = '/home';
  static String kLogin = '/login';
}

appRoutes() => [
      GetPage(name: Routes.kSplash, page: () => const SplashScreen(), binding: SplashBinding()),
      GetPage(name: Routes.kHome, page: () => const HomeScreen(), binding: HomeBinding()),
      GetPage(name: Routes.kLogin, page: () => const LoginScreen(), binding: LoginBinding()),
    ];
