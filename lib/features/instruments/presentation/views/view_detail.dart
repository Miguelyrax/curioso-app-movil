import 'package:flutter/material.dart';

import '../../../../core/themes/colors.dart';
import '../../../../routes.dart';
import '../blocs/detailbloc/detail_bloc_dart_bloc.dart';
import '../blocs/historicaldatabloc/historicaldatabloc_bloc.dart';
import '../widgets/chart.dart';
import '../widgets/modal_draggable.dart';
import '../widgets/row_detail.dart';

class ViewDetail extends StatefulWidget {
  const ViewDetail({
    Key? key,
    required this.stateHistorical,
    required this.stateDetail,
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: double.infinity,
                ),
                Chart(stateHistorical: widget.stateHistorical),
                const SizedBox(
                  height: 32,
                ),
                const SizedBox(
                  height: 16,
                ),
                RowDetail(
                  title: 'Name',
                  description: widget.stateDetail.detail.name,
                ),
                const SizedBox(
                  height: 16,
                ),
                RowDetail(
                  title: 'Currency',
                  description: widget.stateDetail.detail.currency,
                ),
                const SizedBox(
                  height: 16,
                ),
                RowDetail(
                  title: 'Country',
                  description: widget.stateDetail.detail.country,
                ),
                const SizedBox(
                  height: 16,
                ),
                RowDetail(
                  title: 'Exchange',
                  description: widget.stateDetail.detail.exchange,
                ),
                const SizedBox(
                  height: 16,
                ),
                RowDetail(
                  title: 'Industry',
                  description: widget.stateDetail.detail.finnhubIndustry,
                ),
                const SizedBox(
                  height: 16,
                ),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text('WebSite',
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(color: CuriosityColors.gray)
                      ),
                    ),
                    TextButton(
                      onPressed: (){
                        AppNavigator.push(Routes.web,widget.stateDetail.detail.weburl);
                      },
                      child: Text(widget.stateDetail.detail.weburl,
                          textAlign: TextAlign.end,
                          style: Theme.of(context)
                          .textTheme.headline6!
                          .copyWith(
                            color: CuriosityColors.beige
                          )
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 200,
                ),
              ],
            ),
          ),
        ),
        ModalDraggable(
          width: w,
          symbol: widget.stateDetail.detail.ticker,
        )
      ],
    );
  }
}
