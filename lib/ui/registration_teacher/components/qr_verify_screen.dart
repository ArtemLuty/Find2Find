import 'package:find_me/constants/app_colors.dart';
import 'package:find_me/constants/app_images.dart';
import 'package:find_me/constants/app_routes.dart';
import 'package:find_me/constants/app_styles.dart';
import 'package:find_me/ui/registration_teacher/registration_teacher_controller.dart';
import 'package:find_me/ui/widgets/app_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class VerifyQrScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegTeacherController>(
      init: RegTeacherController(),
      builder: (rTC) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: kTextWhiteColor,
            leading: IconButton(
              icon: SvgPicture.asset(icButtonBack, color: kTextMainColor),
              onPressed: () => Get.back(),
            ),
          ),
          backgroundColor: kTextWhiteColor,
          body: Padding(
            padding: const EdgeInsets.only(left: 31.0, right: 31.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    SizedBox(height: 19.0),
                    Container(
                        height: 100.0,
                        width: 100.0,
                        child: Image.asset(icRegTHeader2)),
                    SizedBox(height: 60.0),
                    Text('Code Verified!',
                        style: text(kCommonXXXXXLarge,
                            isDisplayFont: true,
                            color: kTextMainColor,
                            fw: kBold)),
                    SizedBox(height: 16),
                    RichText(
                      text: TextSpan(
                          text: 'You have been verified as a teacher at ',
                          style: text(kCommonXMedium, color: kTextMainColor),
                          children: <TextSpan>[
                            TextSpan(
                                text: ' Berlin British School.',
                                style: text(kCommonXMedium,
                                    color: kTextMainColor, fw: kBold),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {})
                          ]),
                    ),
                  ],
                ),
                Column(
                  children: [
                    AppButton(
                        type: AppButtonType.GradientBtn,
                        name: 'COMPLETE REGISTRATION',
                        onPressed: () => Get.toNamed(RoutePaths.RegTeacherContent)),
                    SizedBox(height: 30.0),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
