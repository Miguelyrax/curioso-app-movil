import 'package:curioso_app/core/themes/colors.dart';
import 'package:curioso_app/features/news/presentation/bloc/news/news_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../routes.dart';

// Class responsible for generating the modal page when clicked on a type
class ModalDraggable extends StatelessWidget {
  const ModalDraggable({
    Key? key,
    required this.width,
    required this.symbol,
  }) : super(key: key);

  final double width;
  final String symbol;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        initialChildSize: 0.15,
        minChildSize: 0.15,
        maxChildSize: 0.92,
        expand: true,
        builder: (b, s) {
          return Container(
            decoration: const BoxDecoration(
                color: CuriosityColors.blackbeige,
                borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20))
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  child: Container(
                    margin:
                        const EdgeInsets.only(top: 10, left: 150, right: 150),
                    height: 5,
                    width: 200,
                    color: CuriosityColors.mirage,
                  ),
                ),
                ModalContents(
                  width: width,
                  scroller: s,
                  symbol: symbol,
                ), 
              ],
            ),
          );
        });
  }
}

// Class responsible for creating the list present in the modal page consisting of various effects related to the selected type
class ModalContents extends StatefulWidget {
  const ModalContents({
    Key? key,
    required this.width,
    required this.scroller,
    required this.symbol,
  }) : super(key: key);

  final double width;
  final ScrollController scroller;
  final String symbol;

  @override
  _ModalContentsState createState() => _ModalContentsState();
}

class _ModalContentsState extends State<ModalContents> {

  @override
  void initState() {
    final newsBloc = BlocProvider.of<NewsBloc>(context, listen: false);
    newsBloc.add(NewsLoadedSymbol(widget.symbol));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        controller: widget.scroller,
        children: [
          const SizedBox(height: 10),
          Text('Noticias del instrumento',
                style: Theme.of(context).textTheme.headline3!
          ),
          Text(widget.symbol,
                style: Theme.of(context).textTheme.headline5!
                .copyWith(color: CuriosityColors.gray)
          ),
          const SizedBox(height: 30),
          BlocBuilder<NewsBloc, NewsState>(
            builder: (context, state) {
              if(state is NewsLoading){
                return const Center(
                  child: CircularProgressIndicator(
                    color: CuriosityColors.crystalblue,
                  ),
                );
              }
              else if(state is NewsError){
                return SizedBox(
                  child: Text(state.message),
                );
              }
              else if(state is NewsHasData){
                return ListView.separated(
                  separatorBuilder: (_,i){
                    return const SizedBox(height: 20,);
                  },
                  itemCount: state.news.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (_,index){
                    return GestureDetector(
                      onTap: (){
                        AppNavigator.push(Routes.web,state.news[index].url);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(state.news[index].category,
                            style: Theme.of(context).textTheme.headline3!
                            .copyWith(fontSize: 12, color: CuriosityColors.gray)
                          ),
                          const SizedBox(height: 4,),
                          Text(state.news[index].headline,
                            style: Theme.of(context).textTheme.headline5!
                          ),
                          const SizedBox(height: 4,),
                          Text(state.news[index].summary,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.headline3!
                            .copyWith(fontSize: 12, color: CuriosityColors.gray)
                          ),
                        ],
                      ),
                    );
                  });
              }
              return Container();
            },
          )
        ],
      ),
    );
  }
}
