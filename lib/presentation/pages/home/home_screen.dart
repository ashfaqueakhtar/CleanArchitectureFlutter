import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_clean_arch/app_colors.dart';
import 'package:getx_clean_arch/domain/usecase/home/home_controller.dart';
import 'package:getx_clean_arch/presentation/customWidget/app_image.dart';
import 'package:getx_clean_arch/presentation/customWidget/app_top_bar.dart';

import 'home_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomeController>();

    return SafeArea(
      child: Scaffold(
        appBar: AppTopBar(
          isBackArrow: false,
          title: "Home",
          action: [
            IconButton(
              icon: const AppImage(name: AppImage.iconLogout, color: AppColors.colorWhite,),
              onPressed: () {
                controller.onLogout();
              },
            ),
          ],
        ),

        body: Obx(
          () => Column(
            children: [
              for (var items in controller.getUserList) ...[
                HomeItem(
                  name: "${items.firstName} ${items.lastName}",
                  email: items.email,
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
