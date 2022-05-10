import 'package:bloc/bloc.dart';
import 'package:curioso_app/features/user/domain/entities/user.dart';
import 'package:curioso_app/features/user/domain/usecases/login.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final Login login;
  UserBloc(this.login) : super(UserInitial()) {
    on<UserEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<OnUserLoaded>((event,emit)async{
      emit(UserLoading());
      final result = await login.execute(
        UserParams(email: event.email, password: event.password)
      );
      result.fold(
        (failure) => emit(UserError(failure.message)),
        (data) => emit(UserHasData(data))
      );
    });

  }
}
