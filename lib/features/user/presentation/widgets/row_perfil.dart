import 'dart:math';

import 'package:curioso_app/core/themes/colors.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart';
class RowPerfil extends StatefulWidget {
  const RowPerfil({
    Key? key,
    required this.title,
    required this.danger,
    required this.onPressed,
  }) : super(key: key);
  final String title;
  final bool danger;
  final Function onPressed;

  @override
  State<RowPerfil> createState() => _RowPerfilState();
}

class _RowPerfilState extends State<RowPerfil> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  void initState() {
    _controller=AnimationController(vsync: this, duration: const Duration(seconds: 1))..addListener(_listener);
    _animation=Tween<double>(begin: 0,end: pi)
    .animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInCubic
      )
    );
    super.initState();
  }

  void _listener() { 
    if(_controller.status==AnimationStatus.completed){
      _controller.reset();
    }
  }
  @override
  void dispose() {
    _controller.removeListener(_listener);
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(widget.title,
                style:Theme.of(context)
                .textTheme
                .headline3
          ),
        ),
        GestureDetector(
          onTap: (){
            _controller.forward();
          },
          child: Container(
            height: 31,
            width: 31,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color:widget.danger?CuriosityColors.orangered: CuriosityColors.aquagreen,
            ),
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context,Widget? child) {
                return Transform.rotate(
                  angle: _animation.value,
                  child: const Icon(Icons.settings));
              }
            ),
          ),
        )
      ],
    );
  }
}
