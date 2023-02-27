import 'package:find_me/constants/app_colors.dart';
import 'package:find_me/constants/app_images.dart';
import 'package:find_me/constants/app_strings.dart';
import 'package:find_me/constants/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CookiePolicyScreen extends StatelessWidget {
  const CookiePolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Image.asset(icTermsHeader),
              Positioned(
                  top: 45.0,
                  right: 16.0,
                  child: GestureDetector(
                      onTap: () => Get.back(),
                      child: SvgPicture.asset(icButtonCancel))),
              Positioned(
                  left: 16.0,
                  bottom: 60.0,
                  child: Container(
                    child: Text(AppStringKeys.ternsTitle.tr,
                        style: text(kCommonXXXXLarge,
                            color: kTextWhiteColor,
                            fw: kBold,
                            isDisplayFont: true)),
                  )),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 26.0),
                    Text(AppStringKeys.paragraph1.tr,
                        style: text(kCommonXLarge,
                            color: kTextBlueColor, fw: kBold)),
                    SizedBox(height: 26.0),
                    Text(AppStringKeys.desc1.tr,
                        style: text(kCommonXMedium,
                            color: kTextMainColor)),
                    SizedBox(height: 26.0),
                    Text(AppStringKeys.paragraph2.tr,
                        style: text(kCommonXLarge,
                            color: kTextBlueColor, fw: kBold)),
                    SizedBox(height: 26.0),
                    Text(AppStringKeys.desc2.tr,
                        style: text(kCommonXMedium,
                            color: kTextMainColor)),
                    SizedBox(height: 26.0),
                    Text(AppStringKeys.paragraph3.tr,
                        style: text(kCommonXLarge,
                            color: kTextBlueColor, fw: kBold)),
                    SizedBox(height: 26.0),
                    Text(AppStringKeys.desc3.tr,
                        style: text(kCommonXMedium,
                            color: kTextMainColor)),
                    SizedBox(height: 26.0),
                    Text(AppStringKeys.paragraph4.tr,
                        style: text(kCommonXLarge,
                            color: kTextBlueColor, fw: kBold)),
                    SizedBox(height: 26.0),
                    Text(AppStringKeys.desc4.tr,
                        style: text(kCommonXMedium,
                            color: kTextMainColor)),
                    SizedBox(height: 26.0),
                    Text(AppStringKeys.paragraph5.tr,
                        style: text(kCommonXLarge,
                            color: kTextBlueColor, fw: kBold)),
                    SizedBox(height: 26.0),
                    Text(AppStringKeys.desc5.tr,
                        style: text(kCommonXMedium,
                            color: kTextMainColor)),
                    SizedBox(height: 26.0),
                    Text(AppStringKeys.paragraph6.tr,
                        style: text(kCommonXLarge,
                            color: kTextBlueColor, fw: kBold)),
                    SizedBox(height: 26.0),
                    Text(AppStringKeys.desc6.tr,
                        style: text(kCommonXMedium,
                            color: kTextMainColor)),
                    SizedBox(height: 26.0),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
