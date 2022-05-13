part of 'generalnews_bloc.dart';

abstract class GeneralnewsEvent extends Equatable {
  const GeneralnewsEvent();

  @override
  List<Object> get props => [];
}

class GeneralnewsLoading extends GeneralnewsEvent{}
