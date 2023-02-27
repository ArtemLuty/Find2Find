import 'dart:math';

import 'package:find_me/constants/app_colors.dart';
import 'package:find_me/constants/app_images.dart';
import 'package:find_me/constants/app_routes.dart';
import 'package:find_me/constants/app_strings.dart';
import 'package:find_me/constants/app_styles.dart';
import 'package:find_me/ui/widgets/app_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  bool isBack = true;
  bool isCreateAcc = false;
  double angle = 0;

  void _flip() {
    setState(() {
      if (isCreateAcc) isCreateAcc = false;
      angle = (angle + pi) % (2 * pi);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                Positioned(
                  top: !isBack ? -150 : -150,
                  left: !isBack ? -40 : -90,
                  right: !isBack ? -90 : -30,
                  child: GestureDetector(
                    onTap: () {
                      if (!isBack) _flip();
                    },
                    child: TweenAnimationBuilder(
                        tween: Tween<double>(begin: 0, end: angle),
                        duration: Duration(milliseconds: 500),
                        builder: (BuildContext context, double val, __) {
                          if (val >= (pi / 2)) {
                            SchedulerBinding.instance!
                                .addPostFrameCallback((_) {
                              setState(() {
                                isBack = false;
                              });
                            });
                          } else {
                            SchedulerBinding.instance!
                                .addPostFrameCallback((_) {
                              setState(() {
                                isBack = true;
                              });
                            });
                          }
                          return (Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.identity()
                              ..setEntry(3, 2, 0.000)
                              ..rotateY(val),
                            child: isBack
                                ? Image.asset(icFrontBg)
                                : Transform(
                                    alignment: Alignment.center,
                                    transform: Matrix4.identity()..rotateY(pi),
                                    child: Image.asset(icBackBg,
                                        fit: BoxFit.contain),
                                  ),
                          ));
                        }),
                  ),
                ),
                Positioned(
                    left: 0,
                    right: 0,
                    top: 170.0,
                    child: Column(
                      children: [
                        Container(height: 102.0, child: Image.asset(icLogoBg)),
                        isCreateAcc
                            ? Column(
                                children: [
                                  SizedBox(height: 45),
                                  Center(
                                      child: Image.asset(icCreateSubTitle,
                                          height: 58.0)),
                                ],
                              )
                            : SizedBox()
                      ],
                    )),
                Positioned(
                    left: 16,
                    top: 40.0,
                    child: GestureDetector(
                      onTap: _flip,
                      child: Container(
                        height: 30.0,
                        child: SvgPicture.asset(icButtonBack,
                            color: isBack ? Colors.transparent : Colors.white),
                      ),
                    )),
              ],
            ),
          ),
          Flexible(
            child: Container(
              child: !isCreateAcc
                  ? Column(
                      children: [
                        RichText(
                          text: TextSpan(
                              text: 'By continuing you agree to our',
                              style: text(kCommonSmall - 1,
                                  color: kTextDarkGrayColor),
                              children: <TextSpan>[
                                TextSpan(
                                  text: ' terms & conditions.',
                                  style: text(kCommonSmall - 1,
                                      color: kTextDarkGrayColor,
                                      decoration: TextDecoration.underline),
                                  recognizer: new TapGestureRecognizer()
                                    ..onTap = () =>
                                        Get.toNamed(RoutePaths.TermsConditions),
                                )
                              ]),
                        ),
                        SizedBox(height: 25.0),
                        isBack && !isCreateAcc
                            ? AppButton(
                                isBig: true,
                                type: AppButtonType.GradientBtn,
                                name: AppStringKeys.btnCreateAcc.tr,
                                onPressed: () {
                                  _flip();
                                  setState(() {
                                    isCreateAcc = true;
                                  });
                                })
                            : AppButton(
                                isBig: true,
                                type: AppButtonType.OutlineBtnGray,
                                name: AppStringKeys.btnSignInPhone.tr,
                                onPressed: () =>
                                    Get.toNamed(RoutePaths.SignInPhone)),
                        SizedBox(height: 12.0),
                        isBack && !isCreateAcc
                            ? AppButton(
                                isBig: true,
                                type: AppButtonType.OutlineBtnGray,
                                name: AppStringKeys.btnSignIn.tr,
                                onPressed: _flip)
                            : AppButton(
                                isBig: true,
                                type: AppButtonType.OutlineBtnGray,
                                name: AppStringKeys.btnSignEmail.tr,
                                onPressed: () =>
                                    Get.toNamed(RoutePaths.SignInEmail)),
                        SizedBox(height: 16.0),
                        Text(AppStringKeys.troubleSignIng.tr,
                            style: text(kCommonSmall - 1,
                                color: kTextDarkGrayColor)),
                      ],
                    )
                  : Container(
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 57.0, right: 57.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: _buildButtonRegister(
                                      name: 'STUDENT',
                                      icon: icStudent,
                                      onTap: () =>
                                          Get.toNamed(RoutePaths.RegStudents)),
                                ),
                                SizedBox(width: 16.0),
                                Flexible(
                                  child: _buildButtonRegister(
                                      name: 'TEACHER',
                                      icon: icTeacher,
                                      onTap: () =>
                                          Get.toNamed(RoutePaths.RegTeacher)),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 8.0),
                          _buildButtonRegister(
                              name: 'COMPANY',
                              icon: icCompany,
                              onTap: () => Get.toNamed(RoutePaths.RegCompany)),
                        ],
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonRegister(
      {String? icon, String? name, void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        decoration: BoxDecoration(
          color: kTextWhiteColor,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: kTextMainColor.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 9,
              offset: Offset(0, 4), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              children: [
                Center(
                    child: Container(
                        height: 38, width: 48, child: Image.asset(icon!))),
                Text(name!, style: text(kCommonMedium, color: kTextMainColor))
                    .paddingOnly(top: 12, bottom: 5.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
