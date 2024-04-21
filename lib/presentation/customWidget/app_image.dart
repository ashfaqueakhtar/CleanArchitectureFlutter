import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppImage extends StatelessWidget {
  final String name;
  final double width;
  final double height;
  final Color? color;
  final IconType imageType;
  final BoxFit? fit;
  final double marginLeft;
  final double marginRight;
  final double marginTop;
  final double marginBottom;
  final Function()? onPressed;

  const AppImage(
      {super.key,
      this.color,
      this.marginLeft = 0.0,
      this.marginRight = 0.0,
      this.marginBottom = 0.0,
      this.marginTop = 0.0,
      this.fit,
      this.height = 20.0,
      this.width = 20.0,
      this.name = "",
      this.imageType = IconType.svg,
      this.onPressed});

  static const iconShare = "iconShare";
  static const iconLogout = "iconLogout";
  static const iconFeeAndCharges = "iconFeeAndCharges";

  //private
  static const _filePath = "assets/images/";

  static const Map<String, String> _image = {
    iconShare: 'iconShare.svg',
    iconLogout: 'iconLogout.svg',
    iconFeeAndCharges: 'iconFeeAndCharges.png',
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: marginTop, bottom: marginBottom, left: marginLeft, right: marginRight),
      child: IgnorePointer(
        ignoring: (onPressed == null),
        child: InkWell(
          onTap: () {
            if (onPressed != null) onPressed!();
          },
          child: (imageType == IconType.svg)
              ? SvgPicture.asset(
                  "$_filePath${_image[name]}",
                  width: width,
                  height: height,
                  colorFilter: color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
                  fit: fit ?? BoxFit.contain,
                )
              : Image.asset(
                  "$_filePath${_image[name]}",
                  width: width,
                  height: height,
                  color: color,
                  fit: fit,
                ),
        ),
      ),
    );
  }
}

enum IconType { png, svg, lottie }
