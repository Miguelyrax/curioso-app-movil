
import 'package:curioso_app/features/quiz/data/datasource/quiz_remote_data_source.dart';
import 'package:curioso_app/features/quiz/data/repositories/quiz_repository_impl.dart';
import 'package:curioso_app/features/quiz/domain/repositories/quiz_repository.dart';
import 'package:curioso_app/features/quiz/domain/usecases/get_quiz.dart';
import 'package:curioso_app/features/quiz/domain/usecases/get_riesgo.dart';
import 'package:curioso_app/features/quiz/presentation/bloc/quiz_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
final locator = GetIt.instance;

void init(){
  //bloc
  locator.registerFactory(() => QuizBloc(locator(),locator()));

  //usecase
  locator.registerLazySingleton(() => GetQuiz(locator()));
  locator.registerLazySingleton(() => GetRiesgo(locator()));

  //Repository
  locator.registerLazySingleton<QuizRepository>(() => 
    QuizRepositoryImpl(
      locator()
    )
  );

  //data source
  locator.registerLazySingleton<QuizRemoteDataSource>(() => 
    QuizRemoteDataSourceImpl(locator())
  );

  //external
  locator.registerLazySingleton(() => http.Client());
}