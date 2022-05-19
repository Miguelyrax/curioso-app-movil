import 'package:bloc_test/bloc_test.dart';
import 'package:curioso_app/core/usecases/usecase.dart';
import 'package:curioso_app/features/quiz/domain/entities/answer.dart' as ans;
import 'package:curioso_app/features/quiz/domain/entities/question.dart';
import 'package:curioso_app/features/quiz/domain/entities/quiz.dart';
import 'package:curioso_app/features/quiz/domain/entities/riesgo.dart';
import 'package:curioso_app/features/quiz/domain/usecases/get_quiz.dart';
import 'package:curioso_app/features/quiz/domain/usecases/get_riesgo.dart';
import 'package:curioso_app/features/quiz/presentation/bloc/quiz_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
class MockGetQuiz extends Mock implements GetQuiz{}
class MockGetRiesgo extends Mock implements GetRiesgo{}
void main() {
  late MockGetQuiz mockGestQuiz;
  late MockGetRiesgo mockGetRiesgo;
  late QuizBloc bloc;

  setUp(() {
    mockGestQuiz = MockGetQuiz();
    mockGetRiesgo = MockGetRiesgo();
    bloc = QuizBloc(mockGestQuiz,mockGetRiesgo);
  });

  test(
    "intial state should be empty",
    () async {
      expect(bloc.state, isA<QuizInitial>());
    },
  );

  group('Quiz', () {
    const answer= ans.Answer(
    id: '123',
    description:'123'
  );
  const question= Question(
    id: '123',
    title:'123',
    answer: [answer]
  );
  const quiz= Quiz(
    id: '123',
    name: '123',
    questions: [question]
  );

    test(
      "should return quiz when the usecase is called",
      () async {
        when(()=>mockGestQuiz.execute(NoParams()))
        .thenAnswer((_) async => const Right(quiz));
        bloc.add(OnQuizLoaded());
        await untilCalled(()=>mockGestQuiz.execute(NoParams()));
        verify(()=>mockGestQuiz.execute(NoParams()));
      },
    );
    blocTest(
      'emits [QuizLoaing, QuizHasData] when the usecase getQuiz is called.',
      build: () {
        when(()=>mockGestQuiz.execute(NoParams()))
        .thenAnswer((_) async => const Right(quiz));
        return bloc;
      },
      act: (QuizBloc blocc) => blocc.add(OnQuizLoaded()),
      expect: () => [
        QuizLoading(),
        const QuizHasData(result: quiz)
      ],
      verify: (_) async {
      verify(() => mockGestQuiz.execute(NoParams()));
      },
    );
  });
  group('Riesgo', () {
    const map ={
    "123":'123',
    "456":'456'
  };
  const data = Riesgo(
    id: '123',
    name: '123',
    description: '123',
    icon: '123'
  );
    test(
      "should return data when the usecase is called",
      () async {
        when(()=>mockGetRiesgo.execute(const ParamsRiesgo(data: map)))
        .thenAnswer((_) async => const Right(data));
        bloc.add(const OnQuizSubmite(data: map));
        await untilCalled(()=>mockGetRiesgo.execute(const ParamsRiesgo(data: map)));
        verify(()=>mockGetRiesgo.execute(const ParamsRiesgo(data: map)));
      },
    );
    blocTest(
      'emits [QuizLoading, QuizHasData] when the usecase getQuiz is called.',
      build: () {
        when(()=>mockGetRiesgo.execute(const ParamsRiesgo(data: map)))
        .thenAnswer((_) async => const Right(data));
        return bloc;
      },
      act: (QuizBloc blocc) => blocc.add(const OnQuizSubmite(data: map)),
      expect: () => [
        QuizLoading(),
        const QuizSubmited(riesgo: data)
      ],
      verify: (_) async {
      verify(() => mockGetRiesgo.execute(const ParamsRiesgo(data: map)));
      },
    );
  });
}
