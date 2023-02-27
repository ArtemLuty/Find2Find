import 'package:find_me/constants/app_colors.dart';
import 'package:find_me/constants/app_images.dart';
import 'package:find_me/constants/app_styles.dart';
import 'package:find_me/data/services/local_auth_service.dart';
import 'package:find_me/ui/local_auth/local_auth_controller.dart';
import 'package:find_me/ui/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuthScreen extends StatelessWidget {
  const LocalAuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocalAuthController>(builder: (_) {
      return SafeArea(
        child: Scaffold(
          body: Center(
            child: FutureBuilder<List<BiometricType>>(
              future: LocalAuth().getAvailableBiometrics(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.contains(BiometricType.face)) {
                    return buildFaceId();
                  } else if (snapshot.data!
                      .contains(BiometricType.fingerprint)) {
                    return buildTouchId();
                  } else {
                    return const Offstage();
                  }
                } else {
                  return const Offstage();
                }
              },
            ),
          ),
        ),
      );
    });
  }

  Widget buildFaceId() {
    return Column(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 90,
              ),
              Image.asset(
                icFaceId,
                height: Get.width / 3.5,
                width: Get.width / 3.5,
              ),
              SizedBox(
                height: 90,
              ),
              Text(
                "Sign in with  Face ID",
                style: text(kCommonXXXXLarge, color: kTextMainColor, fw: kBold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        buildTryAgainButton()
      ],
    );
  }

  Widget buildTouchId() {
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
                "Sign in with Touch ID",
                style: text(kCommonXXXXLarge, color: kTextMainColor, fw: kBold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        buildTryAgainButton()
      ],
    );
  }

  Widget buildTryAgainButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: AppButton(
        type: AppButtonType.GradientBtn,
        name: 'TRY AGAIN',
        onPressed: (){

        },
      ),
    );
  }
}
