import 'package:find_me/ui/biometrics/biometrics_controller.dart';
import 'package:find_me/ui/cookies/cookies_controller.dart';
import 'package:find_me/ui/enable_notifications/enable_notifications_controller.dart';
import 'package:find_me/ui/local_auth/local_auth_controller.dart';
import 'package:find_me/ui/registration_student/registration_student_controller.dart';
import 'package:find_me/ui/registration_teacher/registration_teacher_controller.dart';
import 'package:find_me/ui/sign_in/sign_in_controller.dart';
import 'package:find_me/ui/splash/splash_controller.dart';
import 'package:get/get.dart';

setupBindings() => {
      Get.lazyPut(() => RegStudentController()),
      Get.lazyPut(() => RegTeacherController()),
      Get.lazyPut(() => SignInController()),
      Get.lazyPut(() => SplashController()),
      Get.lazyPut(() => CookiesController()),
      Get.lazyPut(() => BiometricsController()),
      Get.lazyPut(() => LocalAuthController()),
      Get.lazyPut(() => EnableNotificationsController()),
    };
