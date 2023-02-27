import 'package:find_me/app/locator.dart';
import 'package:find_me/caches/preferences.dart';
import 'package:find_me/constants/app_routes.dart';
import 'package:find_me/data/services/local_auth_service.dart';
import 'package:get/get.dart';

class CookiesController extends GetxController {
  var _pref = locator<Preferences>();

  bool _isEssentialEnabled = false;

  bool get isEssentialEnabled => _isEssentialEnabled;

  set isEssentialEnabled(bool isEssentialEnabled) {
    _isEssentialEnabled = isEssentialEnabled;
    update();
  }

  bool _isPerformanceEnabled = false;

  bool get isPerformanceEnabled => _isPerformanceEnabled;

  set isPerformanceEnabled(bool isPerformanceEnabled) {
    _isPerformanceEnabled = isPerformanceEnabled;
    update();
  }

  bool _isPersonalisationEnabled = false;

  bool get isPersonalisationEnabled => _isPersonalisationEnabled;

  set isPersonalisationEnabled(bool isPersonalisationEnabled) {
    _isPersonalisationEnabled = isPersonalisationEnabled;
    update();
  }

  void allowAll() async {
    await _pref.setEssentialEnabled(true);
    await _pref.setPerformanceEnabled(true);
    await _pref.setPersonalisationEnabled(true);
    navigateToBiometrics();
  }

  void allowCustomised() async {
    await _pref.setEssentialEnabled(isEssentialEnabled);
    await _pref.setPerformanceEnabled(isPerformanceEnabled);
    await _pref.setPersonalisationEnabled(isPersonalisationEnabled);
    navigateToBiometrics();
  }

  void navigateToBiometrics() async {
    bool isBiometricsEnabled = await _pref.getBiometricsEnabled();
    bool canCheckBiometrics = await LocalAuth().checkBiometrics();
    if (canCheckBiometrics && !isBiometricsEnabled) {
      Get.toNamed(RoutePaths.Biometrics);
    }
    else{
      Get.toNamed(RoutePaths.PushNotificationActivation);
    }
  }
}
