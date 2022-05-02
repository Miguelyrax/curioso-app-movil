/// Archivo que contiene todos los títulos
///

import 'package:curioso_app/core/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CuriosityTitles {

  static const Color _defaultColorTitle =CuriosityColors.white; 

  CuriosityTitles();

  static TextStyle get textBase => GoogleFonts.workSans(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: _defaultColorTitle
  );

  static TextStyle get headline1 => textBase.copyWith(
    fontSize: 36,
  );

  static TextStyle get headline2 => textBase.copyWith(
    fontSize: 28,
  );

  static TextStyle get headline3 => textBase.copyWith(
    fontSize: 20,
  );

  static TextStyle get headline4 => textBase.copyWith(
    fontSize: 18,
  );

  static TextStyle get headline5 => textBase.copyWith(
    fontSize: 16,
  );

  static TextStyle get headline6 => textBase.copyWith(
    fontSize: 14,
  );

  static TextStyle get subtitle1 => textBase.copyWith(
    fontSize: 16,
    color: _defaultColorTitle
  );

  static TextStyle get bodyText1 => textBase.copyWith(
    fontSize: 16,
    color: _defaultColorTitle
  );
  
  static TextStyle get bodyText2 => textBase.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: _defaultColorTitle
  );

}
