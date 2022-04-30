import 'package:curioso_app/features/quiz/presentation/bloc/quiz_bloc.dart';
import 'package:curioso_app/features/quiz/presentation/screens/perfil_inversionista_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'content_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  void initState() {
    final quizBloc = BlocProvider.of<QuizBloc>(context, listen: false);
    quizBloc.add(OnQuizLoaded());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:const Color(0xff111326),
        elevation: 0,
        actions: const[
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Icon(Icons.more_horiz,size: 30,),
          )
        ],
      ),
      backgroundColor: const Color(0xff111326),
      body: BlocBuilder<QuizBloc, QuizState>(
      builder: (context, state) {
        if(state is QuizLoading){
          return const Center(
            child: CircularProgressIndicator()
          );
        }
        else if(state is QuizError){
          return Center(child: Text(state.message),);
        }
        else if(state is QuizHasData){
          return ContentScreen(state: state,);
        }
        else if(state is QuizSubmited){
          return PerfilInversionista(state:state);
        }
        else{
          return const SizedBox();
        }
      },
      ),
    );
  }
}


