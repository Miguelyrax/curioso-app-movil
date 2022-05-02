import 'package:curioso_app/core/usecases/usecase.dart';
import 'package:curioso_app/features/instruments/domain/entities/detail_instrument.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../repositories/instrument_repository.dart';

class GetDetail extends UseCase<Detail,Params>{
  final InstrumentRepository repository;

  GetDetail(this.repository);
  @override
  Future<Either<Failure, Detail>> execute(Params params) {
    return repository.getDetailInstrument(params.symbol);
  }

}

class Params extends Equatable{
  final String symbol;

  const Params({required this.symbol});

  @override
  List<Object?> get props => [symbol];
}