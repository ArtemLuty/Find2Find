import 'package:find_me/app/locator.dart';
import 'package:find_me/caches/preferences.dart';
import 'package:find_me/data/services/local_auth_service.dart';
import 'package:get/get.dart';

class BiometricsController extends GetxController {
  var _pref = locator<Preferences>();

  bool _isEnabled = false;

  bool get isEnabled => _isEnabled;

  set isEnabled(bool isEnabled) {
    _isEnabled = isEnabled;
    update();
  }

  void enableBiometric() async {
    bool isAuth = await LocalAuth().authenticate();
    if (isAuth) {
      await _pref.setBiometricsEnabled(true);
      isEnabled = true;
    }
  }
}
