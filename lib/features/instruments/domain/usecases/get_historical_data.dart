import 'package:curioso_app/core/error/failure.dart';
import 'package:curioso_app/core/usecases/usecase.dart';
import 'package:curioso_app/features/instruments/domain/entities/historical_data.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../repositories/instrument_repository.dart';

class GetHistoricalData extends UseCase<HistorialData,Params>{
  final InstrumentRepository repository;

  GetHistoricalData(this.repository);
  @override
  Future<Either<Failure, HistorialData>> execute(Params params) {
    return repository.getHistoricalData(params.symbol);
  }

}
class Params extends Equatable{
  final String symbol;

  const Params({required this.symbol});

  @override
  List<Object?> get props => [symbol];
}