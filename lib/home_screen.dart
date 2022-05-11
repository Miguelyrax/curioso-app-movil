import 'package:curioso_app/core/themes/colors.dart';
import 'package:flutter/material.dart';
import 'core/ui/bottom_navigation_bar.dart';
import 'features/instruments/presentation/screens/instrumentos_screen.dart';
import 'features/user/presentation/screens/login_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _controller;
  @override
  void initState() {
    _controller=PageController(initialPage: 1);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        backgroundColor: CuriosityColors.dark,
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _controller,
                children: [
                  LoginScreen(),
                  const InstrumentosScreen(),
                ],
              ),
            ),
            Positioned(
             bottom: 0,
             child: CustomBottomNavigatorBar(
               pageController:_controller
            )
            ),
          ],
        ),
       ),
    );
  }
}

