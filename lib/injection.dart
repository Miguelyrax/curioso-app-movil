
import 'package:curioso_app/features/instruments/data/datasource/instrument_remote_data_source.dart';
import 'package:curioso_app/features/instruments/domain/repositories/instrument_repository.dart';
import 'package:curioso_app/features/instruments/domain/usecases/getInstrument.dart';
import 'package:curioso_app/features/instruments/domain/usecases/get_detail.dart';
import 'package:curioso_app/features/instruments/domain/usecases/get_historical_data.dart';
import 'package:curioso_app/features/instruments/presentation/blocs/detailbloc/detail_bloc_dart_bloc.dart';
import 'package:curioso_app/features/instruments/presentation/blocs/historicaldatabloc/historicaldatabloc_bloc.dart';
import 'package:curioso_app/features/news/data/datasource/news_datasource.dart';
import 'package:curioso_app/features/news/data/repositories/news_repository.dart';
import 'package:curioso_app/features/news/domain/repositories/news_repository.dart';
import 'package:curioso_app/features/news/domain/usecases/get_news_general.dart';
import 'package:curioso_app/features/news/domain/usecases/get_news_symbol.dart';
import 'package:curioso_app/features/news/presentation/bloc/news/news_bloc.dart';
import 'package:curioso_app/features/quiz/data/datasource/quiz_remote_data_source.dart';
import 'package:curioso_app/features/quiz/data/repositories/quiz_repository_impl.dart';
import 'package:curioso_app/features/quiz/domain/repositories/quiz_repository.dart';
import 'package:curioso_app/features/quiz/domain/usecases/get_quiz.dart';
import 'package:curioso_app/features/quiz/domain/usecases/get_riesgo.dart';
import 'package:curioso_app/features/quiz/presentation/bloc/quiz_bloc.dart';
import 'package:curioso_app/features/user/data/datasource/user_data_source.dart';
import 'package:curioso_app/features/user/domain/repository/user_repository.dart';
import 'package:curioso_app/features/user/domain/usecases/login.dart';
import 'package:curioso_app/features/user/presentation/bloc/user_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'features/instruments/data/repositories/instrument_repository_impl.dart';
import 'features/instruments/presentation/blocs/instrumentbloc/instrument_bloc.dart';
import 'features/user/data/repository/user_repository_impl.dart';
final locator = GetIt.instance;

void init(){
  //bloc
  locator.registerFactory(() => QuizBloc(locator(),locator()));
  locator.registerFactory(() => InstrumentBloc(locator()));
  locator.registerFactory(() => DetailBloc(locator()));
  locator.registerFactory(() => HistoricaldataBloc(locator()));
  locator.registerFactory(() => NewsBloc(getNewsGeneral: locator(), getNewsSymbol: locator()));
  locator.registerFactory(() => UserBloc(locator()));

  //usecase
  locator.registerLazySingleton(() => GetQuiz(locator()));
  locator.registerLazySingleton(() => GetRiesgo(locator()));
  locator.registerLazySingleton(() => GetInstrument(locator()));
  locator.registerLazySingleton(() => GetDetail(locator()));
  locator.registerLazySingleton(() => GetHistoricalData(locator()));
  locator.registerLazySingleton(() => GetNewsGeneral(locator()));
  locator.registerLazySingleton(() => GetNewsSymbol(locator()));
  locator.registerLazySingleton(() => Login(locator()));

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
  locator.registerLazySingleton<NewsRepository>(() => 
    NewsRepositoryImpl(
      locator()
    )
  );
  locator.registerLazySingleton<UserRepository>(() => 
    UserRepositoryImpl(
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
  locator.registerLazySingleton<NewsDatasource>(() => 
    NewsDataSourceImpl(locator())
  );
  locator.registerLazySingleton<UserDataSource>(() => 
    UserDataSourceImpl(locator())
  );

  //external
  locator.registerLazySingleton(() => http.Client());
}