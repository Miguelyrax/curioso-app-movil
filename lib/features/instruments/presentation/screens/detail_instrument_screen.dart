import 'package:curioso_app/core/themes/colors.dart';
import 'package:curioso_app/features/instruments/presentation/blocs/historicaldatabloc/historicaldatabloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import '../../../../core/utils/utils.dart';
import '../blocs/detailbloc/detail_bloc_dart_bloc.dart';

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

class ViewDetail extends StatelessWidget {
  const ViewDetail({
    Key? key,
    required this.stateHistorical,
    required  this.stateDetail,
  }) : super(key: key);

  final HistoricaldataHasData stateHistorical;
  final DetailHasData stateDetail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: double.infinity,
          ),
          Chart(stateHistorical:stateHistorical),
          const SizedBox(
            height: 32,
          ),
          RowDetail(
            title: 'Pais',
            description: stateDetail.detail.country ,
          ),
          const SizedBox(
            height: 16,
          ),
          RowDetail(
            title: 'Currency',
            description: stateDetail.detail.currency ,
          ),
          const SizedBox(
            height: 16,
          ),
          RowDetail(
            title: 'Nombre',
            description: stateDetail.detail.name ,
          ),
          const SizedBox(
            height: 16,
          ),
          RowDetail(
            title: 'Exchange',
            description: stateDetail.detail.exchange ,
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
    );
  }
}

class Chart extends StatelessWidget {
   Chart({
    Key? key, required this.stateHistorical,
  }) : super(key: key);
  double minPrice = 0;
  double maxPrice = 0;
  List<SalesData> chartSalesData = [];
  final HistoricaldataHasData stateHistorical;
  final GlobalKey<_CustomTooltipState> _customTooltipState =
      GlobalKey<_CustomTooltipState>();
  final Utils utils=Utils();
  @override
  Widget build(BuildContext context) {
    minPrice = utils.checkDouble(stateHistorical.historialData.c.first);
    maxPrice = utils.checkDouble(stateHistorical.historialData.c.first);
     for (var i = 0; i < stateHistorical.historialData.t.length; i++) {

          DateTime date = DateTime.fromMillisecondsSinceEpoch(stateHistorical.historialData.t[i]*1000);
          double price = utils.checkDouble(stateHistorical.historialData.c[i]);

          if(minPrice > price) {
            minPrice = price;
          }

          if(maxPrice < price) {
            maxPrice = price;
          }

          if(price != 0.0) {
            chartSalesData.add(SalesData(date, price));
          }
        }
        double delMinPrice = minPrice * 0.01;
        minPrice = minPrice - delMinPrice;

        double delMaxPrice = maxPrice * 0.01;
        maxPrice = maxPrice + delMaxPrice;
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
        return Column(
          children: [
            Text('Valor',
               style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(color: CuriosityColors.gray)),
            CustomTooltip(
              key: _customTooltipState, maxWidth: constraints.maxWidth),
              
              _Grafico(
                chartSalesData: chartSalesData,
                constraints: constraints,
                customTooltipState: _customTooltipState,
                lineColor: CuriosityColors.aquagreen,
                maxPrice: maxPrice,
                minPrice: minPrice,
                
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  7,
                  (index) => Flexible(
                    child: Text('1M',
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(color: CuriosityColors.gray)),
                  ),
                ),
              ),
          ],
        );
      }
    );
  }
}

class RowDetail extends StatelessWidget {
  const RowDetail({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);
  final String title;
  final String description;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(title,
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: CuriosityColors.gray)),
        ),
        Expanded(
          child: Text(description,
              textAlign: TextAlign.end,
              style: Theme.of(context).textTheme.headline6!),
        ),
      ],
    );
  }
}

class SalesData {
  SalesData(this.date, this.price);
  final DateTime date;
  final double price;
}

class _Grafico extends StatefulWidget {
  const _Grafico({
    Key? key,
    required this.constraints,
    required this.minPrice,
    required this.maxPrice,
    required this.lineColor,
    required this.chartSalesData,
    required this.customTooltipState,
  }) : super(key: key);
  final BoxConstraints constraints;
  final double minPrice;
  final double maxPrice;
  final GlobalKey<_CustomTooltipState> customTooltipState;
  final Color lineColor;
  final List<SalesData> chartSalesData;

  @override
  State<_Grafico> createState() => _GraficoState();
}

class _GraficoState extends State<_Grafico> {
  

