part of 'recovery_bloc.dart';

abstract class RecoveryEvent extends Equatable {
  const RecoveryEvent();

  @override
  List<Object> get props => [];
}

class OnSendEmail extends RecoveryEvent{
  final String email;

  const OnSendEmail(this.email);
}
class OnRecoveryInitial extends RecoveryEvent{}
class OnRecoveryEmail extends RecoveryEvent{
  final String email;
  final int code;

  const OnRecoveryEmail(
    {
      required this.email,
      required this.code
    }
  );
}
