import 'dart:developer';
import 'package:find_me/constants/app_routes.dart';
import 'package:find_me/ui/biometrics/biometrics_screen.dart';
import 'package:find_me/ui/cookie_policy/cookie_policy.dart';
import 'package:find_me/ui/cookies/cookies_consent_screen.dart';
import 'package:find_me/ui/cookies/cookies_customise_screen.dart';
import 'package:find_me/ui/enable_notifications/enable_notifications_screen.dart';
import 'package:find_me/ui/local_auth/local_auth_screen.dart';
import 'package:find_me/ui/registration_company/components/reg_content_company_screen.dart';
import 'package:find_me/ui/registration_company/components/tax_number_screen.dart';
import 'package:find_me/ui/registration_company/registration_company_screen.dart';
import 'package:find_me/ui/registration_student/registration_student_screen.dart';
import 'package:find_me/ui/registration_teacher/components/reg_content_screen.dart';
import 'package:find_me/ui/registration_teacher/components/qr_scanner.dart';
import 'package:find_me/ui/registration_teacher/components/qr_verify_screen.dart';
import 'package:find_me/ui/registration_teacher/components/verify_code.dart';
import 'package:find_me/ui/registration_teacher/registration_teacher_screen.dart';
import 'package:find_me/ui/sign_in/sign_in_with_email_screen.dart';
import 'package:find_me/ui/sign_in/sign_in_with_phone_screen.dart';
import 'package:find_me/ui/start_screen/start_screen_ui.dart';
import 'package:find_me/ui/terms_conditions/terms_conditions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    log('generateRoute | name: ${settings.name} arguments: ${settings.arguments}');
    switch (settings.name) {
      case RoutePaths.StartScreen:
        return MaterialPageRoute(builder: (_) => StartScreen());
      case RoutePaths.TermsConditions:
        return MaterialPageRoute(builder: (_) => TermsConditionsScreen());
      case RoutePaths.CookiePolicy:
        return MaterialPageRoute(builder: (_) => CookiePolicy());
      case RoutePaths.RegStudents:
        return MaterialPageRoute(builder: (_) => RegStudentScreen());
      case RoutePaths.Biometrics:
        return MaterialPageRoute(builder: (_) => BiometricsScreen());
      case RoutePaths.LocalAuth:
        return MaterialPageRoute(builder: (_) => LocalAuthScreen());
      case RoutePaths.RegTeacher:
        return MaterialPageRoute(builder: (_) => RegTeacherScreen());
      case RoutePaths.RegCompany:
        return MaterialPageRoute(builder: (_) => RegCompanyScreen());
      case RoutePaths.RegCompanyContent:
        return MaterialPageRoute(builder: (_) => RegCompanyContentScreen());
      case RoutePaths.RegCTaxNumber:
        return MaterialPageRoute(builder: (_) => TaxRegisterCompany());
      case RoutePaths.RegQr:
        return MaterialPageRoute(builder: (_) => QrScanner());
      case RoutePaths.RegQrVerify:
        return MaterialPageRoute(builder: (_) => VerifyQrScreen());
      case RoutePaths.SignInEmail:
        return MaterialPageRoute(builder: (_) => SignInWithEmail());
      case RoutePaths.SignInPhone:
        return MaterialPageRoute(builder: (_) => SignInWithPhone());
      case RoutePaths.RegTeacherContent:
      case RoutePaths.RegTeacherContent:
        return MaterialPageRoute(builder: (_) => RegTeacherContentScreen());
      case RoutePaths.RegTeacherVerifyCodeContent:
        return MaterialPageRoute(builder: (_) => VerifyCode());
      case RoutePaths.CookiesConsent:
        return MaterialPageRoute(builder: (_) => CookiesConsentScreen());
      case RoutePaths.CookiesCustomise:
        return MaterialPageRoute(builder: (_) => CookiesCustomiseScreen());
      case RoutePaths.PushNotificationActivation:
        return MaterialPageRoute(builder: (_) => EnableNotificationsScreen());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
