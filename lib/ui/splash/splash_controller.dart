import 'package:find_me/app/locator.dart';
import 'package:find_me/caches/preferences.dart';
import 'package:find_me/constants/app_routes.dart';
import 'package:find_me/data/services/local_auth_service.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  Preferences _pref = locator<Preferences>();

  @override
  void onInit() async {
    super.onInit();
    await Future.delayed(const Duration(seconds: 2));
    bool isBiometricsEnabled = await _pref.getBiometricsEnabled();
    bool canCheckBiometrics = await LocalAuth().checkBiometrics();
    if (canCheckBiometrics && isBiometricsEnabled) {
      Get.offAllNamed(RoutePaths.LocalAuth);
    } else {
      Get.offAllNamed(RoutePaths.StartScreen);
    }
  }
}
