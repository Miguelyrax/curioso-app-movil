import 'package:bloc/bloc.dart';
import 'package:curioso_app/core/usecases/usecase.dart';
import 'package:curioso_app/features/news/domain/usecases/get_news_symbol.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/news.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final GetNewsSymbol getNewsSymbol;
  NewsBloc({
  required this.getNewsSymbol
  }) : super(NewsInitial()) {
    on<NewsEvent>((event, emit) {
      
    });
    on<NewsLoadedSymbol>((event,emit)async{
      emit(NewsLoading());
      final result=await getNewsSymbol.execute(Params(symbol: event.symbol));
      result.fold(
        (failure) => emit(const NewsError('Error al cargar las noticias')),
        (data) => emit(NewsHasData(data))
      );
    });
  }
}
