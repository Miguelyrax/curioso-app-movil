
import 'package:curioso_app/features/instruments/data/datasource/instrument_remote_data_source.dart';
import 'package:curioso_app/features/instruments/domain/repositories/instrument_repository.dart';
import 'package:curioso_app/features/instruments/domain/usecases/getInstrument.dart';
import 'package:curioso_app/features/instruments/presentation/bloc/instrument_bloc.dart';
import 'package:curioso_app/features/quiz/data/datasource/quiz_remote_data_source.dart';
import 'package:curioso_app/features/quiz/data/repositories/quiz_repository_impl.dart';
import 'package:curioso_app/features/quiz/domain/repositories/quiz_repository.dart';
import 'package:curioso_app/features/quiz/domain/usecases/get_quiz.dart';
import 'package:curioso_app/features/quiz/domain/usecases/get_riesgo.dart';
import 'package:curioso_app/features/quiz/presentation/bloc/quiz_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'features/instruments/data/repositories/instrument_repository_impl.dart';
final locator = GetIt.instance;

void init(){
  //bloc
  locator.registerFactory(() => QuizBloc(locator(),locator()));
  locator.registerFactory(() => InstrumentBloc(locator()));

  //usecase
  locator.registerLazySingleton(() => GetQuiz(locator()));
  locator.registerLazySingleton(() => GetRiesgo(locator()));
  locator.registerLazySingleton(() => GetInstrument(locator()));

  //Repository
  locator.registerLazySingleton<QuizRepository>(() => 
    QuizRepositoryImpl(
      locator()
    )
  );
  locator.registerLazySingleton<InstrumentRepository>(() => 
    InstrumentRepositoryImpl(
      locator()
    )
  );

  //data source
  locator.registerLazySingleton<QuizRemoteDataSource>(() => 
    QuizRemoteDataSourceImpl(locator())
  );
  locator.registerLazySingleton<InstrumentRemoteDataSource>(() => 
    InstrumentRemoteDataSourceImpl(locator())
  );

  //external
  locator.registerLazySingleton(() => http.Client());
}