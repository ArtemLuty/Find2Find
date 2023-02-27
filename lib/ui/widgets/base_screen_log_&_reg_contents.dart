import 'package:find_me/constants/app_colors.dart';
import 'package:find_me/constants/app_styles.dart';
import 'package:find_me/ui/utils/regexp.dart';
import 'package:find_me/ui/widgets/app_button.dart';
import 'package:find_me/ui/widgets/app_numeric_keyboard.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

Widget baseWidget(
    {TextEditingController? controller,
    String? hintText,
    Key? key,
    String? labelText,
    String? buttonName,
    bool? isBorderSide,
    bool isReadOnly = false,
    InputBorder? inputBorder,
    TextStyle? styleField,
    FormFieldValidator<String>? validator,
    Function? onTap,
    bool isDob = false,
    TextCapitalization? textCapitalization,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    void Function(String)? onChanged,
    void Function()? onPressed}) {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.only(left: 18.0, right: 14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Form(
                key: key,
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 50.0, left: 60.0, right: 60.0),
                  child: TextFormField(
                    controller: controller,
                    inputFormatters: inputFormatters,
                    readOnly: isReadOnly,
                    validator: validator,
                    textCapitalization: textCapitalization!,
                    style: text(kCommonXXLarge, color: kTextMainColor),
                    keyboardType: keyboardType,
                    onTap: () {
                      if (isDob) {
                        onTap!();
                      }
                    },
                    decoration: InputDecoration(
                      hintText: hintText,
                      labelText: labelText,
                      labelStyle: text(kCommonXTiny, color: kTextGrayColor),
                      hintStyle: text(kCommonXXLarge,
                          color: kTextGrayColor, isDisplayFont: true),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            width: 2,
                            color: isBorderSide!
                                ? kTextGrayColor
                                : Colors.transparent),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            width: 2,
                            color: isBorderSide
                                ? kTextGrayColor
                                : Colors.transparent),
                      ),
                    ),
                    onChanged: onChanged,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 38.0, top: 4.0),
            child: AppButton(
              type: AppButtonType.GradientBtn,
              name: buttonName,
              onPressed: onPressed,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget basePhoneNumber(
    {Key? key,
    TextEditingController? controller,
    String? title,
    String? buttonName,
    // List<TextInputFormatter>? inputFormatters,
    void Function(PhoneNumber)? onChanged,
    void Function()? onPressed}) {
  return Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            children: [
              SizedBox(height: 30),
              Text(title!, style: text(kCommonXXSmall, color: kTextMainColor)),
              SizedBox(height: 30),
              Form(
                key: key,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: [
                      Container(
                        width: Get.width,
                        child: InternationalPhoneNumberInput(
                          maxLength: 14,
                          autoFocus: true,
                          ignoreBlank: true,
                          keyboardType: TextInputType.number,
                          spaceBetweenSelectorAndTextField: 0,
                          // cursorColor: getAccentColor(context),
                          hintText: 'loginEnterPhoneNumber'.tr,
                          // initialValue: PhoneNumber(isoCode: 'DE'),
                          locale: Get.deviceLocale?.languageCode,
                          autoValidateMode: AutovalidateMode.disabled,
                          textFieldController: controller,
                          // selectorTextStyle: Theme.of(context).inputDecorationTheme.prefixStyle,
                          inputDecoration: InputDecoration(
                            border: InputBorder.none,
                            errorBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                            // focusColor: getAccentColor(context),
                            contentPadding: EdgeInsets.zero,
                            suffixIcon: MaterialButton(
                              minWidth: 10,
                              elevation: 0.0,
                              focusElevation: 0.0,
                              hoverElevation: 0.0,
                              disabledElevation: 0.0,
                              highlightElevation: 0.0,
                              padding: EdgeInsets.zero,
                              child: Icon(Icons.clear,
                                  color: Colors.grey, size: 22),
                              shape: CircleBorder(),
                              onPressed: () {
                                controller?.clear();
                              },
                            ),
                          ),
                          selectorConfig: SelectorConfig(
                            setSelectorButtonAsPrefixIcon: true,
                            selectorType: PhoneInputSelectorType.DIALOG,
                          ),
                          validator: (value) {
                            if (value!.trim().isEmpty ||
                                !numberRegexp.hasMatch(value.trim()) ||
                                value.trim().length < 10 ||
                                value.trim().length > 14) {
                              return "Incorrect phone number";
                            }
                            return null;
                          },
                          onFieldSubmitted: (String number) {},
                          onInputChanged: onChanged,
                        ),
                      ),
                      Container(
                        color: kTextMainColor,
                        width: Get.width,
                        height: 1,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 38.0, top: 4.0),
          child: AppButton(
              type: AppButtonType.GradientBtn,
              name: buttonName,
              onPressed: onPressed),
        ),
      ],
    ),
  );
}

