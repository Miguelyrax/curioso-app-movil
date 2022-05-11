import 'package:flutter/material.dart';
class SlideTransitionRoute extends PageRouteBuilder {
  
  SlideTransitionRoute({required this.page, this.offset=const Offset(0,1)})
      : super(
          pageBuilder: (_, __, ___) => page,
          transitionsBuilder: (_, animation, __, child){
            Tween<Offset> tween;
            tween = Tween(begin: offset, end: Offset.zero);
            return SlideTransition(
            position: tween.animate(animation.drive(CurveTween(curve: Curves.easeOutCubic))),
            child: child,
            );
          },
        );

  final Widget page;
  final Offset offset;
}