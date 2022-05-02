import 'package:flutter/material.dart';
class SlideTransitionRoute extends PageRouteBuilder {
  
  SlideTransitionRoute({required this.page})
      : super(
          pageBuilder: (_, __, ___) => page,
          transitionsBuilder: (_, animation, __, child){
            Tween<Offset> tween;
            tween = Tween(begin:const Offset(0, 1), end: Offset.zero);
            return SlideTransition(
            position: tween.animate(animation.drive(CurveTween(curve: Curves.easeOutCubic))),
            child: child,
            );
          },
        );

  final Widget page;
}