import 'package:curioso_app/features/instruments/presentation/blocs/favourites/favourites_bloc.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/themes/colors.dart';
import '../../domain/entities/favourites.dart';
import '../widgets/card_widget.dart';

class FavouriteView extends StatefulWidget {
  const FavouriteView({Key? key}) : super(key: key);

  @override
  State<FavouriteView> createState() => _FavouriteViewState();
}

class _FavouriteViewState extends State<FavouriteView> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    final favouritesBloc = BlocProvider.of<FavouritesBloc>(context,listen: false);
    favouritesBloc.add(OnFavouritesLoaded());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Favoritos',
            style: Theme.of(context).textTheme.headline2!.copyWith(
                  fontWeight: FontWeight.bold,
                )),
        const SizedBox(
          height: 32,
        ),
        BlocBuilder<FavouritesBloc, FavouritesState>(
          builder: (context, state) {
            if(state is FavouritesLoading){
              return const Center(child: CircularProgressIndicator(),);
            }
            else if(state is FavouritesError){
              return Center(child: Text(state.message),);
            }
            else if(state is FavouritesHasData){
              final _items = state.favoritos;

            return Theme(
              data: Theme.of(context).copyWith(
                canvasColor: Colors.transparent,
                shadowColor: Colors.transparent,
              ),
              child: ReorderableListView(
                padding: const EdgeInsets.all(0),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                onReorder: (int oldIndex, int newIndex) {
                  setState(() {
                    if (oldIndex < newIndex) {
                    HapticFeedback.vibrate();
                      newIndex -= 1;
                    }
                    final Favourites item = _items.removeAt(oldIndex);
                    _items.insert(newIndex, item);
                  });
                },
                children: <Widget>[
                  for (int index = 0; index < _items.length; index += 1)
                    CardWidget(
            key: Key('$index'),
                   index: index,
                      dragHandle: true,
                      instrument: _items[index].instrument),
                    
                ],
              ),
            );
            }else{
              return const SizedBox();
            }
          },
        )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
