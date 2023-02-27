import 'package:find_me/app/locator.dart';
import 'package:find_me/app/logger.dart';
import 'package:find_me/caches/preferences.dart';
import 'package:find_me/constants/app_images.dart';
import 'package:find_me/data/services/registration_service.dart';
import 'package:find_me/domain/models/registration_model.dart';
import 'package:find_me/enums/register_enum.dart';
import 'package:find_me/ui/registration_company/components/content_widgets.dart';
import 'package:find_me/ui/utils/regexp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class RegCompanyController extends GetxController {
  Preferences preferences = locator<Preferences>();
  var logger = getLogger("Registration Company Controller");
  var maskFormatter = new MaskTextInputFormatter(mask: "##/###/######");
  RegistrationService _regService = locator<RegistrationService>();

  GlobalKey<FormState> formKeyFirstName = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyLastName = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyEmail = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyPhone = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyTaxNumber = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyValidatePhone = GlobalKey<FormState>();

  TextEditingController nameFirstCController = TextEditingController();
  TextEditingController nameLastCController = TextEditingController();
  TextEditingController dateCController = TextEditingController();
  TextEditingController postCodeCController = TextEditingController();
  TextEditingController schoolCController = TextEditingController();
  TextEditingController phoneCController = TextEditingController();
  TextEditingController verifyPhoneCController = TextEditingController();
  TextEditingController emailCController = TextEditingController();
  TextEditingController taxNumberCController = TextEditingController();

  double progressPercent = 0.2;
  int? indexContent;
  String? image;
  String? title;
  String? keyboardValue = '';
  ScreenRegCompanyType? backRoute;
  late Widget content;

  RegistrationModel _regModel = RegistrationModel();

  RegistrationModel get regModel => _regModel;

  set regModel(RegistrationModel studentRegModel) {
    _regModel = studentRegModel;
    update();
  }

  bool isFirstNameValid() {
    return nameFirstCController.text.trim().isNotEmpty &&
        nameFirstCController.text.trim().length > 1;
  }

  bool isLastNameValid() {
    return nameLastCController.text.trim().isNotEmpty &&
        nameLastCController.text.trim().length > 1;
  }

  bool isSchoolValid() {
    return schoolCController.text.trim().isNotEmpty;
  }

  bool isEmailValid() {
    if (emailCController.text.trim().isNotEmpty) {
      return emailRegexp.hasMatch(emailCController.text.trim());
    }
    return true;
  }

  bool isPhoneValid() {
    return phoneCController.text.trim().isNotEmpty &&
        numberRegexp.hasMatch(phoneCController.text.trim()) &&
        phoneCController.text.trim().length > 9 &&
        phoneCController.text.trim().length < 15;
  }

  bool isPostCodeValid() {
    return postCodeCController.text.trim().isNotEmpty &&
        numberRegexp.hasMatch(postCodeCController.text.trim());
  }

  bool isVerifyPhoneValid() {
    return verifyPhoneCController.text.trim().isNotEmpty &&
        numberRegexp.hasMatch(verifyPhoneCController.text.trim()) &&
        verifyPhoneCController.text.length == 4;
  }

  bool isTaxNumberValid() {
    return taxNumberCController.text.trim().isNotEmpty &&
        numberRegexp.hasMatch(taxNumberCController.text.trim()) &&
        taxNumberCController.text.trim().length == 13;
  }

  bool isValid() {
    return isLastNameValid() &&
        isFirstNameValid() &&
        isPostCodeValid() &&
        isPhoneValid() &&
        isEmailValid() &&
        isTaxNumberValid() &&
        isSchoolValid();
  }

  @override
  void onInit() {
    changePage(ScreenRegCompanyType.firstName);
    super.onInit();
  }

  Future<void> registerCompany() async {
    try {
      if (isValid()) {
        setCompanyRegModelData();
        var result = await _regService.register(regModel, "company");
      }
    } catch (err) {
      print(err.toString());
    }
  }

  void setCompanyRegModelData() {
    regModel.email = emailCController.text.trim();
    regModel.firstName = nameFirstCController.text.trim();
    regModel.lastName = nameLastCController.text.trim();
    regModel.password = verifyPhoneCController.text.trim();
    regModel.schoolId = null;
    regModel.username = phoneCController.text.trim().replaceAll(" ", "");
    regModel.dob = "";
    regModel.taxNumber =
        int.tryParse(taxNumberCController.text.trim().replaceAll("/", ""));
  }

  void changePage(ScreenRegCompanyType type) {
    switch (type) {
      case ScreenRegCompanyType.firstName:
        indexContent = 0;
        image = icRegHeader1;
        title = 'What’s your first name?';
        content = buildFirstNameCContent();
        update();
        break;
      case ScreenRegCompanyType.lastName:
        backRoute = ScreenRegCompanyType.firstName;
        indexContent = 1;
        image = icRegHeader2;
        title = 'What’s your last name?';
        content = buildLastNameCContent();
        update();
        break;
      case ScreenRegCompanyType.phoneNumber:
        backRoute = ScreenRegCompanyType.lastName;
        indexContent = 2;
        image = icRegHeader1;
        title = 'What’s your phone number?';
        content = buildPhoneNumberCContent();
        update();
        break;
      case ScreenRegCompanyType.verifyPhone:
        backRoute = ScreenRegCompanyType.phoneNumber;
        indexContent = 3;
        image = icRegHeader1;
        title = 'Verify your phone number';
        content = buildPhoneVerifyCContent();
        update();
        break;
      case ScreenRegCompanyType.email:
        backRoute = ScreenRegCompanyType.verifyPhone;
        indexContent = 4;
        image = icRegHeader1;
        title = 'What’s your email address?';
        content = buildECContent();
        update();
        break;
    }
  }

  Future<bool> checkTaxNumber() async {
    bool result = false;
    try {
      result = await _regService
          .checkTaxNumber(taxNumberCController.text.trim().replaceAll("/", ""));
    } catch (err) {
      print(err.toString());
    }
    return result;
  }

  Future<bool> checkOtpSms() async {
    bool result = false;
    try {
      result = await _regService.checkOtpSms(
          phoneCController.text.trim().replaceAll(" ", ""),
          verifyPhoneCController.text.trim());
    } catch (err) {
      print(err.toString());
    }
    return result;
  }

  Future<bool> sendOtpSms() async {
    bool result = false;
    try {
      result = await _regService
          .sendOtpSms(phoneCController.text.trim().replaceAll(" ", ""));
    } catch (err) {
      print(err.toString());
    }
    return result;
  }

  onKeyboardTap(String v) {
    keyboardValue = keyboardValue! + v;
    final updated = ((progressPercent + 0.1).clamp(0.0, 1.0) * 100);
    progressPercent = updated.round() / 100;
    v.isNotEmpty ? changePage(ScreenRegCompanyType.email) : null;
    update();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
