import 'package:find_me/constants/app_colors.dart';
import 'package:find_me/constants/app_images.dart';
import 'package:find_me/constants/app_styles.dart';
import 'package:find_me/ui/registration_student/registration_student_controller.dart';
import 'package:find_me/ui/widgets/linear_progres_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class RegStudentScreen extends StatefulWidget {
  const RegStudentScreen({Key? key}) : super(key: key);

  @override
  _RegStudentScreenState createState() => _RegStudentScreenState();
}

class _RegStudentScreenState extends State<RegStudentScreen>
    with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegStudentController>(
      init: RegStudentController(),
      builder: (rSC) {
        return Scaffold(
          backgroundColor: kTextWhiteColor,
          body: Column(
            children: [
              Stack(
                children: [
                  AnimatedSwitcher(
                    duration: Duration(seconds: 1),
                    child: Container(
                        key: ValueKey<String>(rSC.image!),
                        child: Image.asset(rSC.image!, fit: BoxFit.cover)),
                    switchOutCurve: Curves.fastLinearToSlowEaseIn,
                    switchInCurve: Curves.fastLinearToSlowEaseIn,
                    transitionBuilder: (widget, animation) => ScaleTransition(
                      scale: animation,
                      child: widget,
                    ),
                  ),
                  Positioned(
                      left: 16.0,
                      right: 16.0,
                      top: 43.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: LinearProgressBar(
                          value: rSC.progressPercent,
                        ),
                      )),
                  Positioned(
                      top: 55.0,
                      right: 16.0,
                      child: rSC.indexContent == 0
                          ? GestureDetector(
                              onTap: () => Get.back(),
                              child: SvgPicture.asset(icButtonCancel))
                          : rSC.indexContent == 7
                              ? GestureDetector(
                                  onTap: () => Get.back(),
                                  child: Text(
                                    'Skip',
                                    style: text(kCommonXLarge,
                                        color: kTextWhiteColor,
                                        isDisplayFont: true),
                                  ))
                              : SizedBox()),
                  Positioned(
                      top: 55.0,
                      left: 16.0,
                      child: rSC.indexContent != 0
                          ? GestureDetector(
                              onTap: () {
                                final updated = ((rSC.progressPercent - 0.1)
                                        .clamp(0.0, 1.0) * 100);
                                rSC.progressPercent = updated.round() / 100;
                                rSC.update();
                                rSC.changePage(rSC.backRoute!);
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
                            '${rSC.title}',
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
              rSC.content,
            ],
          ),
        );
      },
    );
  }
}
