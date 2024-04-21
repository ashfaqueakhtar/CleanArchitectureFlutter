import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_clean_arch/app_colors.dart';
import 'package:getx_clean_arch/domain/usecase/splash/splash_controller.dart';
import 'package:getx_clean_arch/res/app_font_size.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.colorBackground,
        body: GetBuilder<SplashController>(
          builder: (_) =>  Center(
            child: Text(
              "Clean Architecture",
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: AppColors.colorSecondaryText1,
                fontSize: AppFontSize.textLarge,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
