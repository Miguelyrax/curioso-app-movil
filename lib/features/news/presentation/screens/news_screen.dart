import 'package:curioso_app/features/news/presentation/bloc/general-news/generalnews_bloc.dart';
import 'package:curioso_app/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/themes/colors.dart';
import '../../domain/entities/news.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    final newsBloc = BlocProvider.of<GeneralnewsBloc>(context, listen: false);
    newsBloc.add(GeneralnewsLoading());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height,
      child: BlocBuilder<GeneralnewsBloc, GeneralnewsState>(
        builder: (context, state) {
          if(state is GeneralnewsLoaded){
            return const Center(child: CircularProgressIndicator());
          }
          if(state is GeneralnewsError){
            return Center(child: Text(state.message));
          }
          if(state is GeneralnewsHasData){
            return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Ultimas noticias',
                        style: Theme.of(context).textTheme.headline2!.copyWith(
                              fontWeight: FontWeight.bold,
                            )),
                    const SizedBox(
                      height: 32,
                    ),
                  ],
                ),
              ),
              SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (_, index) {
                      return New(noticia: state.news[index]);
                    },
                  childCount: state.news.length
                  )
              )
            ],
           );
          }else{
            return const SizedBox();
          }
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class New extends StatelessWidget {
  const New({
    Key? key, required this.noticia,
  }) : super(key: key);
  final News noticia;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        AppNavigator.push(Routes.web,noticia.url);
      },
      child: Container(
        padding: const EdgeInsets.only(bottom: 32),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16, vertical: 4
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(200),
                color: CuriosityColors.plate),
            child: Text(
              noticia.category,style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: CuriosityColors.beige
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Image(
                  width: 102,
                  height: 102,
                  fit: BoxFit.contain,
                  image: NetworkImage(
                      noticia.image
                  )
                ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(noticia.headline,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style:Theme.of(context)
                          .textTheme
                          .headline3!
                          .copyWith(
                            fontWeight: FontWeight.bold,
                          )
                    ),
                    Text(
                      noticia.summary,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style:
                            Theme.of(context).textTheme.headline6!
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
      ),
    );
  }
}
