import 'package:find_me/constants/app_colors.dart';
import 'package:find_me/constants/app_routes.dart';
import 'package:find_me/constants/app_styles.dart';
import 'package:find_me/ui/cookies/cookies_controller.dart';
import 'package:find_me/ui/widgets/app_button.dart';
import 'package:find_me/ui/widgets/custom_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CookiesCustomiseScreen extends StatelessWidget {
  CookiesCustomiseScreen({Key? key}) : super(key: key);

  final CookiesController controller = Get.find<CookiesController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CookiesController>(builder: (_) {
      return SafeArea(
        child: Scaffold(
          body: Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 90),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Customise Cookies",
                          style: text(kCommonXXXXXLarge,
                              color: kTextMainColor, fw: kBold),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                            "We use cookies and similar technologies to give you the best experience. You can choose what data we use on your device.",
                            style: text(kCommonXMedium, color: kTextMainColor)),
                        _buildSwitchBlock(
                            "Essential",
                            "Data needed for the app to work properly, keep you safe and deliver FindMe's services. These services also include a personalised FindMe app. This can't be turned off.",
                            controller.isEssentialEnabled),
                        _buildSwitchBlock(
                            "Performance",
                            "Data that helps us improve the app and your experience by understanding how you use it.",
                            controller.isPerformanceEnabled),
                        _buildSwitchBlock(
                            "Personalisation and Marketing",
                            "Data we use to bring you relevant content, offers, advertisements and more outside of the FindMe app.",
                            controller.isPersonalisationEnabled),
                        SizedBox(
                          height: 6,
                        ),
                        RichText(
                            text: TextSpan(
                                text: 'Read more in our ',
                                style: text(kCommonSmall),
                                children: [
                              WidgetSpan(
                                child: InkWell(
                                  onTap: () =>
                                      Get.toNamed(RoutePaths.CookiePolicy),
                                  child: Text("Cookie Policy",
                                      style: text(kCommonSmall,
                                          color: kTextBlueColor)),
                                ),
                              )
                            ]))
                      ],
                    ),
                  ),
                ),
                AppButton(
                  type: AppButtonType.GradientBtn,
                  name: 'SAVE PREFERENCES',
                  onPressed: controller.allowCustomised,
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Text('Cancel',
                        style: text(kCommonLarge, color: kTextBlueColor))),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildSwitchBlock(String title, String description, bool value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(title,
                    style: text(kCommonXLarge, color: kTextMainColor, fw: kBold)),
              ),
              CustomSwitch(
                value: value,
                onChanged: (value) {},
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(description, style: text(kCommonXMedium, color: kTextMainColor))
        ],
      ),
    );
  }
}
