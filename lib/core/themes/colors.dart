import 'package:flutter/material.dart';

class CuriosityColors {
  static const Color dark           = Color(0xff0A0908);
  static const Color blackbeige     = Color(0xff1B1B1D);
  static const Color mirage         = Color(0xff919599);
  static const Color graychetau     = Color(0xff1A212B);
  static const Color gray           = Color(0xff9B9B9B);
  static const Color beige          = Color(0xffFFE9C5);
  static const Color aquagreen      = Color(0xffB4F2E1);
  static const Color orangered      = Color(0xffFA9191);
  static const Color red            = Color(0xffFF5651);
  static const Color crystalblue    = Color(0xff5AB2FF);
  static const Color white          = Color.fromARGB(255, 255, 255, 255);
  static const Color  riverBed      = Color(0xff494F57);
  static const Color  mountainMist  = Color(0xff919599);
  static const Color  soapstone     = Color(0xffFAFCFC);
  static const Color  dark2         = Color(0xff1A212B);
  static const Color  sunsetOrange  = Color(0xffFF5651);
  static const Color  smokeyGrey    = Color(0xff6B7076);
  static const Color  plate         = Color(0xff1F374E);
  static LinearGradient get gradientDefaultChart  => _getGradientChart(crystalblue);
  static LinearGradient _getGradientChart( Color ? color ) {
    return LinearGradient(
      begin: const Alignment(0,-0.72),
      end: const Alignment(0,1.62),
      colors: [
        color!.withOpacity(0.6),
        color.withOpacity(0),
      ]
    );
  }
}
