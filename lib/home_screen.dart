import 'package:curioso_app/core/themes/colors.dart';
import 'package:curioso_app/core/ui/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/ui/bottom_navigation_bar.dart';
import 'features/instruments/presentation/screens/instrumentos_screen.dart';
import 'features/news/presentation/screens/news_screen.dart';
import 'features/user/presentation/bloc/user_bloc.dart';
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
    final userBloc = BlocProvider.of<UserBloc>(context,listen: true);
    return  SafeArea(
      child: Scaffold(
        extendBody: true,
        bottomNavigationBar: CustomBottomNavigatorBar(pageController: _controller,),
        drawer:userBloc.state is UserHasData? const CustomDrawer():null,
        backgroundColor: CuriosityColors.dark,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _controller,
            children: [
              LoginScreen(),
              const InstrumentosScreen(),
              const NewsScreen()
            ],
          ),
        ),
       ),
    );
  }
}

