import 'package:find_me/constants/app_colors.dart';
import 'package:find_me/constants/app_images.dart';
import 'package:find_me/constants/app_routes.dart';
import 'package:find_me/constants/app_styles.dart';
import 'package:find_me/ui/widgets/app_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

Widget buildBiometricsEnabled({bool isFingerprint = false}) {
  return Column(
    children: [
      Expanded(
        child: Column(
          children: [
            SizedBox(
              height: 90,
            ),
            Image.asset(
              icDone,
              height: Get.width / 3.5,
              width: Get.width / 3.5,
            ),
            SizedBox(
              height: 90,
            ),
            Text(
              isFingerprint ? "Touch ID Activated!" : "Face ID Activated!",
              style: text(kCommonXXXXXLarge, color: kTextMainColor, fw: kBold),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              isFingerprint
                  ? "From now on you will be able to sign in quickly with Touch ID."
                  : "From now on you will be able to sign in quickly with Face ID.",
              style: text(kCommonMedium, color: kTextMainColor),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
      AppButton(
        type: AppButtonType.GradientBtn,
        name: 'CONTINUE',
        onPressed: () {
          Get.offNamed(RoutePaths.PushNotificationActivation);
        },
      ),
      SizedBox(
        height: 70,
      ),
    ],
  );
}
