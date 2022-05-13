import 'package:flutter/material.dart';
class CustomRadio<T> extends StatefulWidget {
  const CustomRadio({
    Key? key,
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  }) : super(key: key);
  final String title;
  final T value;
  final T groupValue;
  final ValueChanged<T?> onChanged;

  @override
  State<CustomRadio<T>> createState() => _CustomRadioState<T>();
}

class _CustomRadioState<T> extends State<CustomRadio<T>> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> animation;
  @override
  void initState() {
    _controller=AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    animation=Tween<double>(begin: 0.0,end:1.0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInCubic));
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    final isSelected=widget.value==widget.groupValue;
    if(isSelected){
      _controller.forward();
    }else{
      _controller.reverse();
    }
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: ()=>widget.onChanged(widget.value),
      child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16,vertical:12 ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color:isSelected?const Color(0xff1CBD88): Colors.white.withOpacity(.6))
                ),
                child: Row(
                  children: [
                    Expanded(
                      child:Text(widget.title,style: TextStyle(color:isSelected?const Color(0xff1CBD88):const Color(0xffE0E0E0)),)
                    ),
                    const SizedBox(width: 5,),
                    Stack(
                      children: [
                        Container(
                          width: 18,
                          height: 18,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(color:Colors.white.withOpacity(.6))
                          ),
                        ),
                        AnimatedBuilder(
                          animation: _controller,
                          builder: (BuildContext context,Widget? child){
                            return Transform.scale(
                              scale: animation.value,
                              child: child
                            );
                          },
                          child: Container(
                            width: 18,
                            height: 18,
                            decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: const Color(0xff1CBD88)
                          ),
                            child: const Icon(Icons.check,color: Colors.white,size: 12,)
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
    );
  }
}