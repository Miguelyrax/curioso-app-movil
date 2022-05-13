import 'package:curioso_app/core/themes/colors.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';


class CustomBottomNavigatorBar extends StatelessWidget {
  final PageController pageController;

  const CustomBottomNavigatorBar(
    {
      Key? key, required this.pageController
    }
    ) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size.width;
    return SizedBox(
      height: 70,
      width: size,
      child: Stack(
        children: [
          CustomPaint(
            size: Size(size,80),
            painter: MyPainter(),
          ),
          Center(
            heightFactor: .6,
            child: FloatingActionButton(
              backgroundColor: CuriosityColors.beige,
              child:const Icon(Icons.home,color: CuriosityColors.mirage,),
                  onPressed: (){
                    pageController.animateToPage(1, duration: Constants.duration, curve: Constants.cubic);
                  },
                ),
          ),
          SizedBox(
            width: size,
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: (){
                    pageController.animateToPage(0, duration: Constants.duration, curve: Constants.cubic);
                  },
                  child: const Icon(
                    Icons.call_sharp, color: CuriosityColors.white,
                  )
                ),
                SizedBox(width: size*.2,),
                GestureDetector(
                  onTap: (){
                    pageController.animateToPage(2, duration: Constants.duration, curve: Constants.cubic);
                  },
                  child: const Icon(
                    Icons.newspaper,
                    color: CuriosityColors.white,
                  )
                ),
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
    ..color= CuriosityColors.blackbeige
    ..style=PaintingStyle.fill
    ..strokeWidth=2;

     final path = Path();
     path.quadraticBezierTo(size.width*.2, 0, size.width*.35, 0);
     path.quadraticBezierTo(size.width*.4, 0, size.width*.4, 20);
     path.arcToPoint(Offset(size.width*.6, 20),radius: const Radius.circular(10.0),clockwise: false);
     path.quadraticBezierTo(size.width*.6, 0, size.width*.65, 0);
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