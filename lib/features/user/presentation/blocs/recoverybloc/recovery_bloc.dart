import 'package:bloc/bloc.dart';
import 'package:curioso_app/features/user/domain/usecases/post_recovery_password.dart';
import 'package:curioso_app/features/user/domain/usecases/post_send_email.dart';
import 'package:equatable/equatable.dart';

part 'recovery_event.dart';
part 'recovery_state.dart';

class RecoveryBloc extends Bloc<RecoveryEvent, RecoveryState> {
  final PostRecoveryPassword postRecoveryPassword;
  final PostSendEmail postSendEmail;
  RecoveryBloc(this.postRecoveryPassword, this.postSendEmail) : super(RecoveryInitial()) {
    on<RecoveryEvent>((event, emit) {
    });
    on<OnRecoveryInitial>((event, emit) {
      emit(RecoveryInitial());
    });
    on<OnRecoveryEmail>((event,emit)async {
      emit(RecoveryLoaded());
      final result = await postRecoveryPassword
      .execute(
        RecoveryParams(email: event.email,code: event.code)
      );
      result.fold(
        (failure) => emit(RecoveryError(failure.message)),
        (data) => emit(RecoverySendSuccess()),
      );
    });
    on<OnSendEmail>((event,emit)async {
      emit(RecoveryLoaded());
      final result = await postSendEmail
      .execute(
        RecoveryParams(email: event.email)
      );
      result.fold(
        (failure) => emit(RecoveryError(failure.message)),
        (data) => emit(RecoveryEndLoaded()),
      );
    });
  }
}