    bool selected=false;
  @override
  Widget build(BuildContext context) {
    return Container(
              height: 250,
              color: Colors.transparent,
                  child:
                    Listener(
                      onPointerDown: (value){
                        selected=true;
                        setState(() {
                          
                        });
                      },
                      onPointerUp: (value){
                        selected=false;
                        setState(() {
                          
                        });
                      },
                      child: SfCartesianChart(
                        backgroundColor: Colors.transparent,
                        plotAreaBorderColor: Colors.transparent,
                        primaryXAxis: DateTimeAxis(
                          majorGridLines:
                              const MajorGridLines(color: Colors.transparent),
                          isVisible: false,
                          dateFormat: DateFormat('kk:mm')
                        ),
                        primaryYAxis: NumericAxis(
                          majorGridLines: const MajorGridLines(width: 0.25,dashArray: [2,3]),
                          isVisible: false,
                          minimum: widget.minPrice,
                          maximum: widget.maxPrice,
                          numberFormat: NumberFormat.compact(locale: 'eu')
                        ),
                        onTrackballPositionChanging: (TrackballArgs args) =>
                            trackball(args),
                        onChartTouchInteractionUp:
                            (ChartTouchInteractionArgs args) =>
                                chartTouchInteractionArgsUp(args),
                        onChartTouchInteractionDown:
                            (ChartTouchInteractionArgs args) =>
                                chartTouchInteractionArgsDown(args),
                        trackballBehavior: TrackballBehavior(
                          enable: true,
                          lineColor: widget.lineColor,
                          lineWidth: 5,
                          markerSettings: TrackballMarkerSettings(
                            markerVisibility: TrackballVisibilityMode.visible,
                            color: widget.lineColor,
                          ),
                          tooltipSettings: const InteractiveTooltip(enable: false),
                          activationMode: ActivationMode.singleTap,
                        ),
                        series: <ChartSeries>[
                        // Renders area chart
                        AreaSeries<SalesData, DateTime>(
                            dataSource: widget.chartSalesData,
                            xValueMapper: (SalesData sales, _) => sales.date,
                            yValueMapper: (SalesData sales, _) => sales.price,
                            borderColor:CuriosityColors.aquagreen,
                            borderWidth: 5,
                            gradient:const LinearGradient(
                              colors: [
                                CuriosityColors.dark,
                                CuriosityColors.dark,
                              ]
                            )
                        )
                      ]
                                      ),
                    )
          );
  }
  void trackball(TrackballArgs args) {
    CartesianChartPoint<dynamic>? chartDataPoint = args.chartPointInfo.chartDataPoint;
    double? xPosition = args.chartPointInfo.xPosition;

    widget.customTooltipState.currentState!.callbackSetStateInfo(
        xPosition,
        true,
        chartDataPoint!);
  }
   void chartTouchInteractionArgsUp(ChartTouchInteractionArgs args) {
    widget.customTooltipState.currentState!
        .callbackSetStateVisible(false);
  }

  void chartTouchInteractionArgsDown(ChartTouchInteractionArgs args) {
    widget.customTooltipState.currentState!
        .callbackSetStateVisible(true);
  }
}

class CustomTooltip extends StatefulWidget {

  CustomTooltip({Key? key,
    required this.maxWidth,
  }) : super(key: key);

  double? positionTooltipChart;
  bool? isVisible = false;
  String? price;
  String? date;
  final double maxWidth;

  @override
  _CustomTooltipState createState() => _CustomTooltipState();
}

class _CustomTooltipState extends State<CustomTooltip> {
  final Utils utils = Utils();

  @override
  Widget build(BuildContext context) {
    return (!widget.isVisible!)
        ? Container(
          margin:const EdgeInsets.only(top: 16),
            child: Text('0',
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        fontWeight: FontWeight.bold,
                      )),
          )
        : Container(
            color: Colors.transparent,
            child: Column(
              children: [
                
              const SizedBox(
                height: 16,
              ),
              Text('${utils.numberFormat(utils.checkDouble(widget.price??0.0), 2, ',', '.', false)}',
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        fontWeight: FontWeight.bold,
                      )),
                Text(widget.date??'',
                    style: const TextStyle(color: Color(0xffA7AAAD), fontSize: 11))
              ],
            )
          );
  }

  void callbackSetStateVisible(isVisible) {
    widget.isVisible = isVisible;
    setState(() {});
  }

  void callbackSetStateInfo(
      positionTooltipChart, isVisible, CartesianChartPoint<dynamic> info) {
    double w = widget.maxWidth;

    if (positionTooltipChart < 60.0) {
      positionTooltipChart = 0.0;
    } else {
      positionTooltipChart = positionTooltipChart - 50.0;
    }

    if (positionTooltipChart > (w - 120)) {
      positionTooltipChart = w - 120;
    }

    widget.positionTooltipChart = positionTooltipChart;
    widget.isVisible = isVisible;

    widget.date = DateFormat('dd/MM/yyyy kk:mm:ss').format(info.x);
    widget.price = info.y.toString();

    setState(() {});
  }
}
