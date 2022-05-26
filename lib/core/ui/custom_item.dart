import 'dart:ui';

import 'package:curioso_app/core/constants/constants.dart';
import 'package:curioso_app/core/themes/colors.dart';
import 'package:flutter/material.dart';


class CustomItem<T> extends StatefulWidget {

  final T gruopValue;
  final T value;
  final IconData icon;
  final Widget? parentWidget;
  final ValueChanged<T?> onChanged;

  const CustomItem(
    {
      Key? key,
      required this.gruopValue,
      required this.value,
      required this.icon,
      this.parentWidget,
      required this.onChanged
    }
    ) : super(key: key);

  @override
  State<CustomItem<T>> createState() => _CustomItemState<T>();
}

class _CustomItemState<T> extends State<CustomItem<T>> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<Color?> _animationColor;
  @override
  void initState() {
    _controller=AnimationController(vsync: this, duration:Constants.duration);
    _animation=Tween<double>(begin: 1,end:1.3)
    .animate(
      CurvedAnimation(
        parent: _controller,
        curve: const ElasticInOutCurve(2),
        reverseCurve: Curves.ease
      )
    );
    _animationColor=ColorTween(
      begin: CuriosityColors.white.withOpacity(.4),
      end:CuriosityColors.white
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInCubic,
        
      )
    );
    super.initState();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  bool _isSelected=false;
  @override
  Widget build(BuildContext context) {
    _isSelected = widget.value==widget.gruopValue;
    if(_isSelected){
      _controller.forward();
    }else{
      _controller.reverse();
    }
    return InkWell(
      onTap: () => widget.onChanged(widget.value),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, Widget? child) {
          return Transform.scale(
            scale: _animation.value,
            child: Icon(
              widget.icon,
              color: _animationColor.value,
            ),
          );
        }
      ),
    );
  }
}