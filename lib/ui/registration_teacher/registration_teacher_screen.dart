import 'package:find_me/constants/app_colors.dart';
import 'package:find_me/constants/app_images.dart';
import 'package:find_me/constants/app_routes.dart';
import 'package:find_me/constants/app_styles.dart';
import 'package:find_me/ui/registration_teacher/registration_teacher_controller.dart';
import 'package:find_me/ui/widgets/app_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class RegTeacherScreen extends StatefulWidget {
  const RegTeacherScreen({Key? key}) : super(key: key);

  @override
  _RegTeacherScreenState createState() => _RegTeacherScreenState();
}

class _RegTeacherScreenState extends State<RegTeacherScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegTeacherController>(
      init: RegTeacherController(),
      builder: (rTC) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
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
                        child: Image.asset(icRegTHeader1)),
                    SizedBox(height: 60.0),
                    Text('Register a teacher’s account',
                        style: text(kCommonXXXXXLarge,
                            isDisplayFont: true,
                            color: kTextMainColor,
                            fw: kBold)),
                    SizedBox(height: 16),
                    Text(
                        'To start your registration you will be asked to scan the QR code your school sent you.',
                        style: text(kCommonXMedium, color: kTextMainColor))
                  ],
                ),
                Column(
                  children: [
                    AppButton(
                      type: AppButtonType.GradientBtn,
                      name: 'CONTINUE',
                      onPressed: () => Get.toNamed(RoutePaths.RegQr),
                    ),
                    SizedBox(height: 16.0),
                    RichText(
                      text: TextSpan(
                          text: 'Alternatively, you can ',
                          style: text(kCommonSmall - 1, color: kTextMainColor),
                          children: <TextSpan>[
                            TextSpan(
                                text: ' enter the code manually.',
                                style: text(kCommonSmall - 1,
                                    color: kTextBlueColor,
                                    decoration: TextDecoration.underline),
                                recognizer: new TapGestureRecognizer()
                                  ..onTap = () => Get.toNamed(RoutePaths.RegTeacherVerifyCodeContent))
                          ]),
                    ),
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
