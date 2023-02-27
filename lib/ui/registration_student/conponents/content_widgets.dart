import 'package:find_me/constants/app_routes.dart';
import 'package:find_me/data/services/local_auth_service.dart';
import 'package:find_me/enums/register_enum.dart';
import 'package:find_me/ui/registration_student/registration_student_controller.dart';
import 'package:find_me/ui/utils/regexp.dart';
import 'package:find_me/ui/utils/utils.dart';
import 'package:find_me/ui/widgets/base_content_widgets.dart';
import 'package:find_me/ui/widgets/base_screen_log_&_reg_contents.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

Widget buildDateSContent() {
  var maskFormatter = new MaskTextInputFormatter(
      mask: "##/##/####", filter: {"#": RegExp(r'[0-9]')});
  return GetBuilder<RegStudentController>(
      init: RegStudentController(),
      builder: (rC) {
        return baseWidget(
          inputFormatters: [maskFormatter],
          controller: rC.dateSController,
          isReadOnly: true,
          isDob: true,
          onTap: () async {
            var result = await getDatePicker(
              Get.context!,
              DateTime.now(),
              firstDate: DateTime(1930),
              lastDate: DateTime.now(),
            );
            rC.dateSController.text = dateFormatFromDate(result!);
            rC.update();
          },
          textCapitalization: TextCapitalization.characters,
          keyboardType: TextInputType.phone,
          isBorderSide: true,
          hintText: 'D D / M M / Y Y Y Y',
          labelText: rC.dateSController.text.isNotEmpty ? 'Date' : null,
          onChanged: (v) {
            v = rC.dateSController.text;
            rC.update();
          },
          buttonName: 'CONTINUE',
          onPressed: rC.dateSController.text.isNotEmpty
              ? () {
                  final updated =
                      ((rC.progressPercent + 0.1).clamp(0.0, 1.0) * 100);
                  rC.progressPercent = updated.round() / 100;
                  rC.update();
                  FocusManager.instance.primaryFocus?.unfocus();
                  rC.changePage(ScreenRegStudentType.postCode);
                }
              : null,
        );
      });
}

Widget buildEmailSContent() {
  return GetBuilder<RegStudentController>(
    builder: (rSC) {
      return buildEmailContent(
          key: rSC.formKeyEmail,
          controller: rSC.emailSController,
          title:
              'Please don\'t forget to verify your email to keep your account secure.',
          buttonName: 'CONTINUE',
          hintText: 'Enter your email',
          validator: (value) {
            if (!rSC.isEmailValid()) {
              return "Incorrect email";
            }
            return null;
          },
          labelText:
              rSC.emailSController.text.isNotEmpty ? 'Enter your email' : null,
          onChanged: (v) {
            v = rSC.emailSController.text;
            rSC.update();
          },
          onPressed: rSC.emailSController.text.isNotEmpty
              ? () async {
                  rSC.formKeyEmail.currentState!.validate();
                  if (rSC.isEmailValid()) {
                    final updated =
                        ((rSC.progressPercent + 0.1).clamp(0.0, 1.0) * 100);
                    rSC.progressPercent = updated.round() / 100;
                    FocusManager.instance.primaryFocus?.unfocus();
                    await rSC.registerStudent();
                    Get.offNamed(RoutePaths.CookiesConsent);
                  } else {
                    showToast("Incorrect email");
                  }
                }
              : null);
    },
  );
}

Widget buildFirstNameSContent() {
  return GetBuilder<RegStudentController>(
      init: RegStudentController(),
      builder: (rC) {
        return baseWidget(
          key: rC.formKeyFirstName,
          controller: rC.nameFirstSController,
          textCapitalization: TextCapitalization.sentences,
          hintText: 'First Name',
          isBorderSide: true,
          validator: (value) {
            if (value!.trim().isEmpty || value.trim().length < 2) {
              return "Incorrect first name";
            }
            return null;
          },
          inputFormatters: [BlacklistingTextInputFormatter(RegExp("[0-9]"))],
          labelText:
              rC.nameFirstSController.text.isNotEmpty ? 'First Name' : null,
          onChanged: (v) {
            v = rC.nameFirstSController.text;
            rC.update();
          },
          buttonName: 'CONTINUE',
          onPressed: rC.nameFirstSController.text.isNotEmpty
              ? () {
                  rC.formKeyFirstName.currentState!.validate();
                  if (rC.isFirstNameValid()) {
                    final updated =
                        ((rC.progressPercent + 0.1).clamp(0.0, 1.0) * 100);
                    rC.progressPercent = updated.round() / 100;
                    FocusManager.instance.primaryFocus?.unfocus();
                    rC.changePage(ScreenRegStudentType.lastName);
                  } else {
                    showToast('Incorrect first name');
                  }
                }
              : null,
        );
      });
}

