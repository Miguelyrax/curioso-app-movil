part of 'generalnews_bloc.dart';

abstract class GeneralnewsState extends Equatable {
  const GeneralnewsState();
  
  @override
  List<Object> get props => [];
}

class GeneralnewsInitial extends GeneralnewsState {}
class GeneralnewsLoaded extends GeneralnewsState {}
class GeneralnewsError extends GeneralnewsState {
  final String message;

  const GeneralnewsError(this.message);
}
class GeneralnewsHasData extends GeneralnewsState {
  final List<News> news;

  const GeneralnewsHasData(this.news);
}
