import 'package:curioso_app/features/instruments/domain/repositories/instrument_repository.dart';
import 'package:curioso_app/features/instruments/domain/usecases/delete_favourite.dart';
import 'package:curioso_app/features/instruments/domain/usecases/post_favourite.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
class MockInstrumentRepository extends Mock implements InstrumentRepository{}
void main() {
  late MockInstrumentRepository mockInstrumentRepository;
  late DeleteFavourite usecase;

  setUp(() {
    mockInstrumentRepository = MockInstrumentRepository();
    usecase = DeleteFavourite(mockInstrumentRepository);
  });
  const id='123';
  test(
    "should return usecase from repository",
    () async {
      when(()=>mockInstrumentRepository.deleteFavourite(id))
      .thenAnswer((_) async => const Right(true));
      final result = await usecase.execute(const ParamsFavourite(id));
      verify(()=>mockInstrumentRepository.deleteFavourite(id));
      expect(result, equals(const Right(true)));
    },
  );
}
