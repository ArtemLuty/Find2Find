import 'package:find_me/constants/app_routes.dart';
import 'package:find_me/data/services/local_auth_service.dart';
import 'package:get/get.dart';

class LocalAuthController extends GetxController {
  @override
  void onReady() async {
    super.onReady();

    startBiometricAuth();
  }

  void startBiometricAuth() async {
    bool isAuth = await LocalAuth().authenticate();
    if (isAuth) {
      Get.offNamed(RoutePaths.StartScreen);
    }
  }
}
