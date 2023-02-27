import 'package:find_me/enums/register_enum.dart';
import 'package:find_me/ui/sign_in/sign_in_controller.dart';
import 'package:find_me/ui/utils/regexp.dart';
import 'package:find_me/ui/utils/utils.dart';
import 'package:find_me/ui/widgets/base_content_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget buildEmailLEContent() {
  return GetBuilder<SignInController>(
    builder: (lEC) {
      return buildEmailContent(
        key: lEC.formKeyEmail,
        controller: lEC.emailLController,
        validator: (value) {
          if (value!.trim().isEmpty || !emailRegexp.hasMatch(value.trim())) {
            return "Incorrect email";
          }
          return null;
        },
        title:
            'We\'ll send you an authentication code to your email if it belongs to an existing account.',
        buttonName: 'CONTINUE',
        hintText: 'Enter your email',
        labelText:
            lEC.emailLController.text.isNotEmpty ? 'Enter your email' : null,
        onChanged: (v) {
          v = lEC.emailLController.text;
          lEC.update();
        },
        onPressed: lEC.emailLController.text.isNotEmpty
            ? () async {
                lEC.formKeyEmail.currentState!.validate();
                if (lEC.isEmailValid()) {
                  if (await lEC.sendOtpEmail()) {
                    final updated =
                    ((lEC.progressPercent + 0.4).clamp(0.0, 1.0) * 100);
                    lEC.progressPercent = updated.round() / 100;
                    FocusManager.instance.primaryFocus?.unfocus();
                    lEC.changeEmailPage(ScreenSignInType.verifyEmail);
                    lEC.update();
                  }
                } else {
                  showToast("Incorrect email");
                }
              }
            : null,
      );
    },
  );
}

Widget buildPhoneNumberLPContent() {
  return GetBuilder<SignInController>(
    builder: (lPC) {
      return buildPhoneContent(
        key: lPC.formKeyPhone,
        controller: lPC.phoneLController,
        title: 'You will receive a code via SMS.',
        onChanged: (v) {
          // v = lPC.phoneLController.text;
          lPC.update();
        },
        buttonName: 'CONTINUE',
        onPressed: lPC.phoneLController.text.isNotEmpty
            ? () async {
                lPC.formKeyPhone.currentState!.validate();
                if (lPC.isPhoneValid()) {
                  if (await lPC.sendOtpSmsSignIn()) {
                    final updated =
                    ((lPC.progressPercent + 0.4).clamp(0.0, 1.0) * 100);
                    lPC.progressPercent = updated.round() / 100;
                    FocusManager.instance.primaryFocus?.unfocus();
                    lPC.changePhonePage(ScreenSignInType.verifyPhone);
                    lPC.update();
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

Widget buildVerifyPhoneLContent() {
  return GetBuilder<SignInController>(
    builder: (lPC) {
      return buildVerifyPhoneContent(
        title: 'Enter the code we\'ve sent you by text to',
        linkName: 'Send again',
        key: lPC.formKeyPhoneVerify,
        controller: lPC.verifyPhoneLController,
        phoneTitle: lPC.phoneLController.text,
        onCompleted: () async {
          lPC.formKeyPhoneVerify.currentState!.validate();
          if (lPC.isVerifyPhoneValid()) {
            if (await lPC.checkOtpSmsSignIn()) {
              lPC.keyboardPValue = lPC.keyboardPValue!
                  .substring(0, lPC.keyboardPValue!.length - 1);
              lPC.update();
            } else {
              showToast("Wrong code");
            }
          } else {
            showToast("Wrong code");
          }
        },
        onPressedLink: () async {
          lPC.verifyPhoneLController.clear();
          await lPC.sendOtpSmsSignIn();
        },
      );
    },
  );
}

Widget buildVerifyEmailLContent() {
  return GetBuilder<SignInController>(
    builder: (lPC) {
      return buildVerifyPhoneContent(
        title: 'Enter the code we\'ve sent you by email.',
        linkName: 'Send again',
        key: lPC.formKeyEmailVerify,
        controller: lPC.verifyEmailLController,
        onCompleted: () async {
          lPC.formKeyEmailVerify.currentState!.validate();
          if (lPC.isVerifyEmailValid()) {
            if (await lPC.checkOtpEmail()) {
              lPC.keyboardEValue = lPC.keyboardEValue!
                  .substring(0, lPC.keyboardEValue!.length - 1);
              lPC.update();
            } else {
              showToast("Wrong code");
            }
          } else {
            showToast("Wrong code");
          }
        },
        onPressedLink: () async {
          lPC.verifyEmailLController.clear();
          await lPC.sendOtpEmail();
        },
      );
    },
  );
}
