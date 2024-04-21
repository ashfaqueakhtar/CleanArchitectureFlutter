import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_clean_arch/app_colors.dart';
import 'package:getx_clean_arch/res/app_font_size.dart';

class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? titleWidget;
  final bool isBackArrow;
  final List<Widget>? action;

  const AppTopBar({
    super.key,
    this.title,
    this.titleWidget,
    this.action,
    this.isBackArrow = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      automaticallyImplyLeading: isBackArrow,
      actions: action,
      title: Padding(
        padding: EdgeInsets.only(left: isBackArrow ? 0 : 15),
        child: titleWidget ??
            Text(
              title ?? "",
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    color: AppColors.colorWhite,
                    fontSize: AppFontSize.textLarge,
                  ),
            ),
      ),
      titleSpacing: 0,
      leading: isBackArrow
          ? IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.colorWhite),
              onPressed: () => Get.back(),
            )
          : null,
      elevation: 0,
      iconTheme: const IconThemeData(
        color: AppColors.colorWhite,
      ),
      backgroundColor: AppColors.colorPurple,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
