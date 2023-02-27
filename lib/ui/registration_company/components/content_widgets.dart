import 'package:find_me/constants/app_routes.dart';
import 'package:find_me/enums/register_enum.dart';
import 'package:find_me/ui/registration_company/registration_company_controller.dart';
import 'package:find_me/ui/utils/utils.dart';
import 'package:find_me/ui/widgets/base_content_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget buildFirstNameCContent() {
  return GetBuilder<RegCompanyController>(
    builder: (rCC) {
      return buildNameContent(
        key: rCC.formKeyFirstName,
        validator: (value) {
          if (value!.trim().isEmpty || value.trim().length < 2) {
            return "Incorrect first name";
          }
          return null;
        },
        controller: rCC.nameFirstCController,
        hintText: 'First name',
        labelText:
            rCC.nameFirstCController.text.isNotEmpty ? 'First Name' : null,
        onChanged: (v) {
          v = rCC.nameFirstCController.text;
          rCC.update();
        },
        buttonName: 'CONTINUE',
        onPressed: rCC.nameFirstCController.text.isNotEmpty
            ? () {
                rCC.formKeyFirstName.currentState!.validate();
                if (rCC.isFirstNameValid()) {
                  final updated =
                  ((rCC.progressPercent + 0.2).clamp(0.0, 1.0) * 100);
                  rCC.update();
                  rCC.progressPercent = updated.round() / 100;
                  FocusManager.instance.primaryFocus?.unfocus();
                  rCC.changePage(ScreenRegCompanyType.lastName);
                } else {
                  showToast('Incorrect first name');
                }
              }
            : null,
      );
    },
  );
}

Widget buildLastNameCContent() {
  return GetBuilder<RegCompanyController>(
    builder: (rCC) {
      return buildNameContent(
        key: rCC.formKeyLastName,
        validator: (value) {
          if (value!.trim().isEmpty || value.trim().length < 2) {
            return "Incorrect last name";
          }
          return null;
        },
        controller: rCC.nameLastCController,
        hintText: 'Last name',
        labelText: rCC.nameLastCController.text.isNotEmpty ? 'Last Name' : null,
        onChanged: (v) {
          v = rCC.nameLastCController.text;
          rCC.update();
        },
        buttonName: 'CONTINUE',
        onPressed: rCC.nameLastCController.text.isNotEmpty
            ? () {
                rCC.formKeyLastName.currentState!.validate();
                if (rCC.isLastNameValid()) {
                  final updated =
                  ((rCC.progressPercent + 0.2).clamp(0.0, 1.0) * 100);
                  rCC.progressPercent = updated.round() / 100;
                  rCC.update();
                  FocusManager.instance.primaryFocus?.unfocus();
                  rCC.changePage(ScreenRegCompanyType.phoneNumber);
                } else {
                  showToast('Incorrect last name');
                }
              }
            : null,
      );
    },
  );
}

Widget buildPhoneNumberCContent() {
  return GetBuilder<RegCompanyController>(
    builder: (rCC) {
      return buildPhoneContent(
        key: rCC.formKeyPhone,
        controller: rCC.phoneCController,
        title: 'Your phone number will be used to log into the app.',
        onChanged: (v) {
          // v = rCC.phoneCController.text;
          rCC.update();
        },
        buttonName: 'CONTINUE',
        onPressed: rCC.phoneCController.text.isNotEmpty
            ? () async {
                rCC.formKeyPhone.currentState!.validate();
                if (rCC.isPhoneValid()) {
                  if (await rCC.sendOtpSms()) {
                    final updated =
                    ((rCC.progressPercent + 0.2).clamp(0.0, 1.0) * 100);
                    rCC.progressPercent = updated.round() / 100;
                    rCC.update();
                    FocusManager.instance.primaryFocus?.unfocus();
                    rCC.changePage(ScreenRegCompanyType.verifyPhone);
                  }
                } else {
                  showToast('Incorrect phone number');
                }
              }
            : null,
      );
    },
  );
}

Widget buildPhoneVerifyCContent() {
  return GetBuilder<RegCompanyController>(
    builder: (rCC) {
      return buildVerifyPhoneContent(
        title: 'Enter the code we\'ve sent you by text to',
        linkName: 'Send again',
        controller: rCC.verifyPhoneCController,
        phoneTitle: rCC.phoneCController.text,
        key: rCC.formKeyValidatePhone,
        onCompleted: () async {
          rCC.formKeyValidatePhone.currentState!.validate();
          if (rCC.isVerifyPhoneValid()) {
            if (await rCC.checkOtpSms()) {
              rCC.changePage(ScreenRegCompanyType.email);
            } else {
              showToast('Code is wrong');
            }
          } else {
            showToast('Code is wrong');
          }
        },
        onPressedLink: () async {
          rCC.verifyPhoneCController.clear();
          await rCC.sendOtpSms();
        },
      );
    },
  );
}

Widget buildECContent() {
  return GetBuilder<RegCompanyController>(
    builder: (rCC) {
      return buildEmailContent(
        key: rCC.formKeyEmail,
        validator: (value) {
          if (!rCC.isEmailValid()) {
            return "Incorrect email";
          }
          return null;
        },
        controller: rCC.emailCController,
        title:
            'Please don\'t forget to verify your email to keep your account secure.',
        buttonName: 'CONTINUE',
        hintText: 'Enter your email',
        labelText:
            rCC.emailCController.text.isNotEmpty ? 'Enter your email' : null,
        onChanged: (v) {
          v = rCC.emailCController.text;
          rCC.update();
        },
        onPressed: rCC.emailCController.text.isNotEmpty
            ? () async {
                rCC.formKeyEmail.currentState!.validate();
                if (rCC.isEmailValid()) {
                  FocusManager.instance.primaryFocus?.unfocus();
                  await rCC.registerCompany();
                  final updated =
                  ((rCC.progressPercent + 0.2).clamp(0.0, 1.0) * 100);
                  rCC.progressPercent = updated.round() / 100;
                  rCC.update();
                  Get.offNamed(RoutePaths.CookiesConsent);
                } else {
                  showToast('Incorrect email number');
                }
              }
            : null,
      );
    },
  );
}
