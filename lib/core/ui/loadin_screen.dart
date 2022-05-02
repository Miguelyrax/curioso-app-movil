import 'package:curioso_app/core/themes/colors.dart';
import 'package:flutter/material.dart';

import '../../routes.dart';


class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CuriosityColors.dark,
        body: FutureBuilder(
                future:_validateData(),
          builder: (context, snapshot) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.blue,),
       );
          }
        ),
       ),
    );
  }

  Future<void>_validateData()async{
    await Future.delayed(const Duration(seconds: 3));
    AppNavigator.replaceWith(Routes.home);
  }
}