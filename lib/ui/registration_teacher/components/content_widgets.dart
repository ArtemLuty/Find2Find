import 'package:find_me/constants/app_routes.dart';
import 'package:find_me/enums/register_enum.dart';
import 'package:find_me/ui/registration_teacher/registration_teacher_controller.dart';
import 'package:find_me/ui/utils/utils.dart';
import 'package:find_me/ui/widgets/base_content_widgets.dart';
import 'package:find_me/ui/widgets/base_content_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget buildFirstNameTContent() {
  return GetBuilder<RegTeacherController>(
    builder: (rTC) {
      return buildNameContent(
        key: rTC.formKeyFirstName,
        validator: (value) {
          if (value!.trim().isEmpty || value.trim().length < 2) {
            return "Incorrect first name";
          }
          return null;
        },
        controller: rTC.nameTFirstController,
        hintText: 'First name',
        labelText:
            rTC.nameTFirstController.text.isNotEmpty ? 'First Name' : null,
        onChanged: (v) {
          v = rTC.nameTFirstController.text;
          rTC.update();
        },
        buttonName: 'CONTINUE',
        onPressed: rTC.nameTFirstController.text.isNotEmpty
            ? () {
                rTC.formKeyFirstName.currentState!.validate();
                if (rTC.isFirstNameValid()) {
                  final updated =
                  ((rTC.progressPercent + 0.1).clamp(0.0, 1.0) * 100);
                  rTC.progressPercent = updated.round() / 100;
                  rTC.update();
                  FocusManager.instance.primaryFocus?.unfocus();
                  rTC.changePage(ScreenRegTeacherType.lastName);
                } else {
                  showToast('Incorrect first name');
                }
              }
            : null,
      );
    },
  );
}

Widget buildLastNameTContent() {
  return GetBuilder<RegTeacherController>(
    builder: (rTC) {
      return buildNameContent(
        key: rTC.formKeyLastName,
        validator: (value) {
          if (value!.trim().isEmpty || value.trim().length < 2) {
            return "Incorrect last name";
          }
          return null;
        },
        controller: rTC.nameTLastController,
        hintText: 'Last name',
        labelText: rTC.nameTLastController.text.isNotEmpty ? 'Last Name' : null,
        onChanged: (v) {
          v = rTC.nameTLastController.text;
          rTC.update();
        },
        buttonName: 'CONTINUE',
        onPressed: rTC.nameTLastController.text.isNotEmpty
            ? () {
                rTC.formKeyLastName.currentState!.validate();
                if (rTC.isLastNameValid()) {
                  final updated =
                  ((rTC.progressPercent + 0.2).clamp(0.0, 1.0) * 100);
                  rTC.progressPercent = updated.round() / 100;
                  rTC.update();
                  FocusManager.instance.primaryFocus?.unfocus();
                  rTC.changePage(ScreenRegTeacherType.phoneNumber);
                } else {
                  showToast('Incorrect last name');
                }
              }
            : null,
      );
    },
  );
}

Widget buildPhoneNumberTContent() {
  return GetBuilder<RegTeacherController>(
    builder: (rTC) {
      return buildPhoneContent(
        key: rTC.formKeyPhone,
        controller: rTC.phoneTController,
        title: 'Your phone number will be used to log into the app.',
        onChanged: (v) {
          // v = rTC.phoneTController.text;
          rTC.update();
        },
        buttonName: 'CONTINUE',
        onPressed: rTC.phoneTController.text.isNotEmpty
            ? () async {
                rTC.formKeyPhone.currentState!.validate();
                if (rTC.isPhoneValid()) {
                  if (await rTC.sendOtpSms()) {
                    final updated =
                    ((rTC.progressPercent + 0.1).clamp(0.0, 1.0) * 100);
                    rTC.progressPercent = updated.round() / 100;
                    rTC.update();
                    FocusManager.instance.primaryFocus?.unfocus();
                    rTC.changePage(ScreenRegTeacherType.verifyPhone);
                  }
                } else {
                  showToast("Incorrect phone number");
                }
              }
            : null,
      );
    },
  );
}

Widget buildPhoneVerifyTContent() {
  return GetBuilder<RegTeacherController>(
    builder: (rTC) {
      return buildVerifyPhoneContent(
        title: 'Enter the code we\'ve sent you by text to',
        linkName: 'Send again',
        phoneTitle: rTC.phoneTController.text,
        controller: rTC.verifyTPhoneController,
        key: rTC.formKeyVerifyPhone,
        onCompleted: () async {
          rTC.formKeyVerifyPhone.currentState!.validate();
          if (rTC.isVerifyPhoneValid()) {
            if (await rTC.checkOtpSms()) {
              rTC.changePage(ScreenRegTeacherType.email);
            } else {
              showToast('Code is wrong');
            }
          } else {
            showToast('Code is wrong');
          }
        },
        onPressedLink: () async {
          rTC.verifyTPhoneController.clear();
          await rTC.sendOtpSms();
        },
      );
    },
  );
}

Widget buildETContent() {
  return GetBuilder<RegTeacherController>(
    builder: (rTC) {
      return buildEmailContent(
        controller: rTC.emailTController,
        key: rTC.formKeyEmail,
        validator: (value) {
          if (!rTC.isEmailValid()) {
            return "Incorrect email";
          }
          return null;
        },
        title:
            'Please don\'t forget to verify your email to keep your account secure.',
        buttonName: 'CONTINUE',
        hintText: 'Enter your email',
        labelText:
            rTC.emailTController.text.isNotEmpty ? 'Enter your email' : null,
        onChanged: (v) {
          v = rTC.emailTController.text;
          rTC.update();
        },
        onPressed: rTC.emailTController.text.isNotEmpty
            ? () async {
                rTC.formKeyEmail.currentState!.validate();
                if (rTC.isEmailValid()) {
                  FocusManager.instance.primaryFocus?.unfocus();
                  await rTC.registerTeacher();
                  Get.offNamed(RoutePaths.CookiesConsent);
                } else {
                  showToast('Incorrect email');
                }
              }
            : null,
      );
    },
  );
}
