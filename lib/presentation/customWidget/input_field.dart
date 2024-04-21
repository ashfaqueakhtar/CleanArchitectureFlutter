import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getx_clean_arch/app_colors.dart';
import 'package:getx_clean_arch/res/app_font_size.dart';

import 'app_image.dart';

class InputField extends StatelessWidget {
  final String? hintText;
  final Color? hintTextColor;
  final Color? prefixIconColor;
  final String? prefixIcon;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final double? marginTop;
  final double? marginBottom;
  final double? marginLeft;
  final double? marginRight;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final double? height;
  final Color? backgroundColor;
  final double? cornerRadius;
  final String? errorText;
  final TextAlign textAlign;
  final Function(String text)? onChange;
  final Function()? onTap;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;

  const InputField(
      {super.key,
      this.inputFormatters,
      this.maxLength,
      this.onTap,
      this.marginTop,
      this.marginBottom,
      this.marginLeft,
      this.marginRight,
      this.keyboardType = TextInputType.text,
      this.textInputAction = TextInputAction.done,
      this.hintText,
      this.hintTextColor,
      this.maxLines,
      this.minLines,
      this.height,
      this.backgroundColor,
      this.errorText,
      this.onChange,
      this.prefixIcon,
      this.controller,
      this.cornerRadius,
      this.textAlign = TextAlign.start,
      this.prefixIconColor = AppColors.colorSecondaryText1});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (height ?? 64),
      margin: EdgeInsets.only(
        top: marginTop ?? 0.0,
        bottom: marginBottom ?? 0.0,
        left: marginLeft ?? 0.0,
        right: marginRight ?? 0.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: (height ?? 64) - 19,
            child: TextFormField(
              inputFormatters: inputFormatters,
              maxLength: maxLength,
              expands: minLines == null && maxLines == null,
              keyboardType: keyboardType,
              textInputAction: textInputAction,
              controller: controller,
              minLines: minLines,
              maxLines: maxLines,
              readOnly: onTap != null,
              onTap: () {
                if (onTap != null) onTap!();
              },
              textAlign: textAlign,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                counterText: "",
                prefixIconConstraints: const BoxConstraints(
                  minWidth: 2,
                  minHeight: 2,
                ),
                prefixIcon: (prefixIcon == null)
                    ? null
                    : SizedBox(
                        height: 45,
                        width: 45,
                        child: Padding(
                          padding: const EdgeInsets.all(14),
                          child: AppImage(
                            name: prefixIcon!,
                            color: prefixIconColor,
                          ),
                        ),
                      ),
                contentPadding: prefixIcon != null
                    ? EdgeInsets.zero
                    : EdgeInsets.symmetric(horizontal: 15, vertical: (maxLines != null && maxLines! > 2) ? 7 : 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(cornerRadius ?? 8.0)),
                  borderSide: BorderSide(width: 1, color: AppColors.colorHintText.withOpacity(0.7)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(cornerRadius ?? 8.0)),
                  borderSide: BorderSide(width: 1, color: AppColors.colorHintText.withOpacity(0.7)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(cornerRadius ?? 8.0)),
                  borderSide: BorderSide(width: 1, color: AppColors.colorHintText.withOpacity(0.7)),
                ),
                fillColor: backgroundColor ?? AppColors.colorWhite,
                filled: true,
                hintText: hintText ?? "",
                hintStyle: TextStyle(
                  fontSize: AppFontSize.textMedium,
                  color: hintTextColor ?? AppColors.colorHintText,
                ),
              ),
              onChanged: (text) => {if (onChange != null) onChange!(text)},
            ),
          ),
          SizedBox(
            height: 19,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                errorText ?? "",
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontSize: AppFontSize.textMedium,
                      color: AppColors.colorRed,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
