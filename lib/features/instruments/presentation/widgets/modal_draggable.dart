import 'dart:ui';
import 'package:curioso_app/core/themes/colors.dart';
import 'package:flutter/material.dart';
import 'modal_content_widget.dart';

class ModalDraggable extends StatefulWidget {
  const ModalDraggable({
    Key? key,
    required this.width,
    required this.symbol,
  }) : super(key: key);

  final double width;
  final String symbol;

  @override
  State<ModalDraggable> createState() => _ModalDraggableState();
}

class _ModalDraggableState extends State<ModalDraggable> with SingleTickerProviderStateMixin {
  double maxHeight = 70;
  double minHeight = 70;
  double _currentSize=0.0;
  late AnimationController _controller;
  @override
  void initState() {
    _currentSize=minHeight;
    _controller=AnimationController(vsync: this,duration: const Duration(milliseconds: 500));
    
    init();

    super.initState();
  }
  Future init()async{
    await _controller.forward();
        
  }
  bool _open=false;
  @override
  Widget build(BuildContext context) {
    
    return 
           GestureDetector(
              onVerticalDragUpdate:(value){
                maxHeight=MediaQuery.of(context).size.height-160;
                setState(() {
                final newHeight=_currentSize - value.delta.dy;
                _controller.value=_currentSize;
                _currentSize=newHeight.clamp(minHeight, maxHeight);
                  
                });
              },
              onVerticalDragEnd: (value){
                if(_currentSize<maxHeight/3){
                  _open=false;
                  _controller.reverse();
                }
                else if(_currentSize<maxHeight/1.2){
                  _open=false;
                  _controller.forward(from: _currentSize/maxHeight);
                  _currentSize=maxHeight/1.5;
                }
                
                else if(_currentSize<maxHeight){
                  _open=true;
                  _controller.forward(from: _currentSize/maxHeight);
                  _currentSize=maxHeight;
                }
              },
             child: AnimatedBuilder(
                       animation: _controller,
                       builder: (context,Widget? child) {
                       final value = const  ElasticInOutCurve(.7).transform(_controller.value);
                 return Stack(
                   children: [
                     Positioned(
                       bottom: 0,
                         width: MediaQuery.of(context).size.width,
                         height: lerpDouble(minHeight, _currentSize, value),
                         child: Container(
                         decoration: const BoxDecoration(
                            color: CuriosityColors.blackbeige,
                            borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              right: 0,
                              child: Container(
                                margin:
                                const EdgeInsets.only(top: 10, left: 150, right: 150,bottom: 100),
                                height: 5,
                                width: 200,
                                color: CuriosityColors.mirage,
                              ),
                            ),
                            ModalContents(
                              dragEnable: _open,
                              width: widget.width,
                              symbol: widget.symbol,
                            ), 
                          ],
                        ),
                      ),
                     ),
                   ],
                 );
               }
             ),
           );
  }
}
