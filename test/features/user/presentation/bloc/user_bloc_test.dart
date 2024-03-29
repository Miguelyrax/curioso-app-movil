
import 'package:bloc_test/bloc_test.dart';
import 'package:curioso_app/core/usecases/usecase.dart';
import 'package:curioso_app/features/user/domain/entities/user.dart';
import 'package:curioso_app/features/user/domain/usecases/login.dart';
import 'package:curioso_app/features/user/domain/usecases/post_edit_user.dart';
import 'package:curioso_app/features/user/domain/usecases/put_profile.dart';
import 'package:curioso_app/features/user/domain/usecases/register.dart';
import 'package:curioso_app/features/user/domain/usecases/renew.dart';
import 'package:curioso_app/features/user/presentation/blocs/userbloc/user_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockLogin extends Mock implements Login{}
class MockRegister extends Mock implements Register{}
class MockRenew extends Mock implements Renew{}
class MockPutProfile extends Mock implements PutProfile{}
class MockPostEditUser extends Mock implements PostEditUser{}
void main() {
  late MockLogin mockLogin;
  late MockRegister mockRegister;
  late MockRenew mockRenew;
  late MockPutProfile mockPutProfile;
  late PostEditUser postEditUser;
  late UserBloc bloc;

  setUp(() {
    mockLogin = MockLogin();
    mockRegister = MockRegister();
    mockRenew = MockRenew();
    mockPutProfile = MockPutProfile();
    postEditUser = MockPostEditUser();
    bloc = UserBloc(mockLogin,mockRegister,mockRenew,mockPutProfile,postEditUser);
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
          .thenAnswer((_) async =>  const Right(data));
          bloc.add(const OnUserLoaded(email: 'miguel@albanez.com', password: '123456'));
          await untilCalled(()=>mockLogin.execute(userParams));
          verify(()=>mockLogin.execute(userParams));
        },
      );

      blocTest('should emit [loading,has data] when data from login is gotten successfully',
      build: (){
        when(()=>mockLogin.execute(userParams)).thenAnswer((_) async=>const Right(data));
        return bloc;
      },
      act: (UserBloc uBloc)=>uBloc.add(const OnUserLoaded(email: 'miguel@albanez.com', password: '123456')),
      wait: const Duration(milliseconds: 500),
      expect: ()=>[
        UserLoading(),
        UserHasData(data)
      ],
      verify: (UserBloc uBloc){
       verify(()=>mockLogin.execute(userParams));
      }
      
      );

  });
  group(
    'renew', (){
      test(
        "should get data from usecase renew",
        () async {
          when(()=>mockRenew.execute(NoParams()))
          .thenAnswer((_) async => const Right(data));
          bloc.add( OnUserRenew());
          await untilCalled(()=>mockRenew.execute(NoParams()));
          verify(()=>mockRenew.execute(NoParams()));
        },
      );

      blocTest('should emit [loading,has data] when data from renew is gotten successfully',
      build: (){
        when(()=>mockRenew.execute(NoParams())).thenAnswer((_) async => const Right(data));
        return bloc;
      },
      act: (UserBloc uBloc)=>uBloc.add(OnUserRenew()),
      wait: const Duration(milliseconds: 500),
      expect: ()=>[
        UserLoading(),
        const UserHasData(data)
      ],
      verify: (UserBloc uBloc){
       verify(()=>mockRenew.execute(NoParams()));
      }
      
      );

  });
  group('register', 
  (){
    final userParamsRegister=UserParams(email: 'miguel@albanez.com', password: '123456',name: '123');
    test(
      "should get data from register",
      () async {
        when(()=>mockRegister.execute(userParamsRegister)).thenAnswer((invocation) async =>const Right(data));
        bloc.add(const OnUserRegister(email: 'miguel@albanez.com', password: '123456',name: '123'));
        await untilCalled(()=>mockRegister.execute(userParamsRegister));
        verify(()=>mockRegister.execute(userParamsRegister));
      },
    );
    blocTest(
      'emits [UserLoading,UserHasData] when data from renew is gotten successfully',
      build: () {
        when(()=>mockRegister.execute(userParamsRegister))
        .thenAnswer((_) async => const Right(data));
        return bloc;
      },
      act: (UserBloc blocc) => blocc.add(const OnUserRegister(email: 'miguel@albanez.com', password: '123456',name: '123')),
      expect: () => [
        UserLoading(),
        const UserHasData(data)
      ],
      verify: (_) async {
      verify(() => mockRegister.execute(userParamsRegister));
      },
    );
  });

}
