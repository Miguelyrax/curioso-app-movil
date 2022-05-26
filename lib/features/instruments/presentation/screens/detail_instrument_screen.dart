import 'package:curioso_app/core/themes/colors.dart';
import 'package:curioso_app/features/instruments/presentation/blocs/favourites/favourites_bloc.dart';
import 'package:curioso_app/features/instruments/presentation/blocs/historicaldatabloc/historicaldatabloc_bloc.dart';
import 'package:curioso_app/routes.dart';
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
          if (state is DetailLoading) {
            return const Center(
                child: SizedBox(
              child: CircularProgressIndicator(
                color: CuriosityColors.crystalblue,
              ),
            ));
          } else if (state is DetailError) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is DetailHasData) {
            return DetailInstrumentView(
              stateDetail: state,
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

class DetailInstrumentView extends StatelessWidget {
  const DetailInstrumentView({Key? key, required this.stateDetail})
      : super(key: key);
  final DetailHasData stateDetail;
  @override
  Widget build(BuildContext context) {
    final favouriteBloc = BlocProvider.of<FavouritesBloc>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: CuriosityColors.dark,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                      width: 32,
                      height: 32,
                      image: NetworkImage(stateDetail.detail.logo)
                    ),
                    const SizedBox(width: 16,),
              Flexible(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Text(stateDetail.detail.name,style: Theme.of(context).textTheme.headline5,)),
              ),
                    const SizedBox(width: 30,),
            ],
          ),
          leading: IconButton(
            onPressed: ()=>AppNavigator.pop(),
            icon:const Icon(Icons.arrow_back_ios,color: Colors.white,)),
          actions: [
            BlocBuilder<FavouritesBloc, FavouritesState>(
              builder: (context, state) {
                if(state is FavouritesHasData){
                  final isFavourite=state.favoritos.where((f) => f.instrument.id==stateDetail.id).isNotEmpty;
                return GestureDetector(
                  onTap:isFavourite?() async {
                    favouriteBloc.add(OnFavouriteDelete(stateDetail.id));
                  }: () async {
                    favouriteBloc.add(OnFavouriteAdd(stateDetail.id));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Icon(
                      isFavourite?Icons.favorite_rounded
                                 :Icons.favorite_outline,
                      color: isFavourite?CuriosityColors.orangered
                                         :CuriosityColors.white,),
                  ),
                );
                }else if(state is FavouritesInitial){
                  favouriteBloc.add(OnFavouritesLoaded());
                  return const SizedBox();
                }
                else{
                  return const SizedBox();
                }
              },
            )
          ],
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
            if (state is HistoricaldataHasData) {
              return ViewDetail(
                stateDetail: stateDetail,
                stateHistorical: state,
              );
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
