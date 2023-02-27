import 'package:find_me/app/locator.dart';
import 'package:find_me/constants/app_colors.dart';
import 'package:find_me/constants/app_images.dart';
import 'package:find_me/constants/app_styles.dart';
import 'package:find_me/data/services/firebase_messaging.dart';
import 'package:find_me/ui/enable_notifications/enable_notifications_controller.dart';
import 'package:find_me/ui/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EnableNotificationsScreen extends StatelessWidget {
  const EnableNotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EnableNotificationsController>(builder: (_) {
      return Scaffold(
        body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 90,
                      ),
                      Image.asset(
                        icNotification,
                        height: Get.width / 3.5,
                        width: Get.width / 3.5,
                      ),
                      SizedBox(
                        height: 90,
                      ),
                      Text(
                        "Don't miss out on something important!",
                        style: text(kCommonXXXXLarge,
                            color: kTextMainColor, fw: kBold),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        'Find out when the next "Digital Day" is, the latest news from your school, interesting job opportunities and more.',
                        style: text(kCommonMedium, color: kTextMainColor),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
                AppButton(
                  type: AppButtonType.GradientBtn,
                  name: 'ACTIVATE NOTIFICATIONS',
                  onPressed: () {},
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                    onTap: () async {
                      await locator<FirebaseMessagingService>()
                          .requestPermission()
                          .then((value) {
                        /// TODO: navigate to next view
                      });
                    },
                    child: Text('Maybe later',
                        style: text(kCommonLarge, color: kTextBlueColor))),
              ],
            )),
      );
    });
  }
}
