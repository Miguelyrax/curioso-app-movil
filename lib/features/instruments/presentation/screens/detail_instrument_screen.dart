import 'package:curioso_app/core/themes/colors.dart';
import 'package:curioso_app/features/instruments/presentation/blocs/historicaldatabloc/historicaldatabloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/detailbloc/detail_bloc_dart_bloc.dart';
import '../widgets/chart.dart';
import '../widgets/modal_draggable.dart';
import '../widgets/row_detail.dart';

class DetailInstrumentScreen extends StatelessWidget {
  const DetailInstrumentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: CuriosityColors.dark,
      child: BlocBuilder<DetailBloc, DetailState>(
        builder: (context, state) {
          if(state is DetailLoading){
            return const Center(child: SizedBox(child: CircularProgressIndicator(color: CuriosityColors.crystalblue,),));
          }
          else if(state is DetailError){
            return Center(child: Text(state.message),);
          }else if(state is DetailHasData){
            
            return DetailInstrumentView(stateDetail: state,);
          }
          return const SizedBox();
        },
      ),
    );
  }
}

class DetailInstrumentView extends StatelessWidget {
  const DetailInstrumentView({Key? key, required this.stateDetail}) : super(key: key);
  final DetailHasData stateDetail;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: CuriosityColors.dark,
        ),
        backgroundColor: CuriosityColors.dark,
        body: BlocBuilder<HistoricaldataBloc, HistoricaldataState>(
          builder: (context, state) {
            if (state is HistoricaldataILoading) {
                return const CircularProgressIndicator(
                  color: CuriosityColors.crystalblue,
                );
            }
            if (state is HistoricaldataError) {
              return SizedBox(
                child: Center(
                  child: Text(state.message),
                ),
              );
            }
            if(state is HistoricaldataHasData){
              return ViewDetail(stateDetail: stateDetail, stateHistorical: state,);
            }
            return const SizedBox(
              child: Center(
                child: Text('Hola Mundo'),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ViewDetail extends StatefulWidget {
  const ViewDetail({
    Key? key,
    required this.stateHistorical,
    required  this.stateDetail,
  }) : super(key: key);

  final HistoricaldataHasData stateHistorical;
  final DetailHasData stateDetail;

  @override
  State<ViewDetail> createState() => _ViewDetailState();
}

class _ViewDetailState extends State<ViewDetail> {
  @override
  void initState() {
    // WidgetsBinding.instance?.addPostFrameCallback((timeStamp) { 
    //   showmodal(context);
    // });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
      final w = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: double.infinity,
              ),
              Chart(stateHistorical:widget.stateHistorical),
              const SizedBox(
                height: 32,
              ),
              RowDetail(
                title: 'Pais',
                description: widget.stateDetail.detail.country ,
              ),
              const SizedBox(
                height: 16,
              ),
              RowDetail(
                title: 'Currency',
                description: widget.stateDetail.detail.currency ,
              ),
              const SizedBox(
                height: 16,
              ),
              RowDetail(
                title: 'Nombre',
                description: widget.stateDetail.detail.name ,
              ),
              const SizedBox(
                height: 16,
              ),
              RowDetail(
                title: 'Exchange',
                description: widget.stateDetail.detail.exchange ,
              ),
              const SizedBox(
                height: 16,
              ),
              const RowDetail(
                title: 'Logo',
                description: 'US',
              ),
              const SizedBox(
                height: 16,
              ),
              
            ],
          ),
        ),
        ModalDraggable(width: w,symbol:widget.stateDetail.detail.ticker ,)
      ],
    );
  }
}
