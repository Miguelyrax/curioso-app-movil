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

class _CustomBottomNavigatorBarState extends State<CustomBottomNavigatorBar> {
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
                GestureDetector(onTap: () {
                  index = 0;
                  widget.pageController.animateToPage(0,
                      duration: Constants.duration, curve: Constants.cubic);
                  setState(() {});
                }, child:  BlocBuilder<UserBloc, UserState>(
                  builder: (context, state) {
                    if(state is UserHasData){
                      return  Icon(
                      index==0?Icons.favorite_rounded:Icons.favorite_outline,
                      color:index==0? CuriosityColors.orangered: CuriosityColors.white,
                    );
                    }else{
                    return  Icon(
                      Icons.person,
                      color: index==0? CuriosityColors.orangered: CuriosityColors.white,
                    );
                    }
                  },
                )),
                SizedBox(
                  width: size * .2,
                ),
                GestureDetector(
                    onTap: () {
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