Widget buildLastNameSContent() {
  return GetBuilder<RegStudentController>(
      init: RegStudentController(),
      builder: (rC) {
        return baseWidget(
          key: rC.formKeyLastName,
          controller: rC.nameLastSController,
          hintText: 'Last Name',
          textCapitalization: TextCapitalization.sentences,
          validator: (value) {
            if (value!.trim().isEmpty || value.trim().length < 2) {
              return "Incorrect last name";
            }
            return null;
          },
          isBorderSide: true,
          inputFormatters: [BlacklistingTextInputFormatter(RegExp("[0-9]"))],
          labelText:
              rC.nameLastSController.text.isNotEmpty ? 'Last Name' : null,
          onChanged: (v) {
            v = rC.nameLastSController.text;
            rC.update();
          },
          buttonName: 'CONTINUE',
          onPressed: rC.nameLastSController.text.isNotEmpty
              ? () {
                  rC.formKeyLastName.currentState!.validate();
                  if (rC.isLastNameValid()) {
                    final updated =
                        ((rC.progressPercent + 0.1).clamp(0.0, 1.0) * 100);
                    rC.progressPercent = updated.round() / 100;
                    FocusManager.instance.primaryFocus?.unfocus();
                    rC.changePage(ScreenRegStudentType.dateOfBirth);
                  } else {
                    showToast('Incorrect last name');
                  }
                }
              : null,
        );
      });
}

Widget buildPhoneNumberSContent() {
  return GetBuilder<RegStudentController>(
    builder: (rSC) {
      return buildPhoneContent(
        key: rSC.formKeyPhone,
        controller: rSC.phoneSController,
        title: 'Your phone number will be used to log into the app.',
        onChanged: (v) {
          // v = rSC.phoneSController.text;
          rSC.update();
        },
        buttonName: 'CONTINUE',
        onPressed: rSC.phoneSController.text.isNotEmpty
            ? () async {
                rSC.formKeyPhone.currentState!.validate();
                if (rSC.isPhoneValid()) {
                  if (await rSC.sendOtpSms()) {
                    final updated =
                        ((rSC.progressPercent + 0.1).clamp(0.0, 1.0) * 100);
                    rSC.progressPercent = updated.round() / 100;
                    FocusManager.instance.primaryFocus?.unfocus();
                    rSC.showNotification();
                    rSC.changePage(ScreenRegStudentType.verifyPhone);
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

Widget buildPostCodeSContent() {
  var maskFormatter = new MaskTextInputFormatter(
      mask: "#####", filter: {"#": RegExp(r'[0-9]')});
  return GetBuilder<RegStudentController>(
      init: RegStudentController(),
      builder: (rC) {
        return baseWidget(
          key: rC.formKeyPostcode,
          controller: rC.postCodeSController,
          inputFormatters: [maskFormatter],
          keyboardType: TextInputType.phone,
          textCapitalization: TextCapitalization.characters,
          isBorderSide: true,
          validator: (value) {
            if (value!.trim().isEmpty ||
                !numberRegexp.hasMatch(value.trim()) ||
                value.trim().length != 5) {
              return "Incorrect postcode";
            }
            return null;
          },
          hintText: 'Postcode',
          labelText: rC.postCodeSController.text.isNotEmpty ? 'Postcode' : null,
          onChanged: (v) {
            v = rC.postCodeSController.text;
            rC.update();
          },
          buttonName: 'CONTINUE',
          onPressed: rC.postCodeSController.text.isNotEmpty
              ? () {
                  rC.formKeyPostcode.currentState!.validate();
                  if (rC.isPostCodeValid()) {
                    final updated =
                        ((rC.progressPercent + 0.1).clamp(0.0, 1.0) * 100);
                    rC.progressPercent = updated.round() / 100;
                    FocusManager.instance.primaryFocus?.unfocus();
                    rC.changePage(ScreenRegStudentType.school);
                  } else {
                    showToast("Incorrect postcode");
                  }
                }
              : null,
        );
      });
}

Widget buildVerifyPhoneSContent() {
  return GetBuilder<RegStudentController>(
    builder: (rSC) {
      return buildVerifyPhoneContent(
        title: 'Enter the code we\'ve sent you by text to',
        linkName: 'Send again',
        phoneTitle: rSC.phoneSController.text,
        key: rSC.formKeyVerifyPhone,
        controller: rSC.verifyPhoneSController,
        onCompleted: () async {
          rSC.formKeyVerifyPhone.currentState!.validate();
          if (rSC.isVerifyPhoneValid()) {
            if (await rSC.checkOtpSms()) {
              rSC.changePage(ScreenRegStudentType.email);
            } else {
              showToast('Code is wrong');
            }
          } else {
            showToast('Code is wrong');
          }
        },
        onPressedLink: () async {
          rSC.verifyPhoneSController.clear();
          await rSC.sendOtpSms();
        },
      );
    },
  );
}
