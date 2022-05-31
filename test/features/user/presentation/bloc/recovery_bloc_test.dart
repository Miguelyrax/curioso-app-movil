import 'package:bloc_test/bloc_test.dart';
import 'package:curioso_app/features/user/domain/usecases/post_recovery_password.dart';
import 'package:curioso_app/features/user/domain/usecases/post_send_email.dart';
import 'package:curioso_app/features/user/presentation/blocs/recoverybloc/recovery_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
class MockPostRecoveryPassword extends Mock implements PostRecoveryPassword{}
class MockPostSendEmail extends Mock implements PostSendEmail{}
void main() {
  late MockPostRecoveryPassword mockPostRecoveryPassword;
  late MockPostSendEmail mockPostSendEmail;
  late RecoveryBloc bloc;

  setUp(() {
    mockPostRecoveryPassword = MockPostRecoveryPassword();
    mockPostSendEmail = MockPostSendEmail();
    bloc = RecoveryBloc(mockPostRecoveryPassword,mockPostSendEmail);
  });
  test(
    "initial state should be empty",
    () async {
      expect(bloc.state, isA<RecoveryInitial>());
    },
  );

  group('recovery', () {
    const params = RecoveryParams(email: '123',code: 123);
    void setUpBloc()=>when(()=>mockPostRecoveryPassword.execute(params))
        .thenAnswer((_) async => const Right(true));
    test(
      "should return data from the usecase",
      () async {
        setUpBloc();
        bloc.add(const OnRecoveryEmail(email: '123', code: 123));
        await untilCalled(()=>mockPostRecoveryPassword.execute(params));
        verify(()=>mockPostRecoveryPassword.execute(params));
      },
    );
    blocTest(
    'emits [RecoveryLoaded,RecoveryEndLoaded] when OnRecoveryEmail is called.',
    build: (){
      setUpBloc();
      return bloc;
    },
    act: (RecoveryBloc blocc) => blocc.add(const OnRecoveryEmail(email: '123', code: 123)),
    expect: () => [
      RecoveryLoaded(),
      RecoverySendSuccess()
    ],
    verify: (_) async {
    verify(() => mockPostRecoveryPassword.execute(params)).called(1);
    },
    );
  });
  group('send', () {
    const params = RecoveryParams(email: '123');
    void setUpBloc()=>when(()=>mockPostSendEmail.execute(params))
        .thenAnswer((_) async => const Right(true));
    test(
      "should return data from the usecase",
      () async {
        setUpBloc();
        bloc.add(const OnSendEmail('123'));
        await untilCalled(()=>mockPostSendEmail.execute(params));
        verify(()=>mockPostSendEmail.execute(params));
      },
    );
    blocTest(
    'emits [RecoveryLoaded,RecoveryEndLoaded] when OnRecoveryEmail is called.',
    build: (){
      setUpBloc();
      return bloc;
    },
    act: (RecoveryBloc blocc) => blocc.add(const OnSendEmail('123')),
    expect: () => [
      RecoveryLoaded(),
      RecoveryEndLoaded()
    ],
    verify: (_) async {
    verify(() => mockPostSendEmail.execute(params)).called(1);
    },
    );
  });
}