Widget baseVerifyPhone(
    {String? title,
    Key? key,
    String? phoneTitle,
    TextEditingController? controller,
    String? linkName,
    void Function()? onPressedLink,
    dynamic Function()? onCompleted,
    void Function(String)? onKeyboardTap}) {
  return Expanded(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 60.0, right: 60),
              child: RichText(
                text: TextSpan(
                    text: '$title ',
                    style: text(kCommonXXSmall, color: kTextMainColor),
                    children: <TextSpan>[
                      phoneTitle != null
                          ? TextSpan(
                              text: ' $phoneTitle.',
                              style: text(kCommonXXSmall,
                                  color: kTextMainColor, fw: kBold),
                              recognizer: TapGestureRecognizer()..onTap = () {})
                          : TextSpan()
                    ]),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 0.0, right: 0.0),
          child: Container(
            width: Get.height,
            child: Form(
              key: key,
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
                  child: AbsorbPointer(
                    child: PinCodeTextField(
                      appContext: Get.context!,
                      controller: controller,
                      length: 4,
                      textStyle: text(kCommonXXXXXLarge,
                          color: kTextMainColor, isDisplayFont: true),
                      animationType: AnimationType.fade,
                      validator: (v) {
                        if (v!.length < 3) {
                          return "I'm from validator";
                        } else {
                          return null;
                        }
                      },
                      pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(15),
                          fieldHeight: 70,
                          fieldWidth: 70,
                          activeColor: Colors.transparent,
                          inactiveColor: Colors.transparent,
                          selectedColor: kTextBlueColor,
                          selectedFillColor: kTextLightXGrayColor,
                          activeFillColor: kTextLightXGrayColor,
                          inactiveFillColor: kTextLightXGrayColor),
                      cursorColor: Colors.black,
                      animationDuration: Duration(milliseconds: 300),
                      enableActiveFill: true,
                      onCompleted: (v) {
                        onCompleted!();
                      },
                      onChanged: (value) {
                        print(value);
                      },
                      beforeTextPaste: (text) {
                        print("Allowing to paste $text");
                        return true;
                      },
                    ),
                  )),
            ),
          ),
        ),
        KeyPad(
          pinController: controller,
          isPinLogin: true,
          onChange: (String pin) {
            controller!.text = pin;
            print('${controller.text}');
          },
          onSubmit: (String pin) {
            if (pin.length != 4) {
              return;
            } else {
              controller!.text = pin;
              print('Pin is ${controller.text}');
            }
          },
        ),
        SizedBox(height: 10.0),
        GestureDetector(
            onTap: onPressedLink,
            child: Text(linkName!,
                style: text(kCommonLarge, color: kTextBlueColor))),
        SizedBox(height: 11.0),
      ],
    ),
  );
}

Widget baseEmail(
    {Key? key,
    TextEditingController? controller,
    String? title,
    String? buttonName,
    String? hintText,
    FormFieldValidator<String>? validator,
    TextCapitalization? textCapitalization,
    String? labelText,
    void Function(String)? onChanged,
    void Function()? onPressed}) {
  return Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            children: [
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 62.0, right: 52.0),
                child: Text(title!,
                    style: text(kCommonXXSmall, color: kTextMainColor)),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(left: 62.0, right: 52.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Column(
                      children: [
                        Form(
                          key: key,
                          child: TextFormField(
                            textAlignVertical: TextAlignVertical.center,
                            controller: controller,
                            keyboardType: TextInputType.emailAddress,
                            validator: validator,
                            textCapitalization: textCapitalization!,
                            style: text(kCommonXXLarge, color: kTextMainColor),
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(3.0),
                                hintText: hintText,
                                labelText: labelText,
                                labelStyle:
                                    text(kCommonXTiny, color: kTextGrayColor),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                  width: 2,
                                  color: kTextGrayColor,
                                )),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2, color: kTextGrayColor))),
                            onChanged: onChanged,
                          ),
                        ),
                      ],
                    )),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 38.0, top: 4.0),
          child: AppButton(
              type: AppButtonType.GradientBtn,
              name: buttonName,
              onPressed: onPressed),
        ),
      ],
    ),
  );
}
