import 'package:get/get.dart';

import 'login_controller.dart';


class LoginBinding extends Bindings{
  @override
  void dependencies() {
    //What does binding do?
    //Ans - Each screen with its own binding helps to hold the controller or its value unless its active, else it would be released
    //These class level bindings are tagged in appRoutes()
    //We can have many controllers to one binding.
    // Example in Dashboard we can have multiple controllers for different bottom view in dashboardController

    //Here fenix is true because this class could be open again,
    //Refer AppBinding class
    Get.lazyPut<LoginController>(() => LoginController(), fenix: true);
  }
}