import 'package:find_me/constants/app_colors.dart';
import 'package:flutter/material.dart';

TextStyle text(double sp, {FontWeight? fw, Color? color,TextDecoration? decoration, bool? isDisplayFont = false}) {

  return TextStyle(
    color: color ?? kTextDarkGrayColor,
    fontSize: sp,
      fontFamily: isDisplayFont! ? '.SF UI Display' : '.SF UI Text',
    fontWeight: fw ?? FontWeight.w400,
    decoration: decoration
  );
}

double kCommonTiny = 10;
double kCommonXTiny = 11;
double kCommonXSmall = 12;
double kCommonSmall = 14;
double kCommonXXSmall = 15;
double kCommonMedium = 16;
double kCommonXMedium = 17;
double kCommonLarge = 18;
double kCommonXLarge = 20;
double kCommonXXLarge = 22;
double kCommonXXXLarge = 24;
double kCommonXXXXLarge = 28;
double kCommonXXXXXLarge = 34;

FontWeight kBold = FontWeight.w700;
