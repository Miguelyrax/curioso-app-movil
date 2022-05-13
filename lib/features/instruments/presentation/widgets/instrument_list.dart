import 'package:curioso_app/features/instruments/presentation/blocs/detailbloc/detail_bloc_dart_bloc.dart';
import 'package:curioso_app/features/instruments/presentation/blocs/historicaldatabloc/historicaldatabloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/themes/colors.dart';
import '../../../../routes.dart';
import '../blocs/instrumentbloc/instrument_bloc.dart';

class InstrumentList extends StatefulWidget {
  const InstrumentList({
    Key? key,
  }) : super(key: key);

  @override
  State<InstrumentList> createState() => _InstrumentListState();
}

class _InstrumentListState extends State<InstrumentList> {
  @override
  void initState() {
    final blocProvider=BlocProvider.of<InstrumentBloc>(context,listen: false);
    blocProvider.add(OnInstrumentLoaded());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final detailBloc=BlocProvider.of<DetailBloc>(context,listen: false);
    final historicalBloc=BlocProvider.of<HistoricaldataBloc>(context,listen: false);
    return BlocBuilder<InstrumentBloc, InstrumentState>(
      builder: (context, state) {
        if(state is InstrumentLoading){
          return const SliverToBoxAdapter(
            child: SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(
                color: CuriosityColors.aquagreen,
              ),
            )
          );
        }
        else if(state is InstrumentError){
          return const SliverToBoxAdapter(
            child: Text('No se pudo cargar los instrumentos')
          );
        }
        else if (state is InstrumentHasData){
        return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return GestureDetector(
                  onTap: (){
                    detailBloc.add(OnDetailLoaded(state.instruments[index].symbol));
                    historicalBloc.add(OnHistoricalDataLoaded(state.instruments[index].symbol));
                    AppNavigator.push(Routes.detail);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: CuriosityColors.blackbeige
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(state.instruments[index].name,
                                  style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: CuriosityColors.beige)
                              ),
                              Text(state.instruments[index].symbol,
                                style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(color: CuriosityColors.gray)
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('322,83',
                                style: Theme.of(context).textTheme.headline5!
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }, childCount: state.instruments.length)
        );
        }else{
          return const SliverToBoxAdapter();
        }
      },
    );
  }
}
