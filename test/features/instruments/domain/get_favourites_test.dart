import 'package:curioso_app/core/usecases/usecase.dart';
import 'package:curioso_app/features/instruments/domain/repositories/instrument_repository.dart';
import 'package:curioso_app/features/instruments/domain/usecases/get_favourites.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../fixture/constants.dart';

class MockInstrumentRepository extends Mock implements InstrumentRepository{}
void main() {
  late InstrumentRepository mockInstrumentRepository;
  late GetFavourites usecase;

  setUp(() {
    mockInstrumentRepository = MockInstrumentRepository();
    usecase = GetFavourites(mockInstrumentRepository);
  });

  


  test(
    "should get the right side of usecase",
    () async {
      when(()=>mockInstrumentRepository.getFavourites())
      .thenAnswer((_) async =>  Right(data));
      final result=await usecase.execute(NoParams());
      expect(result, equals(Right(data)));
    },
  );
}
