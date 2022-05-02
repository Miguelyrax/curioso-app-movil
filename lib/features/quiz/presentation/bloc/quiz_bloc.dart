import 'package:bloc/bloc.dart';
import 'package:curioso_app/core/usecases/usecase.dart';
import 'package:curioso_app/features/quiz/domain/entities/answer.dart';
import 'package:curioso_app/features/quiz/domain/entities/riesgo.dart';
import 'package:curioso_app/features/quiz/domain/usecases/get_quiz.dart';
import 'package:curioso_app/features/quiz/domain/usecases/get_riesgo.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/quiz.dart';

part 'quiz_event.dart';
part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final GetQuiz _getQuiz;
  final GetRiesgo _getRiesgo;
  QuizBloc(this._getQuiz, this._getRiesgo) : super(QuizInitial()) {
    on<QuizEvent>((event, emit) {
    });
    on<OnQuizLoaded>((event,emit)async{
      emit(QuizLoading());
      final result = await _getQuiz.execute(NoParams());
      result.fold(
        (failure) => emit(QuizError(failure.message)),
        (data) => emit(QuizHasData(result:data))
      );
    });
    on<OnAnswerSelected>((event, emit){
      if(state is QuizHasData){
        QuizHasData quizState= state as QuizHasData;
        emit(quizState.copyWith(answer: event.answer,data:{...quizState.data,...event.data} ));
      }
    });
    on<OnNextAnswer>((event, emit){
      if(state is QuizHasData){
        QuizHasData quizState= state as QuizHasData;
        emit(quizState.copyWith(answer:null));
      }
    });
    on<OnQuizSubmite>((event, emit)async{
      emit(QuizLoading());
      final result = await _getRiesgo.execute(ParamsRiesgo(data: event.data));
      result.fold(
        (failure) => emit(QuizError(failure.message)),
        (data) => emit(QuizSubmited(riesgo:data))
      );
    });
  }
}
