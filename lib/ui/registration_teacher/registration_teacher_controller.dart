import 'dart:math';

import 'package:find_me/app/locator.dart';
import 'package:find_me/app/logger.dart';
import 'package:find_me/caches/preferences.dart';
import 'package:find_me/constants/app_images.dart';
import 'package:find_me/constants/app_routes.dart';
import 'package:find_me/data/services/registration_service.dart';
import 'package:find_me/domain/models/registration_model.dart';
import 'package:find_me/enums/register_enum.dart';
import 'package:find_me/ui/registration_teacher/components/content_widgets.dart';
import 'package:find_me/ui/utils/regexp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class RegTeacherController extends GetxController {
  Preferences preferences = locator<Preferences>();
  var logger = getLogger("Registration Controller");

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  RegistrationService _regService = locator<RegistrationService>();

  GlobalKey<FormState> formKeyFirstName = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyLastName = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyEmail = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyPhone = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyVerifyPhone = GlobalKey<FormState>();

  TextEditingController nameTFirstController = TextEditingController();
  TextEditingController nameTLastController = TextEditingController();
  TextEditingController phoneTController = TextEditingController();
  TextEditingController verifyTPhoneController = TextEditingController();
  TextEditingController verifyTCodeController = TextEditingController();
  TextEditingController emailTController = TextEditingController();

  double progressPercent = 0.2;
  int? indexContent;
  String? image;
  String? title;
  String? keyboardValue = '';
  String? keyboardValueVerifyCode = '';
  double? stepValue;
  ScreenRegTeacherType? backRoute;
  late Widget content;
  double angle = 0;
  bool isBack = true;

  RegistrationModel _regModel = RegistrationModel();

  RegistrationModel get regModel => _regModel;

  set regModel(RegistrationModel studentRegModel) {
    _regModel = studentRegModel;
    update();
  }

  bool isFirstNameValid() {
    return nameTFirstController.text.trim().isNotEmpty &&
        nameTFirstController.text.trim().length > 1;
  }

  bool isLastNameValid() {
    return nameTLastController.text.trim().isNotEmpty &&
        nameTLastController.text.trim().length > 1;
  }

  bool isEmailValid() {
    if (emailTController.text.trim().isNotEmpty) {
      return emailRegexp.hasMatch(emailTController.text.trim());
    }
    return true;
  }

  bool isPhoneValid() {
    return phoneTController.text.trim().isNotEmpty &&
        numberRegexp.hasMatch(phoneTController.text.trim()) &&
        phoneTController.text.trim().length > 9 &&
        phoneTController.text.trim().length < 13;
  }

  bool isVerifyPhoneValid() {
    return verifyTPhoneController.text.trim().isNotEmpty &&
        numberRegexp.hasMatch(verifyTPhoneController.text.trim()) &&
        verifyTPhoneController.text.length == 4;
  }

  bool isValid() {
    return isLastNameValid() &&
        isFirstNameValid() &&
        isPhoneValid() &&
        isEmailValid();
  }

  @override
  void onInit() {
    changePage(ScreenRegTeacherType.firstName);
    super.onInit();
  }


  void flipImage() {
      angle = (angle + pi) % (2 * pi);
      update();
  }

  Future<void> registerTeacher() async {
    try {
      if (isValid()) {
        setTeacherRegModelData();
        var result = await _regService.register(regModel, "teacher");
      }
    } catch (err) {
      print(err.toString());
    }
  }

  void setTeacherRegModelData() {
    regModel.email = emailTController.text.trim();
    regModel.firstName = nameTFirstController.text.trim();
    regModel.lastName = nameTLastController.text.trim();
    regModel.password = verifyTPhoneController.text.trim();
    regModel.schoolId = null;
    regModel.username = phoneTController.text.trim().replaceAll(" ", "");
    regModel.dob = "";
    regModel.taxNumber = null;
  }

  void changePage(ScreenRegTeacherType type) {
    switch (type) {
      case ScreenRegTeacherType.firstName:
        indexContent = 0;
        image = icRegHeader1;
        title = 'What’s your first name?';
        content = buildFirstNameTContent();
        update();
        break;
      case ScreenRegTeacherType.lastName:
        backRoute = ScreenRegTeacherType.firstName;
        indexContent = 1;
        image = icRegHeader2;
        title = 'What’s your last name?';
        content = buildLastNameTContent();
        update();
        break;
      case ScreenRegTeacherType.phoneNumber:
        backRoute = ScreenRegTeacherType.lastName;
        indexContent = 2;
        image = icRegHeader1;
        title = 'What’s your phone number?';
        content = buildPhoneNumberTContent();
        update();
        break;
      case ScreenRegTeacherType.verifyPhone:
        backRoute = ScreenRegTeacherType.phoneNumber;
        indexContent = 3;
        image = icRegHeader1;
        title = 'Verify your phone number';
        content = buildPhoneVerifyTContent();
        update();
        break;
      case ScreenRegTeacherType.email:
        backRoute = ScreenRegTeacherType.phoneNumber;
        indexContent = 4;
        image = icRegHeader1;
        title = 'What’s your email address?';
        content = buildETContent();
        update();
        break;
    }
  }

  Future<bool> checkOtpSms() async {
    bool result = false;
    try {
      result = await _regService.checkOtpSms(
          phoneTController.text.trim().replaceAll(" ", ""),
          verifyTPhoneController.text.trim());
    } catch (err) {
      print(err.toString());
    }
    return result;
  }

  Future<bool> sendOtpSms() async {
    bool result = false;
    try {
      result = await _regService
          .sendOtpSms(phoneTController.text.trim().replaceAll(" ", ""));
    } catch (err) {
      print(err.toString());
    }
    return result;
  }

  void onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      controller.pauseCamera();
      Get.toNamed(RoutePaths.RegQrVerify);
      controller.resumeCamera();
      // describeEnum(scanData.format)
      // scanData.code
      // if (await canLaunch(scanData.code)) {
      //   await launch(scanData.code);
      //   controller.resumeCamera();
      // } else {
      //   Get.toNamed(RoutePaths.RegQrVerify);
      //   controller.resumeCamera();
      // }
    });
  }

  onKeyboardTap(String v) {
    keyboardValue = keyboardValue! + v;
    final updated = ((progressPercent + 0.2).clamp(0.0, 1.0) * 100);
    progressPercent = updated.round() / 100;
    update();
    v.isNotEmpty ? changePage(ScreenRegTeacherType.email) : null;
    update();
  }

  onKeyboardVerifyCode(String v) {
    keyboardValueVerifyCode = keyboardValueVerifyCode! + v;
    final updated = ((progressPercent + 0.1).clamp(0.0, 1.0) * 100);
    progressPercent = updated.round() / 100;
    update();
    v.isNotEmpty ? Get.toNamed(RoutePaths.RegTeacherContent) : null;
    update();
  }

  // @override
  // void dispose() {
  //   super.dispose();
  // }
}
