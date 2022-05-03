/// Archivo para exportar todas las funciones de la aplicación
import 'dart:convert';

/// Archivo para exportar todas las funciones de la aplicación
import 'dart:async';

class Utils {
  static const _locale = 'en';

  double roundDouble(dynamic value, int places) {
    // double.parse(value.toStringAsFixed(places));
    return double.parse(value.toStringAsFixed(places));
    // num mod = pow(10.0, places);
    // return ((value * mod).floorToDouble().toDouble() / mod);
  }

  /// Formato para Numeros.
  ///
  /// [value] Valor del numero.
  ///
  /// [decimals] decimales para el formato, por defecto 2 decimales.
  numberFormat(dynamic value,
      [int decimals = 2,
      String separadorDecimales = ',',
      String separadorMiles = '.',
      bool bSing = false,
      String additionalString = '']) {
        if(value==null)return '--';
    var signo = (bSing && value > 0) ? '+' : '';

    value = roundDouble(value, decimals);
    var tmp = value.toString().split('.');

    var numero = tmp[0];
    var decimales = tmp[1];

    separadorDecimales = (separadorDecimales == '') ? ',' : separadorDecimales;
    separadorMiles = (separadorMiles == '') ? '.' : separadorMiles;

    var miles = RegExp("(-?[0-9]+)([0-9]{3})");
    while (numero.contains(miles)) {
      miles.allMatches(numero).forEach((match) {
        numero = numero.replaceAll(
            miles,
            match.group(1).toString() +
                separadorMiles +
                match.group(2).toString());
      });
    }

    var numeroFormateado = '';
    if (decimales == '0') {
      numeroFormateado = signo +
          numero +
          separadorDecimales +
          decimales +
          '0' +
          additionalString;
    } else {
      numeroFormateado =
          signo + numero + separadorDecimales + decimales + additionalString;
    }

    return numeroFormateado;
  }

  Timer setTimeout(callback, [int duration = 1000]) {
    return Timer(Duration(milliseconds: duration), callback);
  }

  void clearTimeout(Timer t) {
    t.cancel();
  }

  String base64Instrument(String codeInstrument) {
    String encodedInstrument = base64.encode(utf8.encode(codeInstrument));
    return encodedInstrument;
  }
   double checkDouble(dynamic value) {
    if (value is String) {
      return double.parse(value);
    } else {
      return value.toDouble();
    }
  }

  }

 

