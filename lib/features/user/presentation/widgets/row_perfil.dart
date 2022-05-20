import 'dart:math';

import 'package:curioso_app/core/themes/colors.dart';
import 'package:flutter/material.dart';

class RowPerfil extends StatefulWidget {
  const RowPerfil({
    Key? key,
    required this.onPressed,
    required this.alignment,
  }) : super(key: key);
  final Function onPressed;
  final AlignmentGeometry alignment;

  @override
  State<RowPerfil> createState() => _RowPerfilState();
}

class _RowPerfilState extends State<RowPerfil> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _animationPositioned;
  @override
  void initState() {
    _controller=AnimationController(vsync: this, duration: const Duration(milliseconds: 250));
    _animation=Tween<double>(begin: 0,end: pi)
    .animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastOutSlowIn
      )
    );
    _animationPositioned=Tween<double>(begin: 0,end: 36)
    .animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastOutSlowIn
      )
    );
    super.initState();
  }


  @override
  void dispose() {
    _controller;
    _controller.dispose();
    super.dispose();
  }
  bool _isOpen = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text('Editar',style: Theme.of(context) .textTheme.headline3,),
        ),
        Container(
          width: 100,
          child: Stack(
            alignment: Alignment.centerRight,
            children: [
              AnimatedBuilder(
                animation: _controller,
                builder: (context,Widget? child) {
                  return AnimatedPositioned(
                    right: _animationPositioned.value,
                    child: GestureDetector(
                      onTap: _change,
                      child: Container(
                      height: 31,
                      width: 31,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: CuriosityColors.aquagreen,
                      ),
                      child: const Icon(Icons.save),
                                      ),
                    ), duration: const Duration(milliseconds: 10));
                }
              ),
              GestureDetector(
                onTap: _change,
                child: _ContainerAnimated(controller: _controller, animation: _animation),
              ),
              
            ],
          ),
        ),
      ],
    );
  }

  void _change(){
    _isOpen=!_isOpen;
    widget.onPressed(_isOpen);
    if(_isOpen){
    _controller.forward();
    }else{
      _controller.reverse();
    }
  }
}

class _ContainerAnimated extends StatelessWidget {
  const _ContainerAnimated({
    Key? key,
    required AnimationController controller,
    required Animation<double> animation,
  }) : _controller = controller, _animation = animation, super(key: key);

  final AnimationController _controller;
  final Animation<double> _animation;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 31,
      width: 31,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: CuriosityColors.orangered,
      ),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context,Widget? child) {
          return Transform.rotate(
            angle: _animation.value,
            child: const Icon(Icons.settings));
        }
      ),
    );
  }
}
