import 'package:curioso_app/core/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/user/presentation/bloc/user_bloc.dart';
import '../constants/constants.dart';

class CustomBottomNavigatorBar extends StatefulWidget {
  final PageController pageController;

  const CustomBottomNavigatorBar({Key? key, required this.pageController})
      : super(key: key);

  @override
  State<CustomBottomNavigatorBar> createState() =>
      _CustomBottomNavigatorBarState();
}

  late AnimationController _controller;
class _CustomBottomNavigatorBarState extends State<CustomBottomNavigatorBar> with SingleTickerProviderStateMixin {
  late Animation<double> _animationScale;
  late Animation<double> _animationOpacity;
  late Animation<Color?> _animationColor;
  @override
  void initState() {
    _controller=AnimationController(vsync: this,duration: const Duration(milliseconds: 300));
    _animationScale=Tween<double>(begin: 1.0,end:1.1)
    .animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.bounceInOut,
        reverseCurve: Curves.fastOutSlowIn
      )
    );
    _animationOpacity=Tween<double>(begin: .6,end:1.0)
    .animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.ease,
      )
    );
    _animationColor=ColorTween(
      begin: CuriosityColors.white,
      end:CuriosityColors.orangered
    )
    .animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.bounceOut)
    );
    super.initState();
    
  }
  int index = 1;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    return SizedBox(
      height: 70,
      width: size,
      child: Stack(
        children: [
          CustomPaint(
            size: Size(size, 80),
            painter: MyPainter(),
          ),
          Center(
            heightFactor: .6,
            child: FloatingActionButton(
              backgroundColor: CuriosityColors.beige,
              child:  Icon(
                Icons.home,
                color:index==1?CuriosityColors.orangered: CuriosityColors.mirage,
              ),
              onPressed: () {
                index = 1;
                widget.pageController.animateToPage(1,
                    duration: Constants.duration, curve: Constants.cubic);
                setState(() {});
              },
            ),
          ),
          SizedBox(
            width: size,
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context,Widget? child){
                    return Transform.scale(
                      scale: _animationScale.value,
                      child: GestureDetector(
                        onTap: () {
                          index = 0;
                          _controller.forward();
                          widget.pageController.animateToPage(0,
                          duration: Constants.duration, curve: Constants.cubic);
                          setState(() {});
                        },
                        child:  BlocBuilder<UserBloc, UserState>(
                          builder: (context, state) {
                            if(state is UserHasData){
                              return  Opacity(
                                opacity: _animationOpacity.value,
                                child: Icon(
                                  index==0?Icons.favorite_rounded:Icons.favorite_outline,
                                  color:_animationColor.value,
                                ),
                              );
                            }else{
                              return  Icon(
                                Icons.person,
                                color: index==0? CuriosityColors.orangered: CuriosityColors.white,
                              );
                            }
                          },
                        )
                      ),
                    );
                  },
                ),
                SizedBox(
                  width: size * .2,
                ),
                GestureDetector(
                    onTap: () {
                      _controller.reverse();
                      index = 2;
                      widget.pageController.animateToPage(2,
                          duration: Constants.duration, curve: Constants.cubic);
                      setState(() {});
                    },
                    child:  Icon(
                      Icons.newspaper,
                      color:index==2?CuriosityColors.orangered: CuriosityColors.white,
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = CuriosityColors.blackbeige
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;

    final path = Path();
    path.quadraticBezierTo(size.width * .2, 0, size.width * .35, 0);
    path.quadraticBezierTo(size.width * .4, 0, size.width * .4, 20);
    path.arcToPoint(Offset(size.width * .6, 20),
        radius: const Radius.circular(10.0), clockwise: false);
    path.quadraticBezierTo(size.width * .6, 0, size.width * .65, 0);
    path.quadraticBezierTo(size.width, 0, size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(MyPainter oldDelegate) => true;
}
