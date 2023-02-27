import 'package:find_me/data/services/local_auth_service.dart';
import 'package:find_me/ui/biometrics/biometrics_controller.dart';
import 'package:find_me/ui/biometrics/components/face_id_content.dart';
import 'package:find_me/ui/biometrics/components/touch_id_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

class BiometricsScreen extends StatelessWidget {
  BiometricsScreen({Key? key}) : super(key: key);

  final biometricsController = Get.find<BiometricsController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BiometricsController>(
        init: BiometricsController(),
        builder: (_) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: FutureBuilder<List<BiometricType>>(
                future: LocalAuth().getAvailableBiometrics(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.contains(BiometricType.face)) {
                      return FaceIdContent();
                    } else if (snapshot.data!
                        .contains(BiometricType.fingerprint)) {
                      return TouchIdContent();
                    } else {
                      return const Offstage();
                    }
                  } else {
                    return const Offstage();
                  }
                },
              ),
            ),
          );
        });
  }
}
