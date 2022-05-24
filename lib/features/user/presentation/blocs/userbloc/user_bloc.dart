import 'package:bloc/bloc.dart';
import 'package:curioso_app/core/usecases/usecase.dart';
import 'package:curioso_app/features/quiz/domain/entities/riesgo.dart';
import 'package:curioso_app/features/user/data/models/user_model.dart';
import 'package:curioso_app/features/user/domain/entities/user.dart';
import 'package:curioso_app/features/user/domain/usecases/login.dart';
import 'package:curioso_app/features/user/domain/usecases/put_profile.dart';
import 'package:curioso_app/features/user/domain/usecases/register.dart';
import 'package:curioso_app/features/user/domain/usecases/renew.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final Login login;
  final Register register;
  final Renew renew;
  final PutProfile putProfile;
  UserBloc(this.login, this.register,this.renew, this.putProfile) : super(UserInitial()) {
    on<UserEvent>((event, emit) {
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
    on<OnUserRegister>((event,emit)async{
      emit(UserLoading());
      final result = await register.execute(
        UserParams(email: event.email, password: event.password, name: event.name)
      );
      result.fold(
        (failure) => emit(UserError(failure.message)),
        (data) => emit(UserHasData(data))
      );
    });
    on<OnUserRenew>((event,emit)async{
      print('renew');
      emit(UserLoading());
      final result = await renew.execute(NoParams());
      result.fold(
        (failure) => emit(UserError(failure.message)),
        (data) => emit(UserHasData(data))
      );
    });
    on<OnUserLogout>((event,emit)async{
      emit(UserLoading());
      const FlutterSecureStorage _storage=FlutterSecureStorage();
      await _storage.deleteAll();
      emit(UserInitial());
    });
    on<OnUserChangeProfile>((event,emit)async{
      late User oldUser;
      if(state is UserHasData){
        oldUser = state.props[0] as User;
      }else{
       return  emit(const UserError('Error'));
      }
      emit(UserLoading());
      User newUser = User(
        name: oldUser.name,
        email: oldUser.email,
        token: oldUser.token,
        status: oldUser.status,
        profile: event.profile
      );
      print(newUser.profile);
      print('aqui3');
      final result = await putProfile.execute(UserParamsProfile(id: event.profile.id));
      print('aqui4');
      print(result.isRight());
      result.fold(
        (failure) => emit(UserHasData(oldUser)),
        (data) => emit(UserHasData(newUser))
      );
    });

  }
}
