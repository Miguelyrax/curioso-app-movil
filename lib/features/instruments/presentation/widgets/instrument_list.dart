
import 'package:curioso_app/features/instruments/presentation/blocs/detailbloc/detail_bloc_dart_bloc.dart';
import 'package:curioso_app/features/instruments/presentation/blocs/historicaldatabloc/historicaldatabloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/themes/colors.dart';
import '../../../../routes.dart';
import '../blocs/instrumentbloc/instrument_bloc.dart';
import 'card_widget.dart';

class InstrumentList extends StatefulWidget {
  const InstrumentList({
    Key? key, required this.controller,
  }) : super(key: key);
  final TextEditingController controller;

  @override
  State<InstrumentList> createState() => _InstrumentListState();
}

class _InstrumentListState extends State<InstrumentList> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    final blocProvider=BlocProvider.of<InstrumentBloc>(context,listen: false);
    blocProvider.add(OnInstrumentLoaded());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final detailBloc=BlocProvider.of<DetailBloc>(context,listen: false);
    final historicalBloc=BlocProvider.of<HistoricaldataBloc>(context,listen: false);
    return BlocBuilder<InstrumentBloc, InstrumentState>(
      builder: (context, state) {
        if(state is InstrumentLoading){
          return const SliverToBoxAdapter(
            child: Center(
              child: SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(
                  color: CuriosityColors.aquagreen,
                ),
              ),
            ),
          );
        }
        else if(state is InstrumentError){
          return const SliverToBoxAdapter(
            child: Text('No se pudo cargar los instrumentos')
          );
        }
        else if (state is InstrumentHasData){
          final list = state.instruments.where((i) => i.name.toLowerCase().contains(widget.controller.text)).toList();
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (_,index){
                return GestureDetector(
                  onTap: (){
                    detailBloc.add(OnDetailLoaded(state.instruments[index]));
                    historicalBloc.add(OnHistoricalDataLoaded(state.instruments[index].symbol));
                    AppNavigator.push(Routes.detail);
                  },
                  child: CardWidget(instrument: list[index],),
                );
            },
          childCount: list.length
          )
        );
        }else{
          return const SliverToBoxAdapter(child: SizedBox());
        }
      },
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}

