import 'package:find_me/constants/app_colors.dart';
import 'package:find_me/ui/widgets/base_screen_log_&_reg_contents.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

Widget buildNameContent({
  TextEditingController? controller,
  String? hintText,
  String? labelText,
  Key? key,
  FormFieldValidator<String>? validator,
  String? buttonName,
  void Function(String)? onChanged,
  void Function()? onPressed,
}) {
  return baseWidget(
    controller: controller,
    hintText: hintText,
    key: key,
    validator: validator,
    isBorderSide: true,
    labelText: labelText,
    inputFormatters: [BlacklistingTextInputFormatter(RegExp("[0-9]"))],
    textCapitalization: TextCapitalization.sentences,
    onChanged: onChanged,
    buttonName: buttonName,
    onPressed: onPressed,
  );
}

Widget buildPhoneContent({
  TextEditingController? controller,
  String? title,
  Key? key,
  String? buttonName,
  void Function(PhoneNumber)? onChanged,
  void Function()? onPressed,
}) {
  return basePhoneNumber(
    key: key,
    onPressed: onPressed,
    title: title,
    controller: controller,
    onChanged: onChanged,
    buttonName: buttonName,
  );
}

Widget buildVerifyPhoneContent(
    {String? title,
    String? phoneTitle,
    Key? key,
    String? linkName,
    TextEditingController? controller,
    dynamic Function()? onPressedLink,
    dynamic Function()? onCompleted,
    void Function(String)? onKeyboardTap}) {
  return baseVerifyPhone(
    title: title,
    phoneTitle: phoneTitle,
    linkName: linkName,
    controller: controller,
    key: key,
    onKeyboardTap: onKeyboardTap,
    onPressedLink: onPressedLink,
    onCompleted: onCompleted,
  );
}

Widget buildEmailContent(
    {Key? key,
    TextEditingController? controller,
    String? title,
    String? buttonName,
    String? hintText,
    String? labelText,
    FormFieldValidator<String>? validator,
    void Function(String)? onChanged,
    void Function()? onPressed}) {
  return baseEmail(
    key: key,
    title: title,
    buttonName: buttonName,
    hintText: hintText,
    labelText: labelText,
    validator: validator,
    textCapitalization: TextCapitalization.none,
    onPressed: onPressed,
    onChanged: onChanged,
    controller: controller,
  );
}
