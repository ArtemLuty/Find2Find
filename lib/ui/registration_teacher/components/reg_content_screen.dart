import 'dart:math';
import 'package:find_me/constants/app_colors.dart';
import 'package:find_me/constants/app_images.dart';
import 'package:find_me/constants/app_styles.dart';
import 'package:find_me/ui/registration_teacher/registration_teacher_controller.dart';
import 'package:find_me/ui/widgets/linear_progres_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class RegTeacherContentScreen extends StatefulWidget {
  const RegTeacherContentScreen({Key? key}) : super(key: key);

  @override
  _RegTeacherContentScreenState createState() =>
      _RegTeacherContentScreenState();
}

class _RegTeacherContentScreenState extends State<RegTeacherContentScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegTeacherController>(
      init: RegTeacherController(),
      builder: (rTC) {
        return Scaffold(
          backgroundColor: kTextWhiteColor,
          body: Column(
            children: [
              Stack(
                children: [
                  // rTC.indexContent == 3 || rTC.indexContent == 2
                  //     ? TweenAnimationBuilder(
                  //         tween: Tween<double>(begin: 0, end: rTC.angle),
                  //         duration: Duration(milliseconds: 500),
                  //         builder: (BuildContext context, double val, __) {
                  //           if (val >= (pi / 2)) {
                  //             SchedulerBinding.instance!
                  //                 .addPostFrameCallback((_) {
                  //               rTC.isBack = false;
                  //               rTC.update();
                  //             });
                  //           } else {
                  //             SchedulerBinding.instance!
                  //                 .addPostFrameCallback((_) {
                  //               rTC.isBack = true;
                  //               rTC.update();
                  //             });
                  //           }
                  //           return (Transform(
                  //             alignment: Alignment.center,
                  //             transform: Matrix4.identity()
                  //               ..setEntry(2, 2, 0.000)
                  //               ..rotateY(val),
                  //             child: rTC.isBack
                  //                 ? Image.asset(rTC.image!)
                  //                 : Transform(
                  //                     alignment: Alignment.center,
                  //                     transform: Matrix4.identity()
                  //                       ..rotateY(pi),
                  //                     child: Image.asset(rTC.image!,
                  //                         fit: BoxFit.contain),
                  //                   ),
                  //           ));
                  //         })
                  //     :
                  AnimatedSwitcher(
                          duration: Duration(seconds: 1),
                          child: Container(
                              key: ValueKey<String>(rTC.image!),
                              child:
                                  Image.asset(rTC.image!, fit: BoxFit.cover)),
                          switchOutCurve: Curves.fastLinearToSlowEaseIn,
                          switchInCurve: Curves.fastLinearToSlowEaseIn,
                          transitionBuilder: (widget, animation) =>
                              ScaleTransition(
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
                          value: rTC.progressPercent,
                        ),
                      )),
                  Positioned(
                      top: 55.0,
                      right: 16.0,
                      child: rTC.indexContent == 0
                          ? GestureDetector(
                              onTap: () => Get.back(),
                              child: SvgPicture.asset(icButtonCancel))
                          : rTC.indexContent == 4
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
                      child: rTC.indexContent != 0
                          ? GestureDetector(
                              onTap: () {
                                final updated = ((rTC.progressPercent - 0.1)
                                        .clamp(0.0, 1.0) *
                                    100);
                                rTC.progressPercent = updated.round() / 100;
                                rTC.changePage(rTC.backRoute!);
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
                            '${rTC.title}',
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
              rTC.content,
            ],
          ),
        );
      },
    );
  }
}
