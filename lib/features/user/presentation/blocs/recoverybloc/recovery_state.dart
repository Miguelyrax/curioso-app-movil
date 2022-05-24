part of 'recovery_bloc.dart';

abstract class RecoveryState extends Equatable {
  const RecoveryState();
  
  @override
  List<Object> get props => [];
}

class RecoveryInitial extends RecoveryState {}
class RecoveryLoaded extends RecoveryState{}
class RecoveryEndLoaded extends RecoveryState{}
class RecoverySendSuccess extends RecoveryState{}
class RecoveryError extends RecoveryState{
  final String message;

  const RecoveryError(this.message);
}
