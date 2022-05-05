part of 'news_bloc.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object> get props => [];
}

class NewsLoaded extends NewsEvent{}
class NewsLoadedSymbol extends NewsEvent{
  final String symbol;

  const NewsLoadedSymbol(this.symbol);
}