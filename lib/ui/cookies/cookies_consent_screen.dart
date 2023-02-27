import 'package:find_me/constants/app_colors.dart';
import 'package:find_me/constants/app_images.dart';
import 'package:find_me/constants/app_routes.dart';
import 'package:find_me/constants/app_styles.dart';
import 'package:find_me/ui/cookies/cookies_controller.dart';
import 'package:find_me/ui/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CookiesConsentScreen extends StatelessWidget {
  CookiesConsentScreen({Key? key}) : super(key: key);

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
                          "Welcome to \nFindMe!",
                          style: text(kCommonXXXXXLarge,
                              color: kTextMainColor, fw: kBold),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        Text(
                            "To give you the best experience, we use data from your device to:",
                            style: text(kCommonXMedium, color: kTextMainColor)),
                        SizedBox(
                          height: 32,
                        ),
                        _buildItem(icPhone,
                            "Make the app work and provide a personalised experience"),
                        SizedBox(
                          height: 32,
                        ),
                        _buildItem(icDashboard, "Improve performance"),
                        SizedBox(
                          height: 32,
                        ),
                        _buildItem(icMegaphone,
                            "Improve content and marketing outside the FindMe app"),
                        SizedBox(
                          height: 32,
                        ),
                        RichText(
                            text: TextSpan(
                                text:
                                    'By clicking "Allow all", you consent to FindMe\'s use of these technologies on this device. You can set your preferences by clicking "Customise". Read more in our ',
                                style: text(kCommonSmall),
                                children: [
                              WidgetSpan(
                                child: InkWell(
                                  onTap: () => Get.toNamed(RoutePaths.CookiePolicy),
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
                  name: 'ALLOW ALL',
                  onPressed: controller.allowAll,
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                    onTap: () {
                      Get.toNamed(RoutePaths.CookiesCustomise);
                    },
                    child: Text('Customise',
                        style: text(kCommonLarge, color: kTextBlueColor))),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildItem(String icon, String title) {
    return Row(
      children: [
        Image.asset(
          icon,
          height: 30,
          width: 30,
        ),
        SizedBox(
          width: 18,
        ),
        Expanded(
            child: Text(
          title,
          style: text(kCommonXMedium, color: kTextMainColor),
        ))
      ],
    );
  }
}
