import 'package:flutter/material.dart';
import 'package:getx_clean_arch/app_colors.dart';
import 'package:getx_clean_arch/res/app_font_size.dart';

import 'app_image.dart';

class CommonButton extends StatelessWidget {
  final bool loading;
  final double buttonWidth;
  final double buttonHeight;
  final String buttonText;
  final String? prefixIcon;
  final Color enabledTextColor;
  final Color disabledTextColor;
  final Color enabledBackgroundColor;
  final Color disabledBackgroundColor;
  final Color? buttonStrokeColor;
  final bool enabled;
  final EdgeInsetsGeometry? padding;
  final Function() onPressed;

  const CommonButton(
      {super.key,
      this.enabled = true,
      this.loading = false,
      this.buttonWidth = 243,
      this.buttonHeight = 45,
      this.buttonText = "",
      this.prefixIcon,
      this.padding,
      this.buttonStrokeColor,
      required this.onPressed,
      this.enabledTextColor = AppColors.colorWhite,
      this.disabledTextColor = AppColors.colorPrimaryText,
      this.enabledBackgroundColor = AppColors.colorButtonEnabled,
      this.disabledBackgroundColor = AppColors.colorButtonDisabled});

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Center(child: CircularProgressIndicator())
        : SizedBox(
            width: buttonWidth == 0 ? null : buttonWidth,
            height: buttonHeight == 0 ? null : buttonHeight,
            child: IgnorePointer(
              ignoring: !enabled,
              child: TextButton(
                  onPressed: () {
                    if (enabled) onPressed();
                  },
                  style: TextButton.styleFrom(
                      backgroundColor: enabled ? enabledBackgroundColor : disabledBackgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: (buttonStrokeColor != null)
                            ? BorderSide(
                                color: buttonStrokeColor!,
                                width: 1.0,
                              )
                            : BorderSide.none,
                      ),
                      padding: padding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Visibility(
                        visible: prefixIcon != null,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: AppImage(
                            color: AppColors.colorWhite,
                            name: prefixIcon ?? "",
                            width: 18,
                            height: 18,
                          ),
                        ),
                      ),
                      Text(
                        buttonText,
                        style: Theme.of(context).textTheme.displayMedium!.copyWith(
                              color: enabled ? enabledTextColor : disabledTextColor,
                              fontSize: AppFontSize.textLarge,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ],
                  )),
            ),
          );
  }
}
