
import 'package:bloc_test/bloc_test.dart';
import 'package:curioso_app/features/user/domain/entities/user.dart';
import 'package:curioso_app/features/user/domain/usecases/login.dart';
import 'package:curioso_app/features/user/domain/usecases/register.dart';
import 'package:curioso_app/features/user/presentation/bloc/user_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockLogin extends Mock implements Login{}
class MockRegister extends Mock implements Register{}
void main() {
  late MockLogin mockLogin;
  late MockRegister mockRegister;
  late UserBloc bloc;

  setUp(() {
    mockLogin = MockLogin();
    mockRegister = MockRegister();
    bloc = UserBloc(mockLogin,mockRegister);
  });

  test(
    "initial state should be empty",
    () async {
      expect(bloc.state, equals(UserInitial()));
    },
  );

   const data =  User(
    name: 'miguel',
    email: 'miguel@albanez.com',
    status: true,
    token: '123456'
    );

  group(
    'login', (){
    final userParams=UserParams(email: 'miguel@albanez.com', password: '123456');
      test(
        "should get data from usecase login",
        () async {
          when(()=>mockLogin.execute(userParams))
          .thenAnswer((_) async => const Right(data));
          bloc.add(const OnUserLoaded(email: 'miguel@albanez.com', password: '123456'));
          await untilCalled(()=>mockLogin.execute(userParams));
          verify(()=>mockLogin.execute(userParams));
        },
      );

      blocTest('should emit [loading,has data] when data from login is gotten successfully',
      build: (){
        when(()=>mockLogin.execute(userParams)).thenAnswer((_) async=> const Right(data));
        return bloc;
      },
      act: (UserBloc uBloc)=>uBloc.add(const OnUserLoaded(email: 'miguel@albanez.com', password: '123456')),
      wait: const Duration(milliseconds: 500),
      expect: ()=>[
        UserLoading(),
        const UserHasData(data)
      ],
      verify: (UserBloc uBloc){
       verify(()=>mockLogin.execute(userParams));
      }
      
      );

  });
  group('register', 
  (){
    final userParamsRegister=UserParams(email: 'miguel@albanez.com', password: '123456');
    test(
      "should get data from login",
      () async {
        when(()=>mockRegister.execute(userParamsRegister)).thenAnswer((invocation) async => const Right(data));
        bloc.add(const OnUserRegister(email: 'miguel@albanez.com', password: '123456',name: '123'));
        await untilCalled(()=>mockRegister.execute(userParamsRegister));
        verify(()=>mockRegister.execute(userParamsRegister));
      },
    );
  });
}
