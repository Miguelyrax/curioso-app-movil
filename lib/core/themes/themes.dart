/// Archivo para exportar todos los themes de la aplicacion
///
import 'package:curioso_app/core/themes/buttons.dart';
import 'package:curioso_app/core/themes/tiles.dart';
import 'package:flutter/material.dart';

import 'inputs.dart';


class ThemeApp {

  TextTheme get textTheme => TextTheme(
    headline1: CuriosityTitles.headline1,
    headline2: CuriosityTitles.headline2,
    headline3: CuriosityTitles.headline3,
    headline4: CuriosityTitles.headline4,
    headline5: CuriosityTitles.headline5,
    headline6: CuriosityTitles.headline6,
    subtitle1: CuriosityTitles.subtitle1,
    bodyText1: CuriosityTitles.bodyText1,
    bodyText2: CuriosityTitles.bodyText2
  );
  InputDecorationTheme get customInputForm => CuriosityInputs.customInputForm;
  ElevatedButtonThemeData get buttonTheme => ElevatedButtonThemeData(
    style: CuriosityCustomButtons.elevatedButton
  );
  TextButtonThemeData get textButtonTheme => TextButtonThemeData(
    style: CuriosityCustomButtons.textButton
  );
}