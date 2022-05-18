part of 'detail_bloc_dart_bloc.dart';

abstract class DetailState extends Equatable {
  const DetailState();
  
  @override
  List<Object> get props => [];
}

class DetailInitial extends DetailState {}
class DetailLoading extends DetailState {}
class DetailError extends DetailState {
  final String message;

  const DetailError({required this.message});
}
class DetailHasData extends DetailState {
  final Detail detail;
  final String id;

  const DetailHasData(this.detail,this.id);
}
