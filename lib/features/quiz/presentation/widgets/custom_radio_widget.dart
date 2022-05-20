import 'package:curioso_app/core/themes/colors.dart';
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
  late Animation<Color?> animationColor;
  late Animation<Color?> animationColorBorder;
  @override
  void initState() {
    _controller=AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    animation=Tween<double>(begin: 0.0,end:1.0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInCubic));
    animationColor=ColorTween(begin: CuriosityColors.dark,end:CuriosityColors.surface).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInCubic));
    animationColorBorder=ColorTween(begin: CuriosityColors.gray,end:CuriosityColors.beige).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInCubic));
    super.initState();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context,Widget? child) {
          return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16,vertical:12 ),
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),

                      color:animationColor.value,
                      border: Border.all(color:animationColorBorder.value!)
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child:Text(
                            widget.title,style: Theme.of(context).textTheme.headline5!
                            .copyWith(
                              color:isSelected
                              ?CuriosityColors.white
                              :CuriosityColors.gray
                            ),
                          )
                        ),
                        const SizedBox(width: 5,),
                        Stack(
                          children: [
                            Container(
                              width: 18,
                              height: 18,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(color:CuriosityColors.gray)
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
                                color: CuriosityColors.beige
                              ),
                                child: const Icon(Icons.check,color: CuriosityColors.dark,size: 12,)
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  );
        }
      ),
    );
  }
}