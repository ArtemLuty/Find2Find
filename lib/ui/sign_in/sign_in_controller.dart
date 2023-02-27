import 'package:find_me/app/locator.dart';
import 'package:find_me/app/logger.dart';
import 'package:find_me/caches/preferences.dart';
import 'package:find_me/constants/app_images.dart';
import 'package:find_me/data/services/registration_service.dart';
import 'package:find_me/enums/register_enum.dart';
import 'package:find_me/ui/sign_in/components/content_widgets.dart';
import 'package:find_me/ui/utils/regexp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  SignInController({this.isEmail = true});

  RegistrationService _regService = locator<RegistrationService>();

  GlobalKey<FormState> formKeyEmail = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyPhone = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyPhoneVerify = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyEmailVerify = GlobalKey<FormState>();

  bool? isEmail;
  Preferences preferences = locator<Preferences>();
  var logger = getLogger("Sign In Controller");

  TextEditingController emailLController = TextEditingController();
  TextEditingController phoneLController = TextEditingController();
  TextEditingController verifyPhoneLController = TextEditingController();
  TextEditingController verifyEmailLController = TextEditingController();

  bool isEmailValid() {
    return emailLController.text.trim().isNotEmpty &&
        emailRegexp.hasMatch(emailLController.text.trim());
  }

  bool isPhoneValid() {
    return phoneLController.text.trim().isNotEmpty &&
        numberRegexp.hasMatch(phoneLController.text.trim()) &&
        phoneLController.text.trim().length > 9 &&
        phoneLController.text.trim().length < 15;
  }

  bool isVerifyPhoneValid() {
    return verifyPhoneLController.text.trim().isNotEmpty &&
        numberRegexp.hasMatch(verifyPhoneLController.text.trim()) &&
        verifyPhoneLController.text.length == 4;
  }

  bool isVerifyEmailValid() {
    return verifyEmailLController.text.trim().isNotEmpty &&
        numberRegexp.hasMatch(verifyEmailLController.text.trim()) &&
        verifyEmailLController.text.length == 4;
  }

  double progressPercent = 0.5;
  int? indexContent;
  String? image;
  String? title;
  String? keyboardPValue = '';
  String? keyboardEValue = '';
  double? stepValue;
  ScreenSignInType? backERoute;
  ScreenSignInType? backPRoute;
  late Widget content;

  @override
  void onInit() {
    super.onInit();
    !isEmail!
        ? changeEmailPage(ScreenSignInType.email)
        : changePhonePage(ScreenSignInType.phoneNumber);
  }

  void changePhonePage(ScreenSignInType type) {
    switch (type) {
      // ignore: missing_enum_constant_in_switch
      case ScreenSignInType.phoneNumber:
        indexContent = 0;
        image = icRegHeader1;
        title = 'What’s your phone number?';
        content = buildPhoneNumberLPContent();
        break;
      case ScreenSignInType.verifyPhone:
        backPRoute = ScreenSignInType.phoneNumber;
        indexContent = 1;
        image = icRegHeader2;
        title = 'Verify your phone number';
        content = buildVerifyPhoneLContent();
        break;
    }
  }

  void changeEmailPage(ScreenSignInType type) {
    switch (type) {
      // ignore: missing_enum_constant_in_switch
      case ScreenSignInType.email:
        indexContent = 0;
        image = icRegHeader1;
        title = 'What’s your email address?';
        content = buildEmailLEContent();
        break;
      case ScreenSignInType.verifyEmail:
        backERoute = ScreenSignInType.email;
        indexContent = 1;
        image = icRegHeader2;
        title = 'Verify your email address';
        content = buildVerifyEmailLContent();
        break;
    }
  }

  Future<bool> checkOtpSmsSignIn() async {
    bool result = false;
    try {
      result = await _regService.checkOtpSmsSignIn(
          phoneLController.text.trim().replaceAll(" ", ""),
          verifyPhoneLController.text.trim());
    } catch (err) {
      print(err.toString());
    }
    return result;
  }

  Future<bool> sendOtpSmsSignIn() async {
    bool result = false;
    try {
      result = await _regService
          .sendOtpSmsSignIn(phoneLController.text.trim().replaceAll(" ", ""));
    } catch (err) {
      print(err.toString());
    }
    return result;
  }

  Future<bool> sendOtpEmail() async {
    bool result = false;
    try {
      result = await _regService
          .sendOtpForEmail(emailLController.text.trim());
    } catch (err) {
      print(err.toString());
    }
    return result;
  }

  Future<bool> checkOtpEmail() async {
    bool result = false;
    try {
      result = await _regService.checkOtpEmail(
          emailLController.text.trim().replaceAll(" ", ""),
          verifyEmailLController.text.trim());
    } catch (err) {
      print(err.toString());
    }
    return result;
  }

  onKeyboardETap(String v) {
    keyboardEValue = keyboardEValue! + v;
    final updated = ((progressPercent + 0.1).clamp(0.0, 1.0) * 100);
    progressPercent = updated.round() / 100;
    // v.isNotEmpty ? //TODO: next rout : null
    update();
  }

  onKeyboardPTap(String v) {
    keyboardPValue = keyboardPValue! + v;
    final updated = ((progressPercent + 0.1).clamp(0.0, 1.0) * 100);
    progressPercent = updated.round() / 100;
    // v.isNotEmpty ? //TODO: next rout : null
    update();
    Future<bool> sendOtpEmail() async {
      bool result = false;
      try {
        result = await _regService
            .sendOtpForEmail(emailLController.text.trim().replaceAll(" ", ""));
      } catch (err) {
        print(err.toString());
      }
      return result;
    }

    @override
    void dispose() {
      super.dispose();
    }
  }
}
