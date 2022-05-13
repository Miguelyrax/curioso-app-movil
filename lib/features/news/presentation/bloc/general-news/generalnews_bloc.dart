import 'package:bloc/bloc.dart';
import 'package:curioso_app/features/news/domain/entities/news.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/usecases/usecase.dart';
import '../../../domain/usecases/get_news_general.dart';

part 'generalnews_event.dart';
part 'generalnews_state.dart';

class GeneralnewsBloc extends Bloc<GeneralnewsEvent, GeneralnewsState> {
  final GetNewsGeneral getNewsGeneral;
  GeneralnewsBloc({
  required this.getNewsGeneral, 
  }) : super(GeneralnewsInitial()) {
    on<GeneralnewsEvent>((event, emit) {
      
    });
    on<GeneralnewsLoading>((event,emit)async{
      emit(GeneralnewsLoaded());
      final result=await getNewsGeneral.execute(NoParams());
      result.fold(
        (failure) => emit(const GeneralnewsError('Error al cargar las noticias')),
        (data) => emit(GeneralnewsHasData(data))
      );
    }); 
  }
}
