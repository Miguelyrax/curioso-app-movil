part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}
class OnUserLoaded extends UserEvent{
  final String email;
  final String password;

  const OnUserLoaded(
    {
    required this.email, 
    required this.password
    }
  );
}
class OnUserRegister extends UserEvent{
  final String email;
  final String password;
  final String name;

  const OnUserRegister(
    {
    required this.email, 
    required this.password,
    required this.name,
    }
  );
}

class OnUserRenew extends UserEvent{}