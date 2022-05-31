import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/themes/colors.dart';
import '../../../../routes.dart';
import '../../../news/presentation/bloc/news/news_bloc.dart';
class ModalContents extends StatefulWidget {
  const ModalContents({
    Key? key,
    required this.width,
    required this.symbol, required this.dragEnable,
  }) : super(key: key);

  final double width;
  final String symbol;
  final bool dragEnable;

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
      padding: const EdgeInsets.all(16),
      child: ListView(
        shrinkWrap: true,
        physics:widget.dragEnable? const BouncingScrollPhysics():const NeverScrollableScrollPhysics(),
        children: [
          const SizedBox(height: 34),
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
