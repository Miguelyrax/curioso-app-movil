
import 'package:flutter/material.dart';

void customSnackBar(BuildContext context,{String texto='Error del servidor, vuelva a intentarlo mas tarde'}){
      final snackBar = SnackBar(
      content:  Text(texto),
      action: SnackBarAction(
        label: 'Ok',
        onPressed: () {},
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
}