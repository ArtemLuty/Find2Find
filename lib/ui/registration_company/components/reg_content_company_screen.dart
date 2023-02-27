import 'package:find_me/constants/app_colors.dart';
import 'package:find_me/constants/app_images.dart';
import 'package:find_me/constants/app_styles.dart';
import 'package:find_me/ui/registration_company/registration_company_controller.dart';
import 'package:find_me/ui/widgets/linear_progres_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class RegCompanyContentScreen extends StatefulWidget {
  const RegCompanyContentScreen({Key? key}) : super(key: key);

  @override
  _RegCompanyContentScreenState createState() =>
      _RegCompanyContentScreenState();
}

class _RegCompanyContentScreenState extends State<RegCompanyContentScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegCompanyController>(
      init: RegCompanyController(),
      builder: (rCC) {
        return Scaffold(
          backgroundColor: kTextWhiteColor,
          body: Column(
            children: [
              Stack(
                children: [
                  AnimatedSwitcher(
                    duration: Duration(seconds: 1),
                    child: Container(
                        key: ValueKey<String>(rCC.image!),
                        child: Image.asset(rCC.image!, fit: BoxFit.cover)),
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
                          value: rCC.progressPercent,
                        ),
                      )),
                  Positioned(
                      top: 55.0,
                      right: 16.0,
                      child: rCC.indexContent == 0
                          ? GestureDetector(
                              onTap: () => Get.back(),
                              child: SvgPicture.asset(icButtonCancel))
                          : rCC.indexContent == 4
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
                      child: rCC.indexContent != 0
                          ? GestureDetector(
                              onTap: () {
                                final updated = ((rCC.progressPercent - 0.2)
                                        .clamp(0.0, 1.0) *
                                    100);
                                rCC.progressPercent = updated.round() / 100;
                                rCC.changePage(rCC.backRoute!);
                                rCC.update();
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
                            '${rCC.title}',
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
              rCC.content,
            ],
          ),
        );
      },
    );
  }
}
