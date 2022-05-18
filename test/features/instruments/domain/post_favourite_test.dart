
import 'package:curioso_app/features/instruments/domain/repositories/instrument_repository.dart';
import 'package:curioso_app/features/instruments/domain/usecases/post_favourite.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../fixture/constants.dart';

class MockInstrumentRepository extends Mock implements InstrumentRepository{}
void main() {
  late MockInstrumentRepository mockInstrumentRepository;
  late PostFavourite usecase;

  setUp(() {
    mockInstrumentRepository = MockInstrumentRepository();
    usecase = PostFavourite(mockInstrumentRepository);
  });
  const data = 'asd';

  test(
    "should get usecase from repository",
    () async {
      when(()=>mockInstrumentRepository.postFavourite(data))
      .thenAnswer((_) async => const Right(dataModel));
      final result = await usecase.execute(const ParamsFavourite('asd'));
      expect(result, equals(const Right(dataModel)));
    },
  );
}
