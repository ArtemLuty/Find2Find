import 'package:find_me/constants/app_colors.dart';
import 'package:find_me/constants/app_images.dart';
import 'package:find_me/constants/app_routes.dart';
import 'package:find_me/constants/app_styles.dart';
import 'package:find_me/ui/biometrics/biometrics_controller.dart';
import 'package:find_me/ui/biometrics/components/biometrics_enabled_content.dart';
import 'package:find_me/ui/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class TouchIdContent extends StatelessWidget {
  TouchIdContent({Key? key}) : super(key: key);

  final biometricsController = Get.find<BiometricsController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BiometricsController>(
      builder: (_) => AnimatedSwitcher(
          child: biometricsController.isEnabled
              ? buildBiometricsEnabled(isFingerprint: true)
              : buildContent(),
          switchInCurve: Curves.easeIn,
          switchOutCurve: Curves.easeOut,
          transitionBuilder: (Widget child, Animation<double> animation) {
            Offset begin = Offset(1.0, 0.0);
            Offset end = Offset.zero;
            Tween<Offset> tween = Tween(begin: begin, end: end);
            Animation<Offset> offsetAnimation = animation.drive(tween);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
          duration: const Duration(milliseconds: 3000)),
    );
  }

  Widget buildContent() {
    return Column(
      children: [
        Expanded(
          child: Column(
            children: [
              SizedBox(
                height: 90,
              ),
              Image.asset(
                icFingerprint,
                height: Get.width / 3.5,
                width: Get.width / 3.5,
              ),
              SizedBox(
                height: 90,
              ),
              Text(
                "Sign in quicker with Touch ID",
                style: text(kCommonXXXXLarge, color: kTextMainColor, fw: kBold),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                "Enable Fingerprint Scanning for an even smoother sign in experience next time.",
                style: text(kCommonMedium, color: kTextMainColor),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
        AppButton(
          type: AppButtonType.GradientBtn,
          name: 'ENABLE TOUCH ID',
          onPressed: biometricsController.enableBiometric,
        ),
        SizedBox(
          height: 20,
        ),
        GestureDetector(
            onTap: () {
              Get.offNamed(RoutePaths.PushNotificationActivation);
            },
            child: Text('Maybe later',
                style: text(kCommonLarge, color: kTextBlueColor))),
      ],
    );
  }
}
