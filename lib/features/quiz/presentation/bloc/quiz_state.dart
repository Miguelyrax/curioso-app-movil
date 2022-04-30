part of 'quiz_bloc.dart';

abstract class QuizState extends Equatable {
  const QuizState();
  
  @override
  List<Object?> get props => [];
}

class QuizInitial extends QuizState {}
class QuizLoading extends QuizState {}
class QuizError extends QuizState {
  final String message;

  const QuizError(this.message);

}

class QuizHasData extends QuizState {
  final Quiz result;
  final Answer? answer;
  final Map<String,dynamic> data;

  QuizHasData copyWith(
     {
       Answer? answer,
       Quiz? result,
       Map<String,dynamic>? data,
     }
  )=>QuizHasData(
    answer: answer,
    result: result??this.result,
    data:data??this.data
  );
  

  const QuizHasData({required this.result, this.answer,this.data=const{}});
@override
  List<Object?> get props => [result,answer,data];
}
class QuizSubmited extends QuizState {
  final Riesgo riesgo;
  const QuizSubmited({required this.riesgo});
@override
  List<Object?> get props => [riesgo];
}
