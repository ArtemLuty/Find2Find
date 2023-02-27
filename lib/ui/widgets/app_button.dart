import 'package:find_me/constants/app_colors.dart';
import 'package:find_me/constants/app_styles.dart';
import 'package:flutter/material.dart';

enum AppButtonType {
  OutlineBtnWhite,
  OutlineBtnGreen,
  OutlineBtnGray,
  GradientBtn
}

class AppButton extends StatelessWidget {
  final String? name;
  final VoidCallback? onPressed;
  final AppButtonType? type;
  final double? height;
  final bool? isBig;

  const AppButton({
    Key? key,
    @required this.type,
    this.name,
    this.onPressed,
    this.height,
    this.isBig = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget? content;
    switch (type) {
      case AppButtonType.OutlineBtnWhite:
        content = _buildOutButton(
            name: name,
            onTap: onPressed,
            colorBtn: kTextWhiteColor,
            height: isBig! ? 56.0 : 48.0);
        break;
      case AppButtonType.OutlineBtnGreen:
        content = _buildOutButton(
            name: name,
            onTap: onPressed,
            colorBtn: kTextGrayColor,
            height: isBig! ? 56.0 : 48.0);
        break;
      case AppButtonType.OutlineBtnGray:
        content = _buildOutButton(
            name: name,
            onTap: onPressed,
            colorBtn: kTextGrayColor,
            height: isBig! ? 56.0 : 48.0);
        break;
      case AppButtonType.GradientBtn:
        content = _buildGradButton(
            name: name, onTap: onPressed, height: isBig! ? 56.0 : 48.0);
        break;
      default:
        content = _buildGradButton(
            name: name, onTap: onPressed, height: isBig! ? 56.0 : 48.0);
    }
    return content;
  }

  Widget _buildGradButton(
      {void Function()? onTap, String? name, double? height}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 28.0, right: 28.0),
        child: Container(
          height: height,
          decoration: onPressed != null
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  gradient: kGradColor,
                )
              : BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: kTextWhiteColor,
                  boxShadow: [
                    BoxShadow(
                      color: kTextMainColor.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 9,
                      offset: Offset(0, 4), // changes position of shadow
                    ),
                  ],
                ),
          child: Center(
              child: Text(name!,
                  style: textStyle(onPressed != null
                      ? kTextWhiteColor
                      : kTextLightGrayColor))),
        ),
      ),
    );
  }

  Widget _buildOutButton(
      {String? name, void Function()? onTap, Color? colorBtn, double? height}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 28.0, right: 28.0),
        child: Container(
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            border: Border.all(color: colorBtn!, width: 2.0),
          ),
          child: Center(child: Text(name!, style: textStyle(kTextGrayColor))),
        ),
      ),
    );
  }

  TextStyle textStyle(Color color) =>
      text(kCommonMedium, color: color, fw: kBold);
}
