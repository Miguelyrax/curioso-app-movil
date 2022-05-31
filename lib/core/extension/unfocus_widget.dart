import 'package:flutter/material.dart';
class UnfocusWidget
 extends StatelessWidget {
  const UnfocusWidget
  (
    {
      Key? key,
      required this.child
    }
  ) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
            onVerticalDragDown: (value){
              FocusScope.of(context).unfocus();
            },
            child: child,
          );
  }
}