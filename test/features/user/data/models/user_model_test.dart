import 'package:curioso_app/features/user/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late UserModel model;

  setUp(() {
    model = const UserModel(
    name: 'miguel',
    email: 'miguel@albanez.com',
    status: true,
    token: '123'
    );
  });

  test(
    "should be a class of UserModel",
    () async {
      expect(model, isA<UserModel>());
    },
  );
}
