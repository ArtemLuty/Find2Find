import 'package:find_me/constants/app_images.dart';
import 'package:find_me/ui/splash/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(builder: (_) {
      return Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: Stack(
                children: [
                  Positioned(
                      top: -150,
                      left: -90,
                      right: -30,
                      child: Image.asset(icFrontBg)),
                  Positioned(
                      left: 0,
                      right: 0,
                      top: 170.0,
                      child: Column(
                        children: [
                          Container(
                              height: 102.0, child: Image.asset(icLogoBg)),
                        ],
                      )),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
