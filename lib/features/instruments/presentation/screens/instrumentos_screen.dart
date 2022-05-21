import 'package:flutter/material.dart';

import '../../../../core/themes/colors.dart';
import '../widgets/instrument_list.dart';
class InstrumentosScreen extends StatefulWidget {
  const InstrumentosScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<InstrumentosScreen> createState() => _InstrumentosScreenState();
}

class _InstrumentosScreenState extends State<InstrumentosScreen> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Curiosity',
                style:Theme.of(context)
                .textTheme
                .headline2!
                .copyWith(
                  fontWeight: FontWeight.bold,
                  color: CuriosityColors.beige
                )
              ),
              Text('App',
                style:Theme.of(context)
                .textTheme
                .headline2!
                .copyWith(
                  fontWeight: FontWeight.bold,
                )
              ),
              Text('1 de mayo',
                style:Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(
                  fontWeight: FontWeight.bold,
                  color: CuriosityColors.gray
                )
              ),
              const SizedBox(height: 8,),
              SizedBox(
                height: 30,
                child: TextFormField(
                  decoration:const InputDecoration(
                    hintText: 'Buscar'
                  ),
                )
              ),
              const SizedBox(height: 32,),
              Text('Instrumentos',
                style:Theme.of(context)
                .textTheme
                .headline2!
                .copyWith(
                  fontWeight: FontWeight.bold,
                )
              ),
              const SizedBox(height: 16,),
            ],
          ),
        ),
        const InstrumentList(),
        const SliverToBoxAdapter(
          child: SizedBox(height: 100,)
        )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}