import 'package:find_me/constants/app_colors.dart';
import 'package:find_me/constants/app_images.dart';
import 'package:find_me/constants/app_styles.dart';
import 'package:find_me/ui/sign_in/sign_in_controller.dart';
import 'package:find_me/ui/widgets/linear_progres_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SignInWithPhone extends StatelessWidget {
  const SignInWithPhone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignInController>(
      init: SignInController(isEmail: false),
      builder: (sC) {
        return Scaffold(
          backgroundColor: kTextWhiteColor,
          body: Column(
            children: [
              Stack(
                children: [
                  Image.asset(icRegHeader1, fit: BoxFit.cover),
                  Positioned(
                      left: 16.0,
                      right: 16.0,
                      top: 43.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: LinearProgressBar(
                          value: sC.progressPercent,
                        ),
                      )),
                  Positioned(
                      top: 55.0,
                      right: 16.0,
                      child: sC.indexContent == 0
                          ? GestureDetector(
                              onTap: () => Get.back(),
                              child: SvgPicture.asset(icButtonCancel))
                          : SizedBox()),
                  Positioned(
                      top: 55.0,
                      left: 16.0,
                      child: sC.indexContent != 0
                          ? GestureDetector(
                              onTap: () {
                                sC.isEmail!
                                    ? sC.changeEmailPage(sC.backERoute!)
                                    : sC.changePhonePage(sC.backPRoute!);
                                final updated = ((sC.progressPercent - 0.4)
                                        .clamp(0.0, 1.0) *
                                    100);
                                sC.progressPercent = updated.round() / 100;
                                sC.update();
                              },
                              child: SvgPicture.asset(icButtonBack))
                          : SizedBox()),
                  Positioned(
                      left: 16.0,
                      right: 16.0,
                      bottom: 65.0,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            '${sC.title}',
                            style: text(kCommonXXXXLarge,
                                color: kTextWhiteColor,
                                fw: kBold,
                                isDisplayFont: true),
                            textAlign: TextAlign.start,
                            maxLines: 2,
                          ),
                        ),
                      )),
                ],
              ),
              sC.content,
            ],
          ),
        );
      },
    );
  }
}
