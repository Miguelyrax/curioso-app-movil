import 'dart:math';

import 'package:curioso_app/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/themes/themes.dart';
import 'features/instruments/presentation/blocs/detailbloc/detail_bloc_dart_bloc.dart';
import 'features/instruments/presentation/blocs/historicaldatabloc/historicaldatabloc_bloc.dart';
import 'features/instruments/presentation/blocs/instrumentbloc/instrument_bloc.dart';
import 'features/news/presentation/bloc/news/news_bloc.dart';
import 'features/quiz/presentation/bloc/quiz_bloc.dart';
import 'features/user/presentation/bloc/user_bloc.dart';
import 'injection.dart' as di;
void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeApp themeApp = ThemeApp();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_)=>di.locator<QuizBloc>()),
        BlocProvider(create: (_)=>di.locator<InstrumentBloc>()),
        BlocProvider(create: (_)=>di.locator<DetailBloc>()),
        BlocProvider(create: (_)=>di.locator<HistoricaldataBloc>()),
        BlocProvider(create: (_)=>di.locator<NewsBloc>()),
        BlocProvider(create: (_)=>di.locator<UserBloc>()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle.dark,
          ),
          inputDecorationTheme: themeApp.customInputForm,
          textTheme: themeApp.textTheme,
        ),
        navigatorKey: AppNavigator.navigatorKey,
        onGenerateRoute: AppNavigator.onGenerateRoute,
        builder: (context, child) {
        if (child == null) return const SizedBox.shrink();
        final data = MediaQuery.of(context);
        final smallestSize = min(data.size.width, data.size.height);
        final textScaleFactor = min(smallestSize / 375, 1.0);
        return MediaQuery(
          data: data.copyWith(
            textScaleFactor: textScaleFactor,
          ),
          child: child,
        );
      },
      ),
    );
  }
}