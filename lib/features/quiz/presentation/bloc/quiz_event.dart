part of 'quiz_bloc.dart';

abstract class QuizEvent extends Equatable {
  const QuizEvent();
  

  @override
  List<Object> get props => [];
}

class OnQuizLoaded extends QuizEvent{}
class OnAnswerSelected extends QuizEvent{
  final Answer answer;
  final Map<String,dynamic> data;

  const OnAnswerSelected({required this.answer, required this.data});
}
class OnQuizSubmite extends QuizEvent{
  final Map<String,dynamic> data;

  const OnQuizSubmite({required this.data});
}
class OnNextAnswer extends QuizEvent{}
