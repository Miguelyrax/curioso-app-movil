import 'package:curioso_app/core/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class CuriosityInputs {

  static final TextStyle fontText = GoogleFonts.workSans(
    fontSize: 16,
  );

  static final OutlineInputBorder _customBorder = OutlineInputBorder(
      borderSide: const BorderSide(
        color: CuriosityColors.riverBed,
        width: 1,
      ),
      borderRadius: BorderRadius.circular(8),
    );

  static InputDecorationTheme get customInputForm => InputDecorationTheme(
        hintStyle: fontText.copyWith(color: CuriosityColors.mountainMist),
        labelStyle: fontText.copyWith(color: CuriosityColors.soapstone),
        filled: true,
        fillColor: CuriosityColors.dark2,
        border: _customBorder,
        enabledBorder: _customBorder,
        focusedBorder: _customBorder.copyWith(
            borderSide:const BorderSide(
              color: CuriosityColors.crystalblue,
            )
        ),
        errorBorder: _customBorder.copyWith(
            borderSide:const BorderSide(
              color: CuriosityColors.sunsetOrange
            )
        ),
        errorStyle: const TextStyle(
          color: CuriosityColors.sunsetOrange
        ),
        contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 0)

      );

  static RadioThemeData get customRadioButtom => RadioThemeData(
    
    fillColor: MaterialStateProperty.resolveWith((states) {
      if(states.contains(MaterialState.selected)) {
        return CuriosityColors.crystalblue;
      }
      return CuriosityColors.smokeyGrey;
    }),
  );

  static CheckboxThemeData get customCheckbox => CheckboxThemeData(
    fillColor: MaterialStateProperty.resolveWith((states) {
      if(states.contains(MaterialState.selected)) {
        return CuriosityColors.crystalblue;
      }
      return CuriosityColors.smokeyGrey;
    }),
  );

}
