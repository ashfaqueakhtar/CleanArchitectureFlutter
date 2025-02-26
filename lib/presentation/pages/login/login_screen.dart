import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_clean_arch/app_colors.dart';
import 'package:getx_clean_arch/config/network/status.dart';
import 'package:getx_clean_arch/domain/usecase/login/login_controller.dart';
import 'package:getx_clean_arch/presentation/customWidget/common_button.dart';
import 'package:getx_clean_arch/presentation/customWidget/input_field.dart';

import 'package:getx_clean_arch/res/app_font_size.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<LoginController>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.colorBackground,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Login",
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: AppColors.colorSecondaryText1,
                      fontSize: AppFontSize.textUltraLarge,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(
                () => InputField(
                  hintText: "Username",
                  errorText: controller.getUserNameError,
                  controller: controller.usernameController,
                  onChange: (value) {
                    controller.getLoginData.setUsername(value);
                  },
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Obx(
                () => InputField(
                  hintText: "Password",
                  controller: controller.passwordController,
                  errorText: controller.getPasswordError,
                  onChange: (value) {
                    controller.getLoginData.setPassword(value);
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(
                () => CommonButton(
                  loading: controller.getStatus == STATUS.LOADING,
                  buttonText: "Submit",
                  onPressed: () {
                    controller.onSubmit();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
