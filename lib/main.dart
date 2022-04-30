import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/quiz/presentation/bloc/quiz_bloc.dart';
import 'features/quiz/presentation/screens/quiz_screen.dart';
import 'injection.dart' as di;
void main() {
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_)=>di.locator<QuizBloc>())
      ],
      child: MaterialApp(
        title: 'Material App',
        home: QuizScreen(),
      ),
    );
  }
}