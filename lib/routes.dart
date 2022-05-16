import 'package:curioso_app/core/ui/loadin_screen.dart';
import 'package:curioso_app/features/instruments/presentation/screens/detail_instrument_screen.dart';
import 'package:curioso_app/features/user/presentation/screens/auth_screen.dart';
import 'package:curioso_app/features/user/presentation/screens/register_screen.dart';
import 'package:curioso_app/features/user/presentation/views/perfil_view.dart';
import 'package:curioso_app/home_screen.dart';
import 'package:flutter/material.dart';

import 'core/extension/fade_page_route.dart';
import 'core/extension/slide_transtition_route.dart';


enum Routes { splash, home ,detail, auth, register, profile}

class _Paths {
  static const String splash = '/';
  static const String home = '/home';
  static const String detail = '/detail';
  static const String auth = '/auth';
  static const String register = '/register';
  static const String profile = '/profile';


  static const Map<Routes, String> _pathMap = {
    Routes.splash: _Paths.splash,
    Routes.home: _Paths.home,
    Routes.detail: _Paths.detail,
    Routes.auth: _Paths.auth,
    Routes.register: _Paths.register,
    Routes.profile: _Paths.profile,
  };

  static String of(Routes route) => _pathMap[route] ?? splash;
}

class AppNavigator {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case _Paths.splash:
        return FadeRoute(page: const LoadingScreen());
      case _Paths.detail:
        return SlideTransitionRoute(page:const DetailInstrumentScreen());
      case _Paths.auth:
        return SlideTransitionRoute(page: const AuthScreen(),offset: const Offset(0,2));
      case _Paths.register:
        return SlideTransitionRoute(page: const RegisterScreen(),offset: const Offset(0,2));
      case _Paths.profile:
        return SlideTransitionRoute(page:  PerfilScreen(),offset: const Offset(0,2));
      default:
        return FadeRoute(page:const HomeScreen());
    }
  }

  static Future? push<T>(Routes route, [T? arguments]) =>
      state?.pushNamed(_Paths.of(route), arguments: arguments);

  static Future? replaceWith<T>(Routes route, [T? arguments]) =>
      state?.pushReplacementNamed(_Paths.of(route), arguments: arguments);

  static void pop() => state?.pop();

  static NavigatorState? get state => navigatorKey.currentState;
}
