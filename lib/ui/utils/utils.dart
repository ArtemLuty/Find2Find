import 'package:find_me/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

void showToast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black.withOpacity(0.8),
      textColor: Colors.white,
      fontSize: 16.0);
}

Future<DateTime?> getDatePicker(BuildContext context, DateTime initialDate,
    {DateTime? firstDate, DateTime? lastDate}) async {
  return showDatePicker(
      initialDate: initialDate,
      firstDate: firstDate!,
      // locale: Get.deviceLocale,
      lastDate: lastDate!,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: Theme(
              data: ThemeData.light().copyWith(
                colorScheme: ColorScheme.light(primary: kTextBlueColor),
              ),
              child: child!),
        );
      },
      context: context);
}

String dateFormatFromDate(DateTime? date, {bool isTime = false}) {
  if (date == null) return "";

  return isTime
      ? DateFormat.Hm().format(date)
      : DateFormat("dd/MM/yyyy").format(date) ?? '';
}
