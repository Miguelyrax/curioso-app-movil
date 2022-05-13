import 'package:curioso_app/core/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class CuriosityCustomButtons {

  static ButtonStyle get elevatedButton {
    return ButtonStyle(
      textStyle: MaterialStateProperty.all(GoogleFonts.workSans(
        fontSize: 24,
        fontWeight: FontWeight.w600
      )),
      foregroundColor: MaterialStateProperty.resolveWith<Color>((states) {
        if (states.contains(MaterialState.disabled)) {
          return CuriosityColors.smokeyGrey; // Disabled color
        }
        return CuriosityColors.dark; // Regular color
      }),
      backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
        if (states.contains(MaterialState.disabled)) {
          return CuriosityColors.graychetau; // Disabled color
        }
        return CuriosityColors.beige; // Regular color
      }),
      shape: MaterialStateProperty.all(RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.0),
      )),
    );
  }

  static ButtonStyle get outlinedButton {
    return ButtonStyle(
      textStyle: MaterialStateProperty.all(GoogleFonts.workSans(
        fontSize: 24,
        fontWeight: FontWeight.bold
      )),
      minimumSize: MaterialStateProperty.all(const Size( 117.0, 40.0 )),
      foregroundColor: MaterialStateProperty.all( CuriosityColors.beige ),
      backgroundColor: MaterialStateProperty.all( Colors.transparent ),
      shape: MaterialStateProperty.all(RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.0),
      )),
      side: MaterialStateProperty.resolveWith<BorderSide>(
        (Set<MaterialState> states) {
          return const BorderSide(
              color: CuriosityColors.beige,
              width: 1,
          ); // Defer to the widget's default.
        },
      ),
    );
  }

  static ButtonStyle get textButton {
    return TextButton.styleFrom(
      primary: CuriosityColors.orangered, 
    );
  }
}