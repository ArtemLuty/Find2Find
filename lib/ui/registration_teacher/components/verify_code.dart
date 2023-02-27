import 'package:find_me/constants/app_colors.dart';
import 'package:find_me/constants/app_images.dart';
import 'package:find_me/constants/app_routes.dart';
import 'package:find_me/constants/app_styles.dart';
import 'package:find_me/ui/registration_teacher/registration_teacher_controller.dart';
import 'package:find_me/ui/widgets/app_numeric_keyboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyCode extends StatelessWidget {
  const VerifyCode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegTeacherController>(
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
                    SizedBox(height: 31.0),
                    Text('Enter your teacher’s code',
                        style: text(kCommonXXXXXLarge,
                            isDisplayFont: true,
                            color: kTextMainColor,
                            fw: kBold)),
                    SizedBox(height: 16),
                    Text(
                        'This code has been sent to you by the school via email.'),
                  ],
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 11.0, right: 11.0),
                  child: Column(
                    children: [
                      Container(
                        width: Get.height,
                        child: Form(
                          key: key,
                          child: AbsorbPointer(
                            child: PinCodeTextField(
                              appContext: Get.context!,
                              controller: rTC.verifyTCodeController,
                              length: 4,
                              textStyle: text(kCommonXXXXXLarge,
                                  color: kTextMainColor, isDisplayFont: true),
                              animationType: AnimationType.fade,
                              validator: (v) {
                                if (v!.length < 3) {
                                  return "I'm from validator";
                                } else {
                                  return null;
                                }
                              },
                              pinTheme: PinTheme(
                                  shape: PinCodeFieldShape.box,
                                  borderRadius: BorderRadius.circular(15),
                                  fieldHeight: 70,
                                  fieldWidth: 70,
                                  activeColor: Colors.transparent,
                                  inactiveColor: Colors.transparent,
                                  selectedColor: kTextBlueColor,
                                  selectedFillColor: kTextLightXGrayColor,
                                  activeFillColor: kTextLightXGrayColor,
                                  inactiveFillColor: kTextLightXGrayColor),
                              cursorColor: Colors.black,
                              animationDuration: Duration(milliseconds: 300),
                              enableActiveFill: true,
                              onCompleted: (v) {
                                // onCompleted!();
                                Get.offNamed(RoutePaths.RegQrVerify);
                              },
                              onChanged: (value) {
                                print(value);
                              },
                              beforeTextPaste: (text) {
                                print("Allowing to paste $text");
                                return true;
                              },
                            ),
                          ),
                        ),
                      ),
                      KeyPad(
                        pinController: rTC.verifyTCodeController,
                        isPinLogin: true,
                        onChange: (String pin) {
                          rTC.verifyTCodeController.text = pin;
                          print('${rTC.verifyTCodeController.text}');
                        },
                        onSubmit: (String pin) {
                          if (pin.length != 4) {
                            return;
                          } else {
                            rTC.verifyTCodeController.text = pin;
                            print('Pin is ${rTC.verifyTCodeController.text}');
                          }
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16)
              ],
            ),
          ),
        );
      },
    );
  }
}
