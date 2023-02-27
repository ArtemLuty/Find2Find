import 'package:flutter/material.dart';

//Text color
const Color kTextMainColor = Color(0xFF4A4A4A);
const Color kTextGrayColor = Color(0xFFA4A4A4);
const Color kTextDarkGrayColor = Color(0xFF939393);
const Color kTextLightGrayColor = Color(0xFFC5CAD3);
const Color kTextLightXGrayColor = Color(0xFFF8F9FA);
const Color kTextWhiteColor = Color(0xFFFFFFFF);
const Color kTextBlueColor = Color(0xFF15B0BA);

//Gradient color
LinearGradient kGradColor = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFD8EFC1),
      Color(0xFF26BBC5),
    ],
    stops: [
      0.0,
      0.9
    ]);
