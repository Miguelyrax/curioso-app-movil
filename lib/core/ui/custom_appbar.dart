  import 'package:flutter/material.dart';

import '../themes/colors.dart';

AppBar customAppbar(BuildContext context) {
    return AppBar(
          backgroundColor: CuriosityColors.dark,
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon:const Icon(Icons.clear,color: Colors.white,)
          ),
        );
  }